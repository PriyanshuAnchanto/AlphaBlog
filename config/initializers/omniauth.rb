
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  provider :google_oauth2, "690973461880-3ed2tei884gbjpva5v0derdgfnns80gl.apps.googleusercontent.com", "WGBhDY-rWBIn7Oa-JXcgYnJ0"
end

#client secret = "WGBhDY-rWBIn7Oa-JXcgYnJ0"
# client id = "690973461880-3ed2tei884gbjpva5v0derdgfnns80gl.apps.googleusercontent.com"