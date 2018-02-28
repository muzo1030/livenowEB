module VideosHelper


	require 'rubygems'
	require 'google/api_client'
	require 'trollop'

	# Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
	# tab of
	# Google Developers Console <https://console.developers.google.com/>
	# Please ensure that you have enabled the YouTube Data API for your project.
	DEVELOPER_KEY = 'AIzaSyAUat8tsl5tjcPzcsvxs8l3hTW0_203zy0'
	YOUTUBE_API_SERVICE_NAME = 'youtube'
	YOUTUBE_API_VERSION = 'v3'

	def get_service
		client = Google::APIClient.new(
			:key => DEVELOPER_KEY,
			:authorization => nil,
			:application_name => $PROGRAM_NAME,
			:application_version => '1.0.0'
			)
		youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

		return client, youtube
	end
end
