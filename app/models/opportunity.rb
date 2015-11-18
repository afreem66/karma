class Opportunity < ActiveRecord::Base



  private
  def opportunity_params
    return params.require(:opportunity).permit(:location)
    fail
  end

end
