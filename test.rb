require 'active_support/hash_with_indifferent_access'
require 'active_model'

class Person
  include ActiveModel::AttributeMethods

  attribute_method_suffix '_was'
  define_attribute_methods :name

  attr_accessor :name

  def initialize(name: nil)
    @name = name
    @cached_attributes = ActiveSupport::HashWithIndifferentAccess.new(name: @name)
  end

  def attributes
    { name: @name }
  end

  def name=(val)
    cache_changed_attributes(:name, @name)
    @name = val
  end

  private

  def cache_changed_attributes(attr, val)
    cached_attributes[attr] = val
  end

  def cached_attributes
    @cached_attributes ||= ActiveSupport::HashWithIndifferentAccess.new
  end

  def attribute_was(attr)
    @cached_attributes[attr]
  end
end
