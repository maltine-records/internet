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

  def wireless_table_body
    response = @agent.get(@uri)
    form = response.forms.first
    form['ID'] = '31'
    form['backID'] = '31'
    response = @agent.submit(form)
    form = response.forms.last
    form['ID'] = '250'
    response = @agent.submit(form)
    table_content = response.body.gsub(%r!.*?Radio Table-->(.*?)</table>.*!m) { $1 }
    table = "<html><body><table>#{table_content}</table></body></html>"
    IO.popen("w3m -dump -T text/html", "r+") do |io|
      io.print(table)
      io.close_write
      io.read
    end
  end

  def wireless_table
    data = wireless_table_body
    rows = []
    data.each_line do |line|
      next if line.chomp.empty?
      column = line.split(/\s+/).map do |column|
        column unless column.empty?
      end.compact
      rows << column
    end
    name = ['Radio Name', 'Mode', 'Op Channel', 'Assoc. Clients', 'Tx Pkts', 'Rx Pkts', 'Error']
    return [name] + rows
  end
end

if $0 == __FILE__ then
  ap = AirPort.new
  ap.login
  p ap.wireless_table
end


