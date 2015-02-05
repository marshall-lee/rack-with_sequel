module Rack
  class WithSequel
    def initialize(app, options={})
      @app = app
      @db = options[:db]
    end

    def call(env)
      db.synchronize do
        @app.call(env)
      end
    end

    private
      def db
        @db ||= Sequel::Model.db
      end
  end
end
