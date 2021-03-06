class OpportunitiesController < ApplicationController

  $KARMA_ACCOUNT_NAME  = ENV["KARMA_ACCOUNT_NAME"]
  $KARMA_ACCOUNT_KEY = ENV["KARMA_ACCOUNT_KEY"]

  def find
    @location = opportunity_params[:city]
    api = VolunteerMatchApi.new($KARMA_ACCOUNT_NAME, $KARMA_ACCOUNT_KEY)
    $opps = api.search(@location) # JSON {"name":"VolunteerMatch","result":"Hello VolunteerMatch!"}

    redirect_to results_path
  end

  def results
    $opps
    render '/opportunities/index'
  end

  private

  def opportunity_params
    return params.require(:location).permit(:city)
  end

end

class VolunteerMatchApi

  def initialize (account_name, api_key)
    @account_name = account_name
    @api_key      = api_key
  end

  def search (city)
    call :searchOpportunities,
    { :opportunityTypes => ["public"],
      :location => city,
      :sortCritera => "distance",
      :sortOrder => "desc"
    }.to_json
  end

  def call(action, json_query)
    puts action
    puts json_query
    nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
    creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
    password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + @api_key)).chomp
    url             = URI.parse("http://www.volunteermatch.org/api/call?action=#{action.to_s}&query=#{json_query}")
    req             = Net::HTTP::Get.new(url.request_uri)
    req.add_field('Content-Type', 'application/json')
    req.add_field('Authorization', 'WSSE profile="UsernameToken"')
    req.add_field('X-WSSE', 'UsernameToken Username="' + @account_name + '", PasswordDigest="' + password_digest + '", ' +
        'Nonce="' + nonce + '", Created="' + creation_time + '"')

    res = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
    raise "HTTP error code #{res.code}" unless res.code == "200"
    @results = OpenStruct.new(JSON.parse res.body)
  end

end
