class Node
  attr_accessor :id, :initial, :rate, :state
  
  def initialize id, initial, rate
    @id, @initial, @rate = id, initial, rate
  end
  
  def self.from_xml xml
    new(xml["id"], Float(xml["initial"]), Float(xml["rate"]))
  end

  def start  
    @state = initial
    puts "node #{id} state=#{state}"
  end
  
  def step time
    @state += rate
    puts "node #{id} state=#{state}"
  end
end
