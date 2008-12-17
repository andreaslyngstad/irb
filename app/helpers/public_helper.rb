module PublicHelper
  
  def children_nested(pages)
    returning "" do |html|
       html << "<ul>"
      unless pages.empty?
        pages.each do |page|
        html << "<li>#{link_to(page.navlabel, view_page_path(page.name))}"
        html << children_nested(page.children) unless page.children.empty?
        html << "</li>"
        end
        html << "</ul>"   
     end
    end
  end
  
  def public_nested(pages)
    returning "" do |html|
      unless pages.empty?
        pages.each do |page|
         html << "<ul>"
           if !page.child?
           html << "<li>#{link_to(page.navlabel, view_page_path(page.name))}"           
           end
        html << children_nested(page.children) unless page.children.empty?
        html << "</li>"
        html << "</ul>"
        end
      end
    end
  end 
end
