# ...
module Typespec
  # TODO(mtwilliams): Perform sanity checks.
  # TODO(mtwilliams): Raise (custom) exceptions.
  # TODO(mtwilliams): Explain the Type-Value-Or sysem.
  # TODO(mtwilliams): Provide an example on how to rewrite exceptions.
  # TODO(mtwilliams): Document this monstrosity.

  # ...
  def self.any; Typespec::Any; end

  # ...
  class Any
    def self.valid?(_); true; end
  end

  # ...
  def self.t; Typespec::Type; end

  # ...
  class Type
    def initialize(type); @type = type; end
    def self.[](type); self.new(type); end
    def valid?(value); value.is_a?(@type); end
  end

  # ...
  def self.expects; Typespec::Value; end

  # ...
  class Value
    def initialize(value); @value = value; end
    def self.[](value); self.new(value); end
    def valid?(value) value.eql?(@value); end
  end

  # ...
  def self.or; Typespec::Or; end

  # ...
  class Or
    def initialize(*expects); @expects = [*expects]; end
    def self.[](*expects); self.new(*expects); end
    def valid?(value); @expects.any?{|expects| expects.valid?(value)}; end
  end

  # ...
  def self.nil; Typespec.t[NilClass]; end

  # ...
  def self.boolean; Typespec.or[Typespec.t[TrueClass], Typespec.t[FalseClass]]; end

  # ...
  def self.number; Typespec.t[Numeric]; end

  # ...
  def self.integer; Typespec.t[Integer]; end

  # ...
  def self.float; Typespec.t[Float]; end

  # ...
  def self.rational; Typespec.t[Rational]; end

  # ...
  def self.string; Typespec.t[String]; end

  # ...
  def self.symbol; Typespec.t[Symbol]; end

  # ...
  def self.array; Typespec::Array; end

  # ...
  class Array
    def initialize(*elements)
      @element = Typespec.or[*elements]
    end

    def self.[](*elements)
      Typespec::Array.new(*elements)
    end

    def valid?(value)
      if value.is_a? Array
        value.all?{|element| @element.valid?(element)}
      else
        false
      end
    end
  end

  # ...
  def self.hash; Typespec::Hash; end

  # ...
  class Hash
    def initialize(**pairs)
      @pairs = pairs
      @pairs ||= {Typespec.any => Typespec.any}
    end

    def self.[](**pairs)
      Typespec::Hash.new(**pairs)
    end

    def valid?(value)
      if value.is_a? Hash
        value.all? do |k, v|
          @pairs.any? do |pair|
            pair.zip([k,v]).all? {|typespec, value| typespec.valid?(value)}
          end
        end
      else
        false
      end
    end
  end

  # ...
  def self.struct; Typespec::Struct; end

  # ...
  class Struct
    def initialize(*properties, **properties_with_spec)
      if !properties.empty?
        @properties = Hash[properties.map{|name| [name, Typespec.any]}]
      elsif properties_with_spec
        @properties = properties_with_spec
      else
        @properties = {}
      end
    end

    def self.[](*properties, **properties_with_spec)
      Typespec::Struct.new(*properties, **properties_with_spec)
    end

    def valid?(struct, opts={})
      if struct.instance_of? Object
        ignore_if_not_in_spec = opts.fetch(:ignore_if_not_in_spec, false)
        struct.instance_variables.all? do |property|
          undecorated = property.to_s[1..-1].to_sym
          if @properties.include?(undecorated)
            value = struct.instance_variable_get(property)
            @properties[undecorated].valid?(value)
          else
            ignore_if_not_in_spec
          end
        end
      else
        false
      end
    end
  end

  # ...
  def self.object; Typespec::Object; end

  # ...
  class Object < Struct
    def self.[](*properties, **properties_with_spec)
      Typespec::Object.new(*properties, **properties_with_spec)
    end

    def valid?(object, opts={})
      super(object, opts.merge({:ignore_if_not_in_spec => true}))
    end
  end

  # ...
  def self.enum; Typespec::Enum; end

  # ...
  class Enum
    def initialize(*can_take_on) @can_take_on = [*can_take_on] end
    def self.[](*can_take_on); Typespec::Enum.new(can_take_on); end
    def valid?(can_take_on) can_take_on.include?(@can_take_on); end
  end
end


