# == Schema Information
#
# Table name: tablelesses
#
#  name          :string
#  email_address :string
#  message       :text
#

class Contact < Tableless
  column :name,          :string
  column :email_address, :string
  column :message,       :text
  validates_presence_of  :name, :email_address, :message
  validates_format_of    :email_address,
                         :with => %r{\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z}i, :message => "should be like xxx@yyy.zzz"
end
