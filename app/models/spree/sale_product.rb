module Spree
  class SaleProduct < ActiveRecord::Base
    belongs_to :active_sale_event, :class_name => 'Spree::ActiveSaleEvent'
    belongs_to :product, :class_name => 'Spree::Product'
    belongs_to :option_value, :class_name => 'Spree::OptionValue'
    attr_accessible :active_sale_event_id, :product_id, :option_value_id, :position, :product_name

    delegate :product_name, :to => :product
    delegate :sale_name, :to => :active_sale_event

    validates :active_sale_event_id, :product_id, :presence => true
    validates :active_sale_event_id, :uniqueness => { :scope => [:product_id, :option_value_id], :message => I18n.t('spree.active_sale.event.sale_product.already_exists') }

    scope :active_option_products, lambda { |product_id, option_value_id|
      where(
          :product_id => product_id,
          :option_value_id => option_value_id
      )
    }

    scope :active_sale_products, lambda {
      joins(:active_sale_event).merge(Spree::ActiveSaleEvent.available)
    }

    scope :without_past_products, lambda {
      joins(:active_sale_event).merge(Spree::ActiveSaleEvent.not_deleted.without_past_events)
    }

    def product_name
      product.try(:name)
    end

    def product_name=(name)
      self.product.name ||= name if name.present?
    end

    def product_image
      self.product.images_for_color(self.option_value_id, :pdp_show).first
    end
  end
end