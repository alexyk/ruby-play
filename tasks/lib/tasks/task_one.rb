require "json"

module Tasks
  PREFIX = "- "
  INDENT = "  "

  DEBUG = false

  class Item
    attr_reader :name, :id, :parent_id
    attr_accessor :parent_name

    def initialize(name, id, parent_id)
      @name = name
      @id = id
      @parent_id = parent_id
      @items = []
      @parent_name = nil
    end

    def add_item(item)
      item.parent_name = @name
      @items << item
    end

    def print_items(level = 1, pre = PREFIX, &block)
      if items_count > 0
        @items.sort!.each do |item|
          if DEBUG
            puts "#{pre}#{item.name} < #{item.parent_name}"
          else
            puts "#{pre}#{item.name}"
          end
          pre = (level > 0 ? (INDENT*level) : '') + PREFIX
          item.print_items(level + 1, pre)
          yield if block_given?
        end
      end
    end

    def <=>(b)
      @name <=> b.name
    end

    def items_count
      @items.count
    end
  end

  class TaskOne
    attr_reader :data, :data_map

    def initialize
      # 1 read json -> objects
      # 2 hash -> key is id
      read_json
      parse_raw_object
      print_all
    end

    def print_all
      @top_items.sort!.each do |item|
        puts item.name
        item.print_items { puts }
      end
    end

    def parse_raw_object
      @data_map = {}
      @data["items"].each do |item|
        @data_map[item["id"]] = Item.new(item["name"], item["id"], item["parent_id"])
      end
      @top_items = []
      @data_map.each do |id, item|
        unless item.parent_id.nil?
          @data_map[item.parent_id].add_item(item)
        else
          @top_items << item
        end
      end
    end

    def read_json
      json_string = File.new('./lib/tasks/data/data_one.json').read
      @data = JSON.parse(json_string)
    end
  end
end

puts
Tasks::TaskOne.new
puts