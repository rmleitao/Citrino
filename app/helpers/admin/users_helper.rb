module Admin::UsersHelper

  def user_table
    collection_table(@users, :class => 'easy') do |t|
      t.header.hide_when_empty = false
      t.header.column :login, t('.login'), :class => "text"
      t.header.column :name, t('.name'), :class => "text"
      t.header.column :email, t('.email'), :class => "email"
      t.header.column :is_admin?, "Admin", :class => "right"
      t.header.column :last_login_ip, t('.last_login_ip'), :class => "right"
      t.header.column :last_login_at, t('.last_login_at'), :class => "date"
      t.header.column :created_at, t('.created_at'), :class => "date"
      t.header.column :actions, ''

      t.rows.alternate = :odd
      t.rows.empty_caption = "There are no users"
      t.rows.each do |row, item, index|
        last_login_at = item.last_login_at ? I18n.l(item.last_login_at.localtime, :format => "%e %B %Y") : "-"

        row[:id] = "user-#{item.id}"
        row.login item.login, :class => "text"
        row.name  item.name
        row.email item.email, :class => "email"
        row.email item.is_admin?
        
        row.last_login_ip item.last_login_ip || "-", :class => "right"
        row.last_login_at last_login_at, :class => "date"
        row.created_at I18n.l(item.created_at.localtime, :format => "%e %B %Y"), :class => "date"
        row.actions user_table_actions(item), :class => "buttons"
      end
    end
  end

  def user_table_actions(item)
    edit_url = edit_admin_user_path(item)
    delete_url = admin_user_path(item)

    parts = []
    parts << link_to(image_tag("edit.png"), edit_url, :title => t(".edit_hint"))
    parts << "&nbsp;"

    if item.login == "admin"
      parts << image_tag("delete.png", :style => "opacity: 0.3")
    else
      parts << link_to(image_tag("delete.png"), delete_url, :method => "delete",
                       :title => t(".delete_hint"),
                       :confirm => t(".confirm_for_delete", :login => item.login))
    end

    parts.join("\n")
  end
  
end
