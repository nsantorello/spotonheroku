require 'rubygems'
require 'foursquare'
require 'oauth'
require 'net/http'
require 'net/https'
require 'uri'

class FoursquareController < ApplicationController

	layout "mobile"
	
	def callback
		oauth_key = 'HJUKWCU1S4T3VZ2GPZSTRAMNFE4IKLOHW1YZLMMV354LVES2'
    	oauth_secret = '4EO2EIN3YRXMQ1TJH0QZBEG0F2VLMWENDQZRW0TRR1HQX2GG'
    	callback_url = "http://www.spotontrivia.com/callback/4sq"
    	access_token = params[:access_token].gsub("#access_token=", "")
    	
    	user_url = "https://api.foursquare.com/v2/users/self?oauth_token=#{access_token}"
    	puts user_url
    	user = JSON.parse(`curl '#{user_url}'`)["response"]["user"]
    	puts "user: " + user
	  	
	  	if !(@player = Player.where(:email => user["contact"]["email"]).first)
			@player = Player.new
			@player.first_name = user["firstName"]
			@player.last_name = user["lastName"]
			@player.photo = user["photo"]
			@player.email = user["contact"]["email"]
		end
		
		@player.foursquare_access_token = access_token
		@player.save
	end
	
	def precallback
		
	end

end