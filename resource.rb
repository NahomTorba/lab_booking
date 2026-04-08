require_relative 'errors'

class Resource
    @@all_resources = []
    attr_reader :id, :name, :category, :current_booking
  
    def initialize(id:, name:, category:)
      @id = id
      @name = name
      @category = category
      @available = true
      @current_booking = nil
      @@all_resources << self
    end
  
    def self.available_resources
      @@all_resources.select(&:available?)
    end
  
    def available?
      current_booking.nil?
    end
  
    # Book the resource
    def assign_booking(booking)
      raise ResourceUnavailableError, "Resource '#{name}' is already booked." unless available?
      @current_booking = booking
    end
  
    # Release the resource (when cancelling)
    def release!
      @available = true
      raise InvalidActionError, "Resource '#{name}' is already available." if available?
      @current_booking = nil
    end
  
    def to_s
      status = available? ? "Available" : "Booked"
      "Resource(id: #{id}, name: #{name}, category: #{category}, status: #{status})"
    end
  end
