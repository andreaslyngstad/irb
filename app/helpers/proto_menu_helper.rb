module ProtoMenuHelper

  # add a proto menu to the page.
  # element_id : the id of the element to which to attach the menu
  # menu_items : an array of hashes containing the menu items.  Each hash can contain:
  #   name: the string to show on the menu
  #   className: the class name to give the item on the menu
  #   callback: a function to call when the item is clicked
  # class_name : The css class name to give to the menu (optional, with default).
  def add_proto_menu( element_id, menu_items, class_name = 'menu_desktop' )

    menu_items_js = "[" 

    menu_item_iterator = 0
    menu_items.each do |menu_item|    
      menu_item_js = options_for_javascript menu_item
      menu_item_js += "," unless(menu_items.length == (menu_item_iterator +1))
      menu_items_js += menu_item_js
      menu_item_iterator += 1
    end

    menu_items_js += "]" 

    # Add the javascript to the content for proto menus javascript.  
    # This is yielded in the app layout.
    content_for :register_proto_menus_js do
      "
        new Proto.Menu({
          selector: '#{"#" + element_id}', 
          className: '#{class_name}',
          menuItems: #{menu_items_js},
          fade: true,
          beforeShow: function() { 
            /* hide all other menus */
            menus = $$('.menu'); 
            menus.each(function(element) {
              element.hide();
              });
            }
        });
      " 
    end

    return "" # the helper itself returns nothing.

  end
end