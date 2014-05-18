require 'blitz/version'
require 'blitz/client'
require 'blitz/error'

module Blitz
  module_function

  def init(opts)
    Client.new(opts)
  end
end
