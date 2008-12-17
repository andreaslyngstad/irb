module PagesHelper
  def padded_page_name(page,repeat = 2,padder = "&nbsp;")
    returning "" do |result|
      (page.ancestors.length*repeat).times { result << padder }
      result << h(page.name)
    end
  end

  
  def nested_set_list_for(pages)
    returning "" do |html|
      unless pages.empty?
        html << "<ul>" 
        pages.each do |page|
          html << "<li>#{link_to(page.name, page)}&nbsp;"
          html << "|&nbsp;#{link_to '&#8657;', move_higher_page_path(page), :method => :post}"
          html << "#{link_to '&#8659;', move_lower_page_path(page), :method => :post}"
          html << "&nbsp;|#{link_to 'oppdater', edit_page_path(page)}"
          html << "&nbsp;|#{link_to 'slett', page, :confirm => "Vil du slette denne siden og alle sidene under den?", :method => :delete}"
          html << nested_set_list_for(page.children) unless page.children.empty?
          html << "</li>"
        end
        html << "</ul>"
      end
    end
  end
end
