module YgSpreeDeliveryDate
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree

    initializer "spree.yg_delivery_date.preferences", :after => "spree.environment" do |app|
       YgSpreeDeliveryDate::Config = YgSpreeDeliveryDate::Configuration.new
    end

    engine_name 'yg_spree_delivery_date'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end


    config.to_prepare &method(:activate).to_proc
  end
end
