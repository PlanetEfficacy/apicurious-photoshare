require "rails_helper"

RSpec.describe "jwt" do
  xit "creates a header" do
    jwt = Jwt.new
    expect(jwt.header).to eq("eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9")
  end

  xit "creates a claim set" do
    jwt = Jwt.new
    claim_set = {
        "iss":"apicurious@bright-seer-120216.iam.gserviceaccount.com",
        "scope":"https://www.googleapis.com/auth/devstorage.readonly",
        "aud":"https://www.googleapis.com/oauth2/v4/token",
        "exp": Time.now.utc.to_i + 3600,
        "iat": Time.now.utc.to_i
    }
    expected_hash = Base64.encode64(claim_set.to_s)
    expect(jwt.claim_set).to eq(expected_hash)
  end

  xit "creates a signature" do
    signature = Jwt.new.signature
    binding.pry
  end
end
