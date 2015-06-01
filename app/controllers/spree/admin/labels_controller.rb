module Spree
  module Admin
    class LabelsController < ResourceController
      respond_to :json, :js, :html

      def index
        respond_with(@labels) do |format|
          format.html
        end
      end

      def edit
        @label = Label.find params[:id]
        @products = @label.products
      end

      def selected
        @product = load_product
        @labels = @product.labels

        respond_with(:admin, @labels)
      end

      def available
        @product = load_product
        @labels = params[:q].blank? ? [] : Label.includes(:product_labels).where('lower(title) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
        @labels = @labels.to_a.keep_if {|label| !@product.labels.include?(label) }

        respond_with(:admin, @labels)
      end

      def select
        @product = load_product
        @label = Label.find(params[:id])
        @product.labels << @label
        @product.save
        @labels = @product.labels

        respond_with(:admin, @labels)
      end

      def apply
        @product = load_product
        _label_ids = params[:product][:labels_ids].split(',')
        @labels = Label.where(id: _label_ids)
        @product.labels << @labels
        @product.save
        @labels = @product.labels

        respond_with(:admin, @labels, location: selected_admin_product_labels_path)
      end

      def remove
        @product = load_product
        @label = Label.find(params[:id])
        @product.labels.delete(@label)
        @product.save
        @labels = @product.labels

        respond_with([:admin, @label], location: selected_admin_product_labels_path) { |format| format.js { render_js_for_destroy } }
      end

      private

      def find_all_labels
        @labels = Spree::Label.all
      end

      def load_product
        Product.find_by_slug! params[:product_id]
      end

      def label_params
        require(:label).permit(:title, :shape, :color)
      end

    end
  end
end
