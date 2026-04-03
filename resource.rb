class Resource
    attr_reader :id, :name, :category
  
    def initialize(id, name, category)
      @id = id
      @name = name
      @category = category
      @available = true
    end
  
    def available?
      @available
    end
  
    # Book the resource
    def book!
      raise "Resource '#{name}' is already booked." unless available?
      @available = false
    end
  
    # Release the resource (when cancelling)
    def release!
      raise "Resource '#{name}' is already available." if available?
      @available = true
    end
  
    def to_s
      status = available? ? "Available" : "Booked"
      "Resource: #{name} (#{status})"
    end
  end
