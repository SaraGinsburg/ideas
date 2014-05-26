class Database

  def read
    return YAML.load_file('data.yaml')
  end

  def write(ideas)
    File.open('data.yaml', 'w') do |out|
      YAML.dump(ideas, out)
    end
  end
end