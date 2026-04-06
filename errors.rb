class BookingError < StandardError; end
class ResourceUnavailableError < BookingError; end
class InvalidActionError < BookingError; end
