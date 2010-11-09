module Admin::ApplicationHelper

  # Create tab.
  # 
  # The tab will link to the first options hash in the all_options array,
  # and make it the current tab if the current url is any of the options
  # in the same array.
  # 
  # +name+ specifies the name of the tab
  # +all_options+ is an array of hashes, where the first hash of the array is the tab's link and all others will make the tab show up as current.
  # 
  # If now options are specified, the tab will point to '#', and will never have the 'active' state.
  def tab_to(name, all_options = nil)
    url = all_options.is_a?(Array) ? all_options[0].merge({:only_path => false}) : all_options

    current_url = url_for(:action => @current_action, :only_path => false)
    html_options = {}

    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          html_options = {:class => "current"}
          break
        end
      end  
    end

    link_to(name, url, html_options)
  end
  def cell(label, value)
    "<tr>
  		<td class='label' nowrap='nowrap'>#{label}</td>
  		<td class='value'>#{value}</td>
  	</tr>"
  end
  
  def cell_separator
    "<tr>
  		<td colspan='2' class='separator'></td>
  	</tr>"
  end
  #write state with colors
  def human_state(state="")
    case state when "active"
      "<span class='active'>#{state}</span>"
    else
      "<span class='inactive'>#{state}</span>"
    end
  end
   
  def tooltip_info(text)
    "<span class=\"info tip\" title=\"#{text}\"><em>info</em></span>"
  end 
  
  def req_helper
   "<span class=\"req\">*</span>"
  end
  
  def wpaginate(collection)
    will_paginate(collection, :previous_label => t('will_paginate.previous'), :next_label => t('will_paginate.next'))
  end

    
  
  def admin_show_link(item)
    link_to(image_tag("/images/admin/show.png"), :action => 'show', :id => item)
  end
  
  def admin_new_link_button(color='green')
    link_to(image_tag("/images/admin/round_plus.png")+" "+t('admin.button.new'), {:action => 'new'}, :class=>"button #{color}")        
  end

  def admin_edit_link(item)
    link_to(image_tag("/images/icons/pencil.png"), :action => 'edit', :id => item)
  end

  #builds a table that lists records from model. 
  #items => activerecord collection, options => array of column names, show_actions=>true or false,  alternative_actions=> method name with alternative actions
  def model_table(items, options, show_actions, alternative_actions )
    itemclass=items.first.class.to_s.constantize if items.size>0
    
    collection_table(items, :class => 'easy') do |t|
      t.header.hide_when_empty = false
      if items.size>0
        options.each do |att|
          t.header.column(att, itemclass.human_attribute_name(att), :class => "text")
        end
      else
        options.each do |att|
          t.header.column(att, att, :class => "text")
        end
      end
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = t('admin.buttons.no_records')

      t.rows.each do |row, item, index|
        row[:id] = "row-#{item.id}"
        if show_actions
          if alternative_actions.nil?
            row.actions default_table_actions(item), :class => "buttons"
          else
            row.actions alternative_actions
          end
        end
      end
    end
  end

  def default_table_actions(item)
    edit_url =  eval("edit_admin_#{item.class.to_s.underscore}_path(item)")
    delete_url = eval("admin_#{item.class.to_s.underscore}_path(item)")

    parts = []
    parts << link_to(image_tag("admin/edit.png"), edit_url, :title => t("admin.users.index.edit_hint"))
    parts << "&nbsp;"
    parts << link_to(image_tag("admin/delete.png"), delete_url, :method => "delete",
    :title => t("admin.users.index.delete_hint"),
    :confirm => t("admin.users.index.confirm_for_delete", :login => item.name))

    parts.join("\n")
  end
  
  def page_entries_info(collection, options = {})
    collection_size = collection.size
    entry_name = options[:entry_name] || begin
      if collection.empty?
        I18n.translate(:"will_paginate.entry", :default => "entry")
      else
        collection.first.class.human_name(:count => collection_size)
      end
    end

    if collection.total_pages < 2
      case collection.size
      when 0 then I18n.translate("will_paginate.found.zero", :entry_name => entry_name, :size => collection_size, :default => "No #{entry_name} found")
      when 1 then I18n.translate("will_paginate.found.one", :entry_name => entry_name, :size => collection_size, :default => "Displaying <b>1</b> #{entry_name}")
      else I18n.translate("will_paginate.found.other", :entry_name => entry_name, :size => collection_size, :default => "Displaying <b>all #{collection_size}</b> #{entry_name}")
      end
    else
      collection_from = collection.offset + 1
      collection_to = collection.offset + collection.length
      collection_total = collection.total_entries
      I18n.translate("will_paginate.display",
        :entry_name => entry_name,
        :from => collection_from,
        :to => collection_to,
        :total => collection_total,
        :default => "Displaying #{entry_name.pluralize} <b>#{collection_from}&nbsp;-&nbsp;#{collection_to}</b> of <b>#{collection_total}</b> in total"
      )
    end
  end
  
end
