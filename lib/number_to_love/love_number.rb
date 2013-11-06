require 'action_view'
require 'delegate'

include ActionView::Helpers::NumberHelper

module NumberToLove
  class LoveNumber < SimpleDelegator

    HUMAN_ACCESSORS = [:precision, :significant, :units, :strip_insignificant_zeros, :delimiter, :separator, :format] 

    CUSTOM_ACCESSORS = [:minimalize]
    ALL_ACCESSORS = HUMAN_ACCESSORS | CUSTOM_ACCESSORS

    attr_accessor *ALL_ACCESSORS

    VERBOSE_UNITS = {}
    ABBREVIATED_DECIMAL_UNITS = {            
            unit: "",
            # ten:
            #   one: Ten
            #   other: Tens
            # hundred: Hundred
            thousand: "K",
            million: "M",
            billion: "B",
            trillion: "T"
          }

    def initialize(val, opts={})
      @value = val
      interpret_options(opts)

      @units = ABBREVIATED_DECIMAL_UNITS


      super(@value)
    end

    def to_v
      @value
    end


    def to_s
      opts = render_options
      number_to_human(@value, opts[:number_to_human])
    end


    def inspect
      to_s
    end



    # def method_missing(method_name, *args, &blk)
    #   if Numeric.method_defined?(method_name)
    #     @value.send(method_name, *args, &blk)
    #   elsif String.method_defined?(method_name)
    #     @self.to_s.send(method_name, *args, &blk)
    #   else
    #     super()
    #   end
    # end


    # def respond_to?(method_name, include_private = false)
    #   if String.method_defined?(method_name)
    #     true
    #   else
    #     super
    #   end
    # end

    (String.instance_methods - (Numeric.instance_methods | Float.instance_methods | Fixnum.instance_methods )).each do |foo|
      define_method(foo) do |*args|
        self.to_s.send(foo, *args)
      end
    end


    private 
    # command
    # sets attr_accessors
    def interpret_options(opts)
      opts.each_pair do |att, val|
        a = att.to_sym
        if ALL_ACCESSORS.include?(a)
          self.instance_variable_set("@#{a}", val)
        end


      end
    end

    # returns a Hash to pass along
    def render_options
      hsh = {}
      if minval = @minimalize
        @units = ABBREVIATED_DECIMAL_UNITS
        @format = "%n%u"
        @precision = minval
        @strip_insignificant_zeros = true
        @delimiter = ''
        @significant = true
      end


      hsh[:number_to_human] = HUMAN_ACCESSORS.inject({}) do |h, att|
        if val = self.instance_variable_get("@#{att}")
          h[att] = val
        end

        h
      end

      return hsh
    end

  end
end