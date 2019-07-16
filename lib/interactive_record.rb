require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "pragma table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each do |row|
      column_names << row["name"]
    end
    column_names.compact
  end

  # def self.initialize(attributes = {})
  #   attributes.each {|key, value| self.send("#{key}=", value)}
  #   self
  # end

  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

end
