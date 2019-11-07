# frozen_string_literal: true

module Polygon
  # A polygon point to represent a point inside a canvas or to build a shape
  class Point
    attr_accessor :x, :y

    def initialize(attributes = {})
      attributes.each do |key, value|
        setter = "#{key}="
        send(setter, value) if respond_to?(setter)
      end
    end
  end
end
