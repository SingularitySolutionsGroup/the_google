require 'active_support/hash_with_indifferent_access'
require 'google/api_client'
require "the_google/perspective"
require "the_google/version"

module TheGoogle

  def self.perspective_of input
    TheGoogle::Perspective.new input.merge(self.config)
  end

  def self.set_config config
    @config = config
  end

  def self.config
    @config || {}
  end

end
