require 'rubygems'
require "test-unit"
require 'active_support'

class BoardTest < ActiveSupport::TestCase
	def setup
	end


	def test_something_cool
		assert 1, 1
	end
end



exit Test::Unit::AutoRunner.run(true, ".")