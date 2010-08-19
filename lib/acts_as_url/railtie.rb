module ActsAsUrl
  class Railtie < Rails::Railtie
    initializer 'acts_as_url.active_record' do
      if defined?(::ActiveRecord)
        ActiveRecord::Base.send(:include, ActsAsUrl)
      end
    end
  end
end