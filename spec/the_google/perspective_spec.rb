require_relative '../spec_helper'

describe TheGoogle::Perspective do

  describe "client" do

    let(:perspective) { TheGoogle::Perspective.new(config) }
    let(:config)      { {} }

    let(:result) { perspective.client }

    before { Signet::OAuth2::Client.any_instance.stubs(:expired?).returns false }

    it "should return a Google API Client" do
      result.is_a? Google::APIClient
    end

    it "should set the client id" do
      value = random_string
      config[:client_id] = value
      result.authorization.client_id.must_equal value
    end

    it "should set the client secret" do
      value = random_string
      config[:client_secret] = value
      result.authorization.client_secret.must_equal value
    end

    it "should set the scope (internally its flipped to an array)" do
      value = random_string
      config[:scope] = value
      result.authorization.scope.must_equal [value]
    end

    it "should set the refresh token" do
      value = random_string
      config[:refresh_token] = value
      result.authorization.refresh_token.must_equal value
    end

    it "should set the access token" do
      value = random_string
      config[:access_token] = value
      result.authorization.access_token.must_equal value
    end

    describe "the refresh token exists" do
      before { config[:refresh_token] = random_string }

      describe "and the authorization expired" do
        before { Signet::OAuth2::Client.any_instance.stubs(:expired?).returns true }
        it "should fetch a new access token" do
          google_client = Google::APIClient.new
          google_client.authorization.expects :fetch_access_token!

          Google::APIClient.stubs(:new).returns google_client

          TheGoogle::Perspective.new(config).client
        end
      end

    end

  end

  describe "config" do
    it "should be a hash with indifferent access" do
      TheGoogle::Perspective.new({}).config.is_a?(HashWithIndifferentAccess)
    end
  end

end
