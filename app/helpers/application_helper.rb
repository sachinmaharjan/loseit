module ApplicationHelper
  
  def currentpage(path)
    current_page?(path) ? "active" : ""
  end
end
