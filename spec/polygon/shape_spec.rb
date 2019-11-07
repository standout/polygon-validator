# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Polygon::Shape do
  it 'can be initialized with a list of Polygon::Point' do
    points = [
      Polygon::Point.new(x: 100, y: 100),
      Polygon::Point.new(x: 200, y: 100),
      Polygon::Point.new(x: 200, y: 200),
      Polygon::Point.new(x: 100, y: 200)
    ]

    shape = Polygon::Shape.new(points)

    expect(shape.points).to eq(points)
  end
end
