# fluent-plugin-simple-json-parser

fluentd parser plugin to create flattened JSON from nested JSON objects

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-simple-json-parser'

And then execute:

    $ bundle

Readying for a package build:

   $ bundle install
   $ bundle exec rake build

## Configuration

- configuration

  ```
  <source>
    type tail
    path /tmp/fluentd.json
    pos_file /tmp/fluentd.log.pos
    tag logs
    format to_json_flat
    time_key timestamp
    separator .
  </source>
  ```

#### Parameter

###### time_key
- Default is `time`
- Field to use for time resolution

###### separator
- Default is '.'
- Used as the value to split the keys
