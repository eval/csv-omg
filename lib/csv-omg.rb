# copied from csv-mapper (https://github.com/pillowfactory/csv-mapper)
if RUBY_VERSION > "1.9"
 require "csv"
 unless defined? FCSV
   class Object
     FasterCSV = CSV
     alias_method :FasterCSV, :CSV
   end
 end
else
 require "fastercsv"
end

module CsvOmg
  
  class Column < Struct.new(:attr, :source, :type, :conversion);end
  
  def self.included(base)
    base.instance_variable_set("@_columns", {})
    base.instance_variable_set("@_parser_options", {
                                :headers      => true, 
                                :skip_blanks  => true
                              })
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def parse(contents, parser_opts={})
      @_parser_options.merge!(parser_opts)
      
      instances = []
      parser = FasterCSV.new(contents, @_parser_options)
      
      parser.each do |line|
        instance = new
        
        @_columns.values.each do |column|
          raw_value = line[column[:source]]
          
          value = column_value(raw_value, column[:type], column[:conversion])
          
          instance.send("#{column.attr.to_s}=", value)
        end
        instances << instance
      end
      instances
    end
    
    def col(attr, *args, &block)
      attr = attr.to_s
      type = args.delete(([String, Float, Integer, Date, DateTime] & args).first) || String
      source = args.first || attr
      
      @_columns[attr] = Column.new(attr, source, type, block)
      
      create_accessor(attr)
    end
    
    private
    def column_value(raw_value, type, conversion)
      value = begin
        case type.to_s
        when 'Date'
          Date.parse(raw_value) rescue ''
        when 'DateTime'
          DateTime.parse(raw_value) rescue ''
        when 'Float'
          Float(raw_value)    rescue 0.0
        when 'Integer'
          Integer(raw_value)  rescue 0
        else
          raw_value.to_s
        end
      end
      
      conversion ? conversion.call(value) : value
    end
    
    def create_getter(name)
      class_eval <<-EOS, __FILE__, __LINE__
        def #{name}
          @#{name}
        end
      EOS
    end

    def create_setter(name)
      class_eval <<-EOS, __FILE__, __LINE__
        def #{name}=(value)
          @#{name} = value
        end
      EOS
    end

    def create_accessor(name)
      unless respond_to?('column_names') && column_names.include?(name)
        create_getter(name) unless instance_methods.include?("#{name}")
        create_setter(name) unless instance_methods.include?("#{name}=")
      end
    end
  end
end
