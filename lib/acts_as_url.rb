if defined?(::Rails::Railtie)
  require 'acts_as_url/railtie'
end

module ActsAsUrl

  def self.included(base)
    base.send(:extend, ClassMethods)
    base.class_attribute :protocols
  end

  mattr_accessor :default_protocols
  self.default_protocols = %w( http https )

  module ClassMethods
    URL_SUBDOMAINS_PATTERN = '(?:[a-z0-9-]+\.)+'
    URL_TLD_PATTERN        = '(?:[a-z]{2}|aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|post|pro|tel|travel|xxx)'
    URL_PORT_PATTERN       = '(?::\d{1,5})?'
    EMAIL_NAME_PATTERN     = '[\w.%+-]+'

    def acts_as_url(*attributes)
      self.protocols = attributes.extract_options!
      attributes += protocols.keys

      attributes.each do |attribute|
        # Set default protocols
        self.protocols[attribute] ||= ActsAsUrl.default_protocols

        validates_url(attribute, :protocols => Array(self.protocols[attribute]))

        # Define before save callback
        callback_name = "convert_#{attribute}_to_url".to_sym
        before_save callback_name
        define_method callback_name do
          write_attr_as_url(attribute)
        end

        # Define reader method
        define_method(attribute) do
          url = read_attribute(attribute)

          # Shorthand for URI.parse(url)
          def url.to_uri
            URI.parse(self)
          end

          url
        end
      end

      send(:include, InstanceMethods)
    end

    protected
    def validates_url(*attr_names)
      options          = attr_names.extract_options!
      protocol_pattern = "(?:(?:#{ (options.delete(:protocols) || ActsAsUrl.default_protocols).map { |p| ActsAsUrl.escape_regex p } * '|' }):\/\/)?"
      port_pattern     = options[:ports] ? "(?: :#{ options.delete(:ports).map { |p| ActsAsUrl.escape_regex p } * '|' } )" : URL_PORT_PATTERN

      validates_format_of(*attr_names << { :allow_blank => true,
        :with => /\A #{protocol_pattern + URL_SUBDOMAINS_PATTERN + URL_TLD_PATTERN + port_pattern} (?:\/\S*)? \z/ix }.merge(options))
    end

    def validates_email(*attr_names)
      options = attr_names.extract_options!

      validates_format_of(*attr_names << { :allow_blank => true,
        # Regex inspired by rick olson's restful-authentication plugin
        :with => /\A #{EMAIL_NAME_PATTERN} @ #{URL_SUBDOMAINS_PATTERN + URL_TLD_PATTERN} \z/ix }.merge(options))
    end

  end

  module InstanceMethods

    private
    def write_attr_as_url(attribute)
      url = self.send(attribute)
      self.send((attribute.to_s + '=').to_sym, convert_to_url(attribute, url))
    end

    def convert_to_url(attribute, url)
      # Don't try to convert an empty string to a url
      return url if url.blank?

      # Get provided protocol if any
      provided_protocol = Array(self.class.protocols[attribute]).reject { |p| !url.starts_with?(p + '://') }.first
      protocol_included = !provided_protocol.nil?

      # Make sure the host name is appended by a slash
      url += '/' unless (protocol_included ? url_without_protocol(url, provided_protocol + '://') : url).include?('/')
      # Add protocol to url if missing
      url = Array(self.class.protocols[attribute]).first + '://' + url unless protocol_included

      return url
    end

    def url_without_protocol(url, protocol)
      url[protocol.length, url.length - protocol.length]
    end

  end

  # Escapes all regular expression tokens in a given string.
  def self.escape_regex(regex_str)
    regex_str.to_s.gsub(/[\[\]\\^$.|?*+()\/]/) { |token_char| '\\' + token_char[0] }
  end

end
