class Observer < Controller
  attr_accessor :history_length
  attr_accessor :history
  
  def initialize node, options
    super node
    @history_length = Integer(options["history_length"])
    @history = [nil] * history_length
  end
  
  def start
    @history.shift
    @history.push @node.state
  end

  # maintain local state that includes three steps of history
  def step time
    super
    prev = @history.shift || "undefined"
    @history.push @node.state
    puts "  node state was #{prev} at time #{time - history_length}"
  end
end
