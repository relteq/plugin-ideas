require 'nokogiri'

xml = Nokogiri.XML(File.open(ARGV[0] || "input.xml"))

nodes = xml.xpath('//node')
ctrls = xml.xpath('//controller')

ctrls.each do |ctrl|
  node_id = ctrl["node_id"]
  node = nodes.find {|n| n["id"] == node_id}
  
  plugin = ctrl.xpath('plugin').first
  abort unless plugin["language"] == "ruby"
  
  ctrl.instance_eval plugin.text
  ctrl.instance_variable_set "@node", node
end

(0..10).each do |time|
  nodes.each do |node|
    # evolve somehow
  end
  
  ctrls.each do |ctrl|
    ctrl.step(time)
  end
end
