require 'spec_helper'

describe Timeseries::DataPoint do
	before { @point = Timeseries::DataPoint.new( DateTime.new , 123 ) }

	subject { @point }

	it { should respond_to(:date) }
	it { should respond_to(:value) }
end