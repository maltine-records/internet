#! /usr/bin/env ruby
# vim: set noet ts=4 sts=4 sw=4:
# author: takano32 <tak at no32.tk>
#

require 'rubygems'
require 'mechanize'
require 'uri'

class AirPort
  def initialize(url = 'http://10.10.16.16/')
    @uri = URI.parse(url)
    @agent = Mechanize.new
    @agent.user_agent_alias = "Windows IE 6"
  end

  def login
    response = @agent.get(@uri)
    form = response.forms.first
    form['ID'] = '31'
    form['backID'] = '31'
    response = @agent.submit(form)
    form = response.forms.last
    form['psw'] = 'IODATA'
    response = @agent.submit(form)
  end

  def wireless_table
    response = @agent.get(@uri)
    form = response.forms.first
    form['ID'] = '31'
    form['backID'] = '31'
    response = @agent.submit(form)
    form = response.forms.last
    form['ID'] = '250'
    response = @agent.submit(form)
    puts response.body.gsub(%r!.*?Radio Table-->(.*?)</table>.*!m) { $1 }
  end
end

if $0 == __FILE__ then
  ap = AirPort.new
  ap.login
  ap.wireless_table
end


