require_relative 'errors'
require_relative 'user'
require_relative 'resource'
require_relative 'booking'

abebe = User.new(id: 1, name: 'Abebe', role: 'researcher')
bekele = User.new(id: 2, name: 'Bekele', role: 'technician')

microscope = Resource.new(id: 1, name: 'Microscope', category: 'lab equipment')
router_kit = Resource.new(id: 2, name: 'Router Kit', category: 'electronics')

puts abebe
puts bekele
puts microscope
puts router_kit

puts "\nCreating first booking..."
booking1 = abebe.create_booking(microscope)
puts booking1
puts microscope

puts "\nAttempting conflicting booking..."
begin
  bekele.create_booking(microscope)
rescue BookingError => e
  puts "Conflict blocked: #{e.message}"
end

puts "\nCancelling first booking..."
booking1.cancel
puts booking1
puts microscope

puts "\nBooking again after cancellation..."
booking2 = bekele.create_booking(microscope)
puts booking2
puts microscope

puts "\nAll active bookings:"
Booking.active_bookings.each { |booking| puts booking }

puts "\nAll available resources:"
Resource.available_resources.each { |resource| puts resource }
