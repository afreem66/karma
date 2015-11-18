class OpportunitiesController < ApplicationController

  def find
    @opportunity = opportunity_params
  end

  private
  def opportunity_params
    return params.require(:opportunity).permit(:location)
    fail
  end

end
