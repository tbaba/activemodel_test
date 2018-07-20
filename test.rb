require 'active_model'
require 'pry'

class Person
  include ActiveModel::AttributeMethods

  attribute_method_prefix 'clear_'
  attribute_method_suffix '_was'
  define_attribute_methods :name

  attr_accessor :name

  def attributes
    { name: @name }
  end

  def name=(val)
    cached_attributes.merge!(name: @name)
    @name = val
  end

  private

  def clear_attribute(attr)
    send("#{attr}=", nil)
  end

  def attribute_was(attr)
    @cached_attributes[attr]
  end

  def cached_attributes
    @cached_attributes = self.attributes
  end
end
