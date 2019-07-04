require 'helper'
require 'fluent/test/driver/parser'
require 'fluent/plugin/parser_simple_json'

class ParserToFlatJson < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = Fluent::Test::Driver::Parser.new(Fluent::Plugin::SimpleJsonParser)
  end

  data('oj' => 'oj', 'yajl' => 'yajl')
  def test_parse(data)
    @parser.configure('json_parser' => data)
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","size":777,"method":"PUT"}') { |time, record|
      assert_equal(Fluent::EventTime.parse('2013-02-28 12:00:00 +0900').to_i, time)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'size'   => 777,
                     'method' => 'PUT',
                   }, record)
    }
  end

  data('oj' => 'oj', 'yajl' => 'yajl')
  def test_parse_timestamp(data)
    @parser.configure('json_parser' => data, 'time_key' => 'timestamp')
    @parser.instance.parse('{"timestamp":1362020400,"host":"192.168.0.1","size":777,"method":"PUT"}') { |time, record|
      assert_equal(Fluent::EventTime.parse('2013-02-28 12:00:00 +0900').to_i, time)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'size'   => 777,
                     'method' => 'PUT',
                   }, record)
    }
  end


  data('oj' => 'oj', 'yajl' => 'yajl')
  def test_nasted_parse(data)
    @parser.configure('json_parser' => data)
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","obj":{"size":777,"method":"PUT"}') { |time, record|
      assert_equal(Fluent::EventTime.parse('2013-02-28 12:00:00 +0900').to_i, time)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'obj.size'   => 777,
                     'obj.method' => 'PUT',
                   }, record)
    }
  end

  data('oj' => 'oj', 'yajl' => 'yajl')
  def test_nasted_separator_parse(data)
    @parser.configure('json_parser' => data, 'separator' => '_')
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","obj":{"size":777,"method":"PUT"}') { |time, record|
      assert_equal(Fluent::EventTime.parse('2013-02-28 12:00:00 +0900').to_i, time)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'obj_size'   => 777,
                     'obj_method' => 'PUT',
                   }, record)
    }
  end

  data('oj' => 'oj', 'yajl' => 'yajl')
  def test_nasted_array_with_separator_parse(data)
    @parser.configure('json_parser' => data, 'separator' => '_')
    @parser.instance.parse('{"time":1362020400,"host":"192.168.0.1","mlist":["x","y"],"obj":{"size":777,"method":"PUT"}') { |time, record|
      assert_equal(Fluent::EventTime.parse('2013-02-28 12:00:00 +0900').to_i, time)
      assert_equal({
                     'host'   => '192.168.0.1',
                     'obj_size'   => 777,
                     'obj_method' => 'PUT',
                     'mlist_0' => 'x',
                     'mlist_1' => 'y',
                   }, record)
    }
  end
end