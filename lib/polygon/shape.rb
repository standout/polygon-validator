# frozen_string_literal: true

module Polygon
  # A polygon shape built by any number of points
  class Shape
    attr_accessor :points

    def initialize(points)
      self.points = points
    end
  end
end
