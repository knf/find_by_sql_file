require 'erb'

module Bunster # :nodoc:

  # This makes it a tad simpler to create a clean ERB binding context. It
  # works like so:
  #
  # ERBJacket.wrap "A Foo is: <%= @foo -%>", :foo => 'not a bar'
  #
  class ERBJacket
    def initialize(hash) # :nodoc:
      hash.each { |k, v| instance_variable_set('@' + k.to_s, v) }
    end

    def wrap(erb_template) # :nodoc:
      ::ERB.new(erb_template, nil, '-').result binding
    end

    def self.wrap(erb_template = '', instance_variables = {}) # :nodoc:
      new(instance_variables).wrap erb_template
    end
  end
end