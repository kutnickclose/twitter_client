class PairsController < ApplicationController
  include PairsHelper
  
  def create
    @pair = Pair.new(pair_params)
    @pair.first_screen_name = @pair.first_screen_name.downcase
    @pair.second_screen_name = @pair.second_screen_name.downcase
    if @pair.save
      redirect_to pair_url(@pair)
    else
      redirect_to(pair_url(Pair.find_by(first_screen_name: @pair.first_screen_name, second_screen_name: @pair.second_screen_name)))
    end
    
  end
  
  def show
    @pair = Pair.find(params[:id])
    save_common_followings(@pair)
    @common_followings = @pair.common_followings
  end
  
  private
  def pair_params
    params.require(:pair).permit(:first_screen_name, :second_screen_name)
  end
  
end
