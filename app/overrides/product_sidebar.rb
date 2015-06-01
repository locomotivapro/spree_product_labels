Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
                     :name => "admin_labels",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :text =>	"<%== content_tag(:li,
                                            link_to(\"<i class='glyphicon glyphicon-tags'></i> \#{t(:labels)}\".html_safe, selected_admin_product_labels_url(@product)),
                                            class: ('active' if current == 'Labels')
                                          ) %>",
                     :disabled => false)
