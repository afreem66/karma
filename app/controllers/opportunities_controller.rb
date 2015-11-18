class OpportunitiesController < ApplicationController

  def find
    @location = opportunity_params
    redirect_to results_path
    fail
  end

  private

  def opportunity_params
    return params.require(:location).permit(:postCode)
  end

end

account_name  = ENV["KARMA_ACCOUNT_NAME"]
api_key = ENV["KARMA_ACCOUNT_KEY"]

class VolunteerMatchApi

  def initialize (account_name, api_key)
    @account_name = account_name
    @api_key      = api_key
  end

  def search_opportunities (postCode)
    call :searchOpportunities,
    { :opportunityTypes => ["public","private"],
      :location => postCode,
      :fieldsToDisplay => ["name", "url", "location", "description", "mission"]
    }.to_json
  end

  protected

  def call(action, json_query)
    puts action
    puts json_query
    nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
    creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
    password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + @api_key)).chomp
    url             = URI.parse("http://www.volunteermatch.org/api/call?action=#{action.to_s}&query=" + URI.encode(json_query))

    req             = Net::HTTP::Get.new(url.request_uri)
    req.add_field('Content-Type', 'application/json')
    req.add_field('Authorization', 'WSSE profile="UsernameToken"')
    req.add_field('X-WSSE', 'UsernameToken Username="' + @account_name + '", PasswordDigest="' + password_digest + '", ' +
        'Nonce="' + nonce + '", Created="' + creation_time + '"')

    res = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
    raise "HTTP error code #{res.code}" unless res.code == "200"
    OpenStruct.new(JSON.parse res.body)
  end

end

api = VolunteerMatchApi.new(account_name, api_key)
response = api.search_opportunities("10011") # JSON {"name":"VolunteerMatch","result":"Hello VolunteerMatch!"}
puts response.name.to_s
