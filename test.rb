require 'active_model'
require 'pry'

class Person
  include ActiveModel::AttributeMethods

  attribute_method_prefix 'clear_'
  define_attribute_methods :name

  attr_accessor :name

  def attributes
    { name: @name }
  end

  def clear_attribute(attr)
    send("#{attr}=", nil)
  end
end
