#!/usr/bin/env ruby
# Allied Telesis WAP Scraper
# author: takano32 <tak@no32 at tk>
# vim: set noet sts=4 sw=4 ts=4 fdm=marker :
#

require 'rubygems'
# require 'mechanize'
require 'headless'
require 'capybara'
require 'capybara/dsl'
include Capybara::DSL


Capybara.run_server = false
Capybara.default_driver = :selenium

headless = Headless.new(:display => 99)
headless.start

addr = '10.3.1.1'
visit "http://#{addr}/"

fill_in 'i_username', with: 'xxx'
fill_in 'i_password', with: 'xxx'

click_button 'Logon'

begin
	visit "http://#{addr}/admin.cgi?action=associations"
rescue Selenium::WebDriver::Error::UnhandledAlertError => e
	exit
end

puts page.body

exit
page.click_button 'OK'

headless.destroy



