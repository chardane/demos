require 'benchmark'
require 'securerandom'
require 'set'

#create big string arrays
old_interests = []
new_interests = []
for i in 0..20000
  old_interests << "#{SecureRandom.hex}"
  new_interests << "#{SecureRandom.hex}"
end

#initialize sets
old_set = Set.new(old_interests)
new_set = Set.new(new_interests)

#allocate variables for loop and set
deleted_interests_loop = []
deleted_interests_set = []

puts "Benchmark Loop vs. Set: 20,000 string array\n\n"

Benchmark.bm do |x|
  x.report('loop') do
    old_interests.each do |interest|
      unless new_interests.include? interest
        deleted_interests_loop << interest
      end
    end
  end

  x.report('set ') do
    deleted_interests_set = old_set - new_set
  end
end

check = deleted_interests_loop.uniq.sort == deleted_interests_set.sort
puts "\nsame results: #{check}\n"
