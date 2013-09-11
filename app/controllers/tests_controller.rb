class TestsController < ApplicationController
  def index
    binding.pry
    @tests = Test.all
  end

  def create
    @test = Test.new(name: "hello #{Test.count}")
    @test.save
    redirect_to tests_path
  end
end
