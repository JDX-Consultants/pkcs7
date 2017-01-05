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
            eval "#{@class_name}.tag"
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
        if input_tag.is_a? Array
            input_tag.each { |tag| return true if single_match? tag, child_tag }
            return false
        else
            single_match? child_tag, input_tag
        end
    end

    def create_child
        if @options[:context_specific]  and not @options[:implicit] # Create artificial class, and append
            # begin
            #     class_name = "#{@class_name}#{tag.to_s}_#{@@count}"
            #     @@count += 1
            #     tag_value = eval "#{@class_name}::TAG"
            #     class_string = "#{class_name} = Class.new(#{@class_name}) do\n  TAG = :#{tag_value}\n  def instance_for_tag(tag)\n    eval \"#{@class_name}.new\"\n  end\nend"
            #     eval class_string
            #     new_node = eval "#{class_name}.new"
            #     new_node.name = "#{@name} (explicit)"
            #     new_node
            # rescue => e
            #     raise "Error while creating inner class '#{class_name}' : #{e.message.strip} for content:\n#{class_string}"
            # end
            # puts "explicit context_specific tag found for child #{self.inspect}"
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
        return false unless child_tag # if nil, no match
        return true if child_tag == :ANY      #
        input_tag.to_s == child_tag.to_s
    end


    #Ongoing work TO DO
    def explicit_class(name, class_name, tag)
        Class.new do
            define_method(:instance_for_tag) do |name, class_name|
                node = eval "#{class_name}.new"
                node.name = name
            end

        end
    end


end