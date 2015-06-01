Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_product",
                     :name => "admin_labels",
                     :insert_bottom => "[data-hook='admin_product_sub_tabs']",
                     :text => "<%= tab(:labels, :label => 'labels', :match_path => '/labels') %>",
                     :disabled => false)
