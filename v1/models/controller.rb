class Controller
  attr_accessor :node
  
  def initialize node
    @node = node
  end

  def self.from_xml xml, nodes
    node_id = xml["node_id"]
    node = nodes.find {|n| n.id == node_id}
    
    plugin_xml = xml.xpath('plugin').first
    abort unless plugin_xml["language"] == "ruby"

    subclass_name = plugin_xml["class"]
    subclass = Object.const_get(subclass_name)
    
    options = {}
    plugin_xml.xpath('@*').each do |attr|
      options[attr.name] = attr.value
    end

    subclass.new(node, options)
  end
  
  def start
    # nothing to do in base class
  end
  
  def step time
    puts "#{self.class} at node #{node.id}"
    # nothing else to do in base class
  end
end
