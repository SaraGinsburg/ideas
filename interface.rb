require 'database'

ideas_db = Database.new 'ideas'

ideas = ideas_db.read()

ideas_db.write(ideas)


class Idea
  def create(attributes)
    idea = new(attributes)
    idea.save
    idea
  end

  def initialize(attributes)
  end
end



idea = Idea.create name: 'fdsfs', long_info: 'dfsdfsdfs'

idea = Idea.new name: 'fdsfs', long_info: 'dfsdfsdfs'
idea.id # => nil
idea.save
idea.id # => 1

idea = Idea.fetch(id)
# nil
# {name: 'fdsfs', long_info: 'dfsdfsdfs'}
idea.name # => 'fdsfs'
idea.long_info # => 'dfsdfsdfs'

idea.long_info = 'FFFFF'
idea.save

Idea.delete(id)
