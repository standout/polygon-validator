# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Polygon::Point do
  it 'can be initialized with #new(x: Float, y: Float)' do
    point = described_class.new(x: 10.25, y: 11.75)

    expect(point.x).to eq(10.25)
    expect(point.y).to eq(11.75)
  end
end
