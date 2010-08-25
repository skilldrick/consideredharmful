class HarmfulController < ApplicationController
  def index
    @harmfuls = Harmful.all
  end

end
