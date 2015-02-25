module TheGoogle
  class Perspective
    attr_accessor :config
    def initialize config
      @config = config
    end

    def client
      Google::APIClient.new.tap do |a|
        a.authorization.client_id = config[:client_id]
        a.authorization.client_secret = config[:client_secret]
        a.authorization.scope = config[:scope]
        a.authorization.refresh_token = config[:refresh_token]
        a.authorization.access_token = config[:access_token]
        if a.authorization.refresh_token && a.authorization.expired?
          a.authorization.fetch_access_token!
        end
      end
    end
  end
end
