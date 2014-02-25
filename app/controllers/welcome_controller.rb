class WelcomeController < ApplicationController
  def index
  end

  def about
    @my_variable = "hi, Doug!"
  end
end
