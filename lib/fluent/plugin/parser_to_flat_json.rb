require 'fluent/plugin/parser'

module Fluent::Plugin
  class ToFlatJsonParser < JSONParser
    Fluent::Plugin.register_parser("simple_json", self)

    config_param :separator, :string, default: '.'

    def parse(text)
        r = @load_proc.call(text)
        time, record = convert_values(parse_time(r), r)
        record = record_flatten(record)
        yield time, record
      rescue @error_class, EncodingError
        yield nil, nil
    end

    def record_flatten(record, parent = nil)
        flattend_record = {}
        record.each_with_index do |obj, i|
          if obj.is_a?(Array)
            k, v = obj
          else
            k, v = i, obj
          end

          key = parent ? "#{parent}#{@separator}#{k}" : k
          key = key.gsub('.', @separator)

          if v.is_a? Enumerable
            flattend_record.merge!(record_flatten(v, key))
          else
            flattend_record[key] = v
          end
        end

        flattend_record
      end
  end
end