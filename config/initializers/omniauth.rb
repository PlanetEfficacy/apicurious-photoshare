Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :name => "google",
    :scope => ['https://mail.google.com/', 'https://www.googleapis.com/auth/devstorage.full_control', 'contacts','plus.login','plus.me','userinfo.email','userinfo.profile'],
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50,
    :access_type => 'offline'
  }
end
