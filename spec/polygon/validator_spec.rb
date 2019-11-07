# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Polygon::Validator do
  let(:points) do
    [
      Polygon::Point.new(x: 100, y: 100),
      Polygon::Point.new(x: 200, y: 100),
      Polygon::Point.new(x: 200, y: 200),
      Polygon::Point.new(x: 100, y: 200)
    ]
  end
  let(:shape) { Polygon::Shape.new(points) }
  let(:validator) { described_class.new(shape) }

  it 'has a version number' do
    expect(Polygon::Validator::VERSION).not_to be nil
  end

  it 'can be initialized with a shape' do
    points = [
      Polygon::Point.new(x: 100, y: 100),
      Polygon::Point.new(x: 200, y: 100),
      Polygon::Point.new(x: 200, y: 200),
      Polygon::Point.new(x: 100, y: 200)
    ]
    shape = Polygon::Shape.new(points)

    validator = described_class.new(shape)

    expect(validator.shape).to eq(shape)
  end

  describe '#point_inside_shape?' do
    context 'when shape is a square' do
      let(:points) do
        [
          Polygon::Point.new(x: 100, y: 100),
          Polygon::Point.new(x: 200, y: 100),
          Polygon::Point.new(x: 200, y: 200),
          Polygon::Point.new(x: 100, y: 200)
        ]
      end

      context 'and point is in shape' do
        it 'will be true' do
          point = Polygon::Point.new(x: 150, y: 150)
          expect(validator.point_inside_shape?(point, shape)).to be true
        end
      end

      context 'and point is not in shape' do
        it 'will be false' do
          point = Polygon::Point.new(x: 250, y: 150)
          expect(validator.point_inside_shape?(point, shape)).to be false
        end
      end
    end

    context 'when shape is a star with intersections' do
      let(:points) do
        [
          [180, 200],
          [280, 470],
          [350, 200],
          [170, 400],
          [380, 260],
          [370, 410]
        ].map do |x, y|
          Polygon::Point.new(x: x, y: y)
        end
      end

      context 'and point is in shape' do
        it 'will be true' do
          [
            [240, 290],
            [260, 322],
            [330, 230],
            [365, 290],
            [345, 342],
            [287, 355],
            [287, 405],
            [189, 385]
          ].each do |x, y|
            point = Polygon::Point.new(x: x, y: y)
            expect(validator.point_inside_shape?(point, shape)).to be true
          end
        end
      end

      context 'and point is not in shape' do
        it 'will be false' do
          [
            [268, 240],
            [193, 320],
            [235, 375],
            [310, 322],
            [320, 366],
            [350, 260]
          ].each do |x, y|
            point = Polygon::Point.new(x: x, y: y)
            expect(validator.point_inside_shape?(point, shape)).to be false
          end
        end
      end
    end
  end
end
