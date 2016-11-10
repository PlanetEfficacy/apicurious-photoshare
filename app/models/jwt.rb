class Jwt

  def header
    Base64.encode64('{"alg":"RS256","typ":"JWT"}').chomp
  end

  def claim_set
    Base64.encode64({
      "iss":"apicurious@bright-seer-120216.iam.gserviceaccount.com",
      "scope":"https://www.googleapis.com/auth/devstorage.readonly",
      "aud":"https://www.googleapis.com/oauth2/v4/token",
      "exp": Time.now.utc.to_i + 3600,
      "iat": Time.now.utc.to_i
    }.to_s)
  end

  def signature
    secret = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDBXUFbHNaU9P6n\nGFO1dEpWHYjJJZHq65F23iLIF4zPM8VVF+JoqxVVYKYl3CtvCApWeplBxr97GTOB\n0odgaeCS/Wazj6hpQeLW2YLjtdWvtk5Lv+R6sGP/n5+gWhsocmTyI7rZSx+MKA07\n4ZYq0K6TYyqWS1+5i2hT3ylSdsK8bbUjvYKv7K7ydLRDT7vKNQea9O39nd1F67PU\n2MI+WZnv6YyJATRtOJ1GT4UjxrxT6cDQMkXdUFzVD0SK++GmKzoHFyFaZG96YSDq\nUxgRy3zaYL9Mc2g8KbG8oMxnAYJ6Ltnp3pqK8dM+yE4zn3mUo/m8UYzDytg6tVsZ\n6nQ6gsOtAgMBAAECggEBAKy0hVZCyKnctMI76TBNwMNvt6epBc5kPtWDjF9ZIWxD\n2kGphpBkFjbejyeLocOW09zvvYjRYl8pYCbZCg8kIfBHon5IlmwE6/1n4w9NbqF1\nXDMuHn0ypO5A/Qr00ALtQZpALXg9L904PLG6SCzPnM2JqhT5F3Oav0ECNl8wMbin\nWXryg1d259dM7tohe0eoKeMI/Q0/+KNpI5yLGrukk0kSCvya2KxTdBGiVWd5KxqK\nN7WLAZ5fhOBvwCIiRcmrgRhWeLDocxUzlL5CxS3QRhIzuAhJEvhKQ9ACogGx8Rgu\nzcO6tUwbHWx0UulrwfS7n9aqbh25ii00fAfafjz2QUUCgYEA8V1mbEhOqYtkO0Rt\nUPFXNkoRLPSIyvBWj8n5YCqXLOxODEgvvl1dvE0P1ABw2KeA/2cEJcT1oE0jS0Np\na6OhrBBEUXRNGpq69b6jFR27jgWKKaOYM1PoiUGTuntXsYyVs6NTZUC1nQlrdQO7\npREg5Fk2ieoTcKmUxGq5w+jV/wMCgYEAzRbDfJPSsq/FBE2MWtOacBfgvYgDTYKD\nFA31BZEQ9u/TKoEkx1Hl3zcR9WZTVkxtku9rjvyZk9YPOuLgQHzkYQlP3LGgaJ8M\n4R/a6Kc7WUQZiWjXcuHAC203Q9Zzy9HC/HaJNZnvaEF4MaijVmqM2w+/EIwkQpzD\nHSGq2PxcG48CgYBBb/kc0l3BSbFbACpDD6t9ZIdTkNilbJOLWE7r66Ag5dAjNE79\nZYLMUnhAGf5+PquSkvNk6glN9JvlA9nI/QwQAjkDfGyLEfguOAku6Gi5EHds4pWZ\nFN6ul8DdhiM4V80ebuFlSi3y7WLczq5JCmPIhQdsTLIIkXFr7yN+Idoi0QKBgQC1\nbYXSFxM1b7jibZfUYY0lzHnMMR562xIKE67GFebkDJTJ7SUUDqdEJ/uDE9p1ZXcp\nnRORknRqC9u9RCcN5W5DSXGU0q4M32cNYJjPZ+FgvpW4sT6nKn4xnZReNsCJdi8A\nF/yZpmvb1s71XzHfqLKit/NWOCN7qiIRC0+QVO9GkQKBgH1vfOstjxP6UwF3ag04\nUTqj1q/vT3I0y7zgspWoFiGFaLbwe/Q+MgJpoletI69xhudMzG1Dx2gGAcr1dgbG\npgFLhJodduma7NA6cB+0r6kiL8tanQ5vrIfaJOmHoXVzEQPA/oteO2kN59FarBHA\ngw1f8yb/ZywPXlAuDHZOBK7d\n-----END PRIVATE KEY-----\n"
    # signature = k.sign(digest,secret)
    stuff_to_sign = header + "." + claim_set
    k = OpenSSL::PKey::RSA.new(secret)
    digest = OpenSSL::Digest::SHA256.new
    signature = k.sign(digest, stuff_to_sign)
    # binding.pry
    encoded_signature = Base64.encode64(signature)

    # assertion = header + "." + claim_set + "." + encoded_signature

    assertion = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.ezppc3M9PiJhcGljdXJpb3VzQGJyaWdodC1zZWVyLTEyMDIxNi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsIDpzY29wZT0+Imh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL2F1dGgvZGV2c3RvcmFnZS5yZWFkb25seSIsIDphdWQ9PiJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9vYXV0aDIvdjQvdG9rZW4iLCA6ZXhwPT4xNDc2MzA1Mjk3LCA6aWF0PT4xNDc2MzAxNjk3fQ==.UItQnfO9qFCFMnD73DP9FHXZdNgyb9V94Yy+DottkL3EU+jg9P+k35SIBF1GrH00uTVkfOSPhH4pJ78n4Js8ue+MxL2/Ri6iTWrxocy0q6NdSaJvfBPOdUIViL28ZKRycH31GrzogVE94eUchAOnmPqGDWtfdq0eGXfmvsOTZ1RvcOtI8+2I0EY3s6AsYVXMAlF48jCm3qhjuAChOkYX0qfganrDlWfgwoHF10AzxTVv3IKO3nwj36Ct/+C7ptNlQqKS3xEvW/T3KQt7fu8E0jf7OW2bbQ8QWamSSUagp5GuIaMW6ppta+ycbbFv26+GkNw/9Lmi8wDAPOKRDbxnzg==\n"

    conn = Faraday.new(url: "https://www.googleapis.com") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.post do |req|
      req.url "/oauth2/v4/token?grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=#{assertion}"
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
    end
    binding.pry
  end


end
