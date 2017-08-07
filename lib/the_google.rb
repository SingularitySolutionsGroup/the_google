require 'interchangeable'
require 'active_support/hash_with_indifferent_access'
require 'google/apis/drive_v2'
require "the_google/event"
require "the_google/calendar"
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
