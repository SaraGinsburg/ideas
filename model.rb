class Model
  def initialize(attributes = {})
    self.attributes = attributes
  end

  def self.create(attributes = {})
    record = new(attributes)
    record.save
    record
  end

  def attributes
    @attributes ||= Hash[self.class.attribute_names.zip []]
  end

  def attributes=(new_attributes = {})
    filtered_attributes = new_attributes.select { |key, _| self.class.attribute_names.include? key }
    @attributes = self.attributes.merge(filtered_attributes)
  end

  def name
    @attributes[:name]
  end

  def name=(value)
    @attributes[:name] = value
  end

  def method_missing(name, *args)
    name = name.to_s
    if name.end_with?('=')
      name.chop!
      name = name.to_sym
      if self.class.attribute_names.include? name
        @attributes[name] = args[0]
      else
        super
      end
    else
      name = name.to_sym
      if self.class.attribute_names.include? name
        @attributes[name]
      else
        super
      end
    end
    #puts "You called a nonexisting method #{name} with args #{args.inspect}"
  end

  def save
    attributes = {
      short: short,
      long_info: long_info,
    }
    if id
      Database.update 'idea', attributes
    else
      self.id = Database.create :idea, attributes
    end
  end
end

class Idea < Model
  def self.attribute_names
    [:short, :long]
  end
end

i = Idea.new
i.attributes = {short: "bla", foo: "bar"}
p i.short
i.short=5
p i.short