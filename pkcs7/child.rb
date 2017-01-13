Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class Child

    def self.instantiate(in_params)
        params = in_params.clone
        name = params.delete(:name)
        class_name = params.delete(:class_name)
        raise "Missing name and class name" unless name and class_name
        self.new(name, class_name, params)
    end

    attr_accessor :class_name, :name, :options, :node_instance
    @@count = 0

    def initialize(name, class_name, options = {})
        @name, @class_name, @options = name, class_name, options
        if options[:context_specific]  and not options[:implicit] # Create artificial class, for 'skipping' a level
            @node_instance = ContextSpecificNode.new(self)
        else
            begin
                @node_instance = eval "#{class_name}.new"
                @node_instance.name = name
            rescue => e
                raise "Cannot create child '#{class_name}' : #{e.message.strip}"
            end
        end
    end

    def node
        @node_instance.clone
    end

    def tag
        @options[:context_specific] ? "C#{(@options[:context_specific].to_s)}".to_sym : @node_instance.node_tag
    end

    def optional?
        @options[:optional]
    end

    def context_specific
        @options[:context_specific]
    end

    def match?(input_tag)
        child_tag = tag
        if child_tag.is_a? Array
            child_tag.each { |tag| return true if tag == input_tag}
            false
        else
            return true if child_tag == :ANY      #
            input_tag.to_sym == child_tag.to_sym
        end
    end

    def to_s
        "#{name}: #{class_name}#{@options.size > 0 ? (', ' + @options.inspect) : ''}, tag: #{tag}"
    end


end