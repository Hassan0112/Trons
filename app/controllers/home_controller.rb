class HomeController < ApplicationController

  def index
    @resource = User.new
    @resource_name = :user
  end
end
