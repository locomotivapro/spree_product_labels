Spree.routes.available_admin_product_labels_url = function(product_id) {
  return Spree.pathFor('admin/products/' + product_id + '/labels/available')
}

$.fn.searchProductLabels = function (options) {
  'use strict';

  // Default options
  options = options || {};
  var multiple = typeof(options.multiple) !== 'undefined' ? options.multiple : true;

  this.select2({
    minimumInputLength: 3,
    multiple: multiple,
    ajax: {
      url: Spree.routes.available_admin_product_labels_url(this.data('product-id')),
      datatype: 'json',
      data: function (term, page) {
        return {
          q: term
        };
      },
      results: function (data, page) {
        console.log(data.labels);
        var labels = data.labels ? data.labels : [];
        return {
          results: labels
        };
      }
    },
    formatResult: function (label) {
      return label.title;
    },
    formatSelection: function (label) {
      console.log(label.title)
      return label.title;
    }
  });
};

$(document).ready(function () {
  $('[data-select-2="product_labels"]').searchProductLabels();
});
