class HomeController < ApplicationController
  def index
    render json: "Hello World", status: 200
  end
end
