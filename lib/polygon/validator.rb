# frozen_string_literal: true

require 'polygon'
require 'polygon/validator/version'
require 'polygon/point'
require 'polygon/shape'

module Polygon
  # Validator service for polygon shapes
  #
  # Could be used to validate if a point is inside a shape
  class Validator
    class Error < StandardError; end

    attr_reader :shape

    # @param [Polygon::Shape] shape the shape to validate
    def initialize(shape)
      @shape = shape
    end

    # Validate if a point is inside the shape
    #
    # @param [Polygon::Point] point the point to validate if it is inside the
    #   shape
    # @return [true, false] true if point is inside the shape
    def contains_point?(point)
      points = shape.points
      winding_number = 0

      points.each.with_index do |point_a, i|
        point_b = point_a == points.last ? points.first : points[i + 1]

        next unless vertically_in_bounds?(point_a, point_b, point)

        winding_number += (left_offset(point_a, point_b, point) <=> 0)
      end

      !winding_number.zero?
    end

    private

    def left_offset(point_a, point_b, point)
      (point_b.x - point_a.x) * (point.y - point_a.y) -
        (point.x - point_a.x) * (point_b.y - point_a.y)
    end

    def vertically_in_bounds?(point_a, point_b, point)
      (point_a.y <= point.y && point_b.y > point.y) ||
        (point_b.y <= point.y && point_a.y > point.y)
    end
  end
end
