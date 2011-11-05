class Reverser < Controller
  attr_accessor :thresh
  
  def initialize node, options
    super node
    @thresh = Float(options["thresh"])
  end
  
  # reverse the rate at node when threshold is crossed
  def step time
    super
    if node.state > thresh
      puts "  reversing, detected node.state=#{node.state} > thresh=#{thresh}"
      node.rate *= -1
    end
  end
end
