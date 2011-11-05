require 'nokogiri'

require 'models/node'
require 'models/controller'

require 'plugins/observer'
require 'plugins/reverser'

puts "Reading xml..."
xml = Nokogiri.XML(File.open(ARGV[0] || "input.xml"))

puts "Constructing objects..."
nodes = xml.xpath('//node').map do |node_xml|
  Node.from_xml(node_xml)
end

ctrls = xml.xpath('//controller').map do |ctrl_xml|
  Controller.from_xml(ctrl_xml, nodes)
end

puts "Initializing simulation state..."
nodes.each do |node|
  node.start
end

ctrls.each do |ctrl|
  ctrl.start
end

puts "\nRunning simulation..."
(1..5).each do |time|
  puts "\n=== at time #{time} ==="
  
  nodes.each do |node|
    node.step(time)
  end
  
  ctrls.each do |ctrl|
    ctrl.step(time)
  end
end
