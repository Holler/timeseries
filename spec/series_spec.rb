require 'spec_helper'

describe Timeseries::Series do
	before do
		@datapoints = (0..10).map{ |i|  Timeseries::DataPoint.new( DateTime.now - i , i + 1 ) }
	end

	it "can be initialized with an array of DataPoint objects" do
		expect {
			Timeseries::Series.new( [ Timeseries::DataPoint.new( DateTime.now , 123 ) ] )
		}.to_not raise_error
	end

	it "raises error for non-DataPoint objects" do
		expect {
			Timeseries::Series.new( [123] )
		}.to raise_error(ArgumentError)
	end

	context "instance methods" do
		before do
			@series = Timeseries::Series.new( @datapoints )
		end

		describe "#sum_range" do
			it "sums the range requested" do
				# sums @datapoints[0,7]
				@series.sum_range( 0 , 7 ).should eq 28
			end
		end

		describe "#sum" do
			it "returns the sum of all the datapoints" do
				@series.sum.should eq 66
			end
		end

		describe "#moving_average" do
			it "zeros any empty days" do
				Timeseries::Series.any_instance.should_receive(:zero_empty_dates).and_return(Timeseries::Series.new)
				@series.moving_average(7)
			end

			it "returns a Timeseries::Series" do
				@series.moving_average(2).should be_an_instance_of( Timeseries::Series )
			end

			it "returns moving average for the given number of days" do
				@series.moving_average(2)[0].value.should eq 1.5
			end
		end

		describe "#single_day_moving_average" do
		end

		describe "#exponential_moving_average" do
		end

		describe "#daily" do
		end

		describe "#daily!" do
		end

		describe "#zero_empty_dates" do
			it "fills in empty days as 0" do
				@series.delete_at( 1 )
				@series.zero_empty_dates[1].value.should eq 0
			end
		end
	end
end