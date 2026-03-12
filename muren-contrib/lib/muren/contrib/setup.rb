# frozen_string_literal: true

require 'muren/base'
require 'muren/contrib/version'

module Muren
  module Contrib
    module Loader
      def extensions
        @extensions ||= { helpers: [], register: [] }
      end

      def register(name, path)
        autoload name, path, :register
      end

      def helpers(name, path)
        autoload name, path, :helpers
      end

      def autoload(name, path, method = nil)
        extensions[method] << name if method
        Muren.autoload(name, path)
      end

      def registered(base)
        @extensions.each do |method, list|
          list = list.map { |name| Muren.const_get name }
          base.send(method, *list) unless base == ::Muren::Application
        end
      end
    end

    module Common
      extend Loader
    end

    module Custom
      extend Loader
    end

    module All
      def self.registered(base)
        base.register Common, Custom
      end
    end

    extend Loader
    def self.registered(base)
      base.register Common, Custom
    end
  end
end
