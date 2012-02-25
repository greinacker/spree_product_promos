module SpreeProductPromos
  class Engine < Rails::Engine
    engine_name 'spree_product_promos'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.promo.register.promotions.rules" do |app|
      app.config.spree.promotions.rules += [Spree::Promotion::Rules::ProductBuyN]
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
