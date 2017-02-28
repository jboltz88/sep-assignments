require_relative 'graph'
require_relative 'node'

graph = Graph.new
kevin = Node.new("Kevin Bacon")
tom = Node.new("Tom")
chris = Node.new("Chris")
john = Node.new("John")
sue = Node.new("Sue")
gary = Node.new("Gary")
toby = Node.new("Toby")
dennis = Node.new("Dennis")
dee = Node.new("Dee")
nick = Node.new("Nick")

film_hash = Hash.new
film_hash["Flashdance"] = [kevin, sue, tom]
film_hash["Tremors"] = [kevin, nick, john]
film_hash["Batman"] = [sue, chris, gary]
film_hash["Grease"] = [gary, john, toby]
film_hash["Friday"] = [dennis, dee]
film_hash["Superman"] = [dennis]

kevin.set_films(film_hash)
tom.set_films(film_hash)
chris.set_films(film_hash)
john.set_films(film_hash)
sue.set_films(film_hash)
gary.set_films(film_hash)
toby.set_films(film_hash)
dennis.set_films(film_hash)
dee.set_films(film_hash)
nick.set_films(film_hash)

puts "Toby: #{graph.find_kevin_bacon(toby)}"
graph.reset(film_hash)
puts "Sue: #{graph.find_kevin_bacon(sue)}"
graph.reset(film_hash)
puts "Chris: #{graph.find_kevin_bacon(chris)}"
graph.reset(film_hash)
puts "John: #{graph.find_kevin_bacon(john)}"
graph.reset(film_hash)
puts "Dee: #{graph.find_kevin_bacon(dee)}"
