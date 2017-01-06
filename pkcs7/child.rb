# Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class Child

    attr_accessor :class_name, :name, :options
    @@count = 0

    def initialize(name, class_name, options = {})
        @class_name, @name, @options = class_name, name, options
    end

    def tag
        return  "C#{(@options[:context_specific].to_s).to_sym}" if @options[:context_specific]
        begin
            eval "#{@class_name}.new.tag"
        rescue => e
            raise "Could not get tag from #{@class_name}: #{e.message}"
        end
    end

    def optional?
        @options[:optional]
    end

    def context_specific
        @options[:context_specific]
    end

    # Note: non-implicits still have to be handled!
    # When non-implicit, this tag has to match.  If implicit, next tag has to match as well (or could it be ignored? to test)

    def match?(input_tag)
        child_tag = tag
        if child_tag.is_a? Array
            child_tag.each { |tag| return true if single_match? tag, input_tag }
            false
        else
            single_match? child_tag, input_tag
        end
    end

    def create_child
        if @options[:context_specific]  and not @options[:implicit] # Create artificial class, for 'skipping' a level
            return ContextSpecificNode.new(self)
        else # Normal case
            begin
                node = eval "#{@class_name}.new"
                node.name = @name
                node
            rescue => e
                raise "Cannot create child '#{@class_name}' : #{e.message.strip}"
            end
        end
    end


    private

    def single_match?(child_tag, input_tag)
        # puts "Matching child #{child_tag} with input #{input_tag}"
        return false unless child_tag # if nil, no match
        return true if child_tag == :ANY      #
        input_tag.to_sym == child_tag.to_sym
    end

    def to_s
        "#{name}: #{class_name}#{@options.size > 0 ? (', ' + @options.inspect) : ''}, tag: #{tag}"
    end


end