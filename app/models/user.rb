require 'digest'


class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :reset_code, :reset_code_until

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence => true,
                  :length   => { :maximum => 50 }

  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive =>  false}

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  validates_uniqueness_of :member_id

  before_save :encrypt_password
  before_create :before_validation_on_create
  has_many :exercises, :order => "created_at DESC"

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def create_reset_code
    self.attributes = {:reset_code_until => 7.day.from_now,
                       :reset_code => Digest::SHA1.hexdigest( "#{self.email}#{Time.now.to_s.split(//).sort_by {rand}.join}" )}
    save(false)
  end

  private

    def encrypt_password
#      self.salt = make_salt unless has_password?(password)
#      self.encrypted_password = encrypt(password)
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) if password.present?
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

  protected
    def before_validation_on_create
      self.member_id = rand(36**8).to_s(36) if self.new_record? and self.member_id.nil?
    end
end
