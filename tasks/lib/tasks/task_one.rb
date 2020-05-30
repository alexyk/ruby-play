require "json"

module Tasks
  PREFIX = "- "
  PREFIX_1 = "> "
  INDENT = "  "

  MODE = 'normal'  # compose, normal

  class Item
    attr_reader :name, :id, :parent_id, :items
    attr_accessor :parent_name

    def initialize(name, id, parent_id)
      @name = name
      @id = id
      @parent_id = parent_id
      @items = []
      @parent_name = nil
    end
    
    def print_self
      case MODE
        when 'compose'
          printf("id:%3d, #{@name.ljust(15)} ", id)
          print "-> #{@items.join(", ")}" if @items.count > 0 
          puts
          @items.each {|item| item.print_self}
        else
          puts
          puts @name
          print_items
      end
    end

    def add_item(item)
      item.parent_name = @name
      @items << item
    end

    def print_items(level = 1, pre = PREFIX)
      if items_count > 0
        level == 1 && pre = PREFIX_1
        @items.sort!.each do |item|
          case MODE
            when 'compose'
              puts "#{pre}#{item.name}(#{item.id})) < #{item.parent_name}(#{item.parent_id})"
            else
              puts "#{pre}#{item.name}"
          end
          pre = (level > 0 ? (INDENT*level) : '') + PREFIX
          item.print_items(level + 1, pre)
        end
      end
    end

    def <=>(b)
      @name <=> b.name
    end

    def to_s
      @name
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
        item.print_self
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