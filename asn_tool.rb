class ASNTool

    require 'openssl'
    require 'origami'
    require 'net/http'
    require 'uri'
    require 'base64'
    require 'pp'
    require './path'
    include PATH

    def initialize(hex_data)
        @asn = OpenSSL::ASN1.decode(hex_data.strip)
        # puts "Initialised stream: #{@asn.to_s}"
    end

    def self.path(asn_element)
        "#{asn_element.tag_class.to_s[0]}#{asn_element.tag}"
    end

    def dump
        dump_element(@asn)
    end

    TAB_SIZE = 2

    def dump_element_as_asn(path)
        puts "Start extracting path #{path}"
        binaries = ASNExtractor.new(@asn, path).result
        if binaries.length > 0
            binaries.each do |binary|
                begin
                    ASNTool.new(binary).dump
                rescue
                    puts "Error while parsing #{binary.to_s[0..100]}"
                end
            end
        else
            'Pattern not found'
        end
    end


    def dump_element(asn_element, indent = 0, path = [])
        element_path = ASNTool.path(asn_element)
        path << element_path  if path.empty? #initialize path if not yet done
        padding = ''.ljust(indent * TAB_SIZE) # Leading spaces in display
        nice_path = PATH::map path
        if asn_element.value.is_a? Array
            # if nice_path
            #     puts "#{padding}#{nice_path}:"
            # else
            if asn_element.tag_class == :UNIVERSAL
                case asn_element.tag
                when 16 then puts "#{padding}SEQUENCE (#{path[-1]} - #{indent}):"
                when 17 then puts "#{padding}SET (#{path[-1]} - #{indent}):"
                else puts "#{padding}#{asn_element.tag_class}[#{asn_element.tag}] (#{path[-1]}):"
                end
            else
                puts "#{padding}#{asn_element.tag_class} [#{asn_element.tag} - #{indent}] (#{path[-1]}):"
            end
            # end
            asn_element.value.each do |node|
                local_path = path.clone
                local_path << ASNTool.path(node)
                dump_element(node, indent + 1, local_path)
            end
        else
            if asn_element.tag_class ==  :UNIVERSAL
                value = display_value(asn_element.value.to_s.strip)
                # if nice_path
                #     puts "#{padding}#{nice_path}: #{value}"
                # else
                #     # nice_path = path.join('/')
                nice_path = path[-1]
                case asn_element.tag
                when 1 then puts "#{padding}BOOL (#{nice_path} - #{indent}): #{value}"
                when 2 then puts "#{padding}INT (#{nice_path} - #{indent}): #{value}"
                when 3 then puts "#{padding}BITS (#{nice_path} - #{indent}): #{value}"
                when 4 then puts "#{padding}HEX (#{nice_path} - #{indent}): #{value}"
                when 5 then puts "#{padding}NULL"
                when 6 then puts "#{padding}OID (#{nice_path} - #{indent}): #{value}"
                when 10 then puts "#{padding}ENUM (#{nice_path} - #{indent}): #{value}"
                when 12 then puts "#{padding}UTF8 (#{nice_path} - #{indent}): #{value}"
                when 18 then puts "#{padding}NUM (#{nice_path} - #{indent}): #{value}"
                when 19 then puts "#{padding}STRING (#{nice_path} - #{indent}): #{value}"
                when 22 then puts "#{padding}MAIL (#{nice_path} - #{indent}): #{value}"
                when 23 then puts "#{padding}UTC (#{nice_path} - #{indent}): #{value}"
                when 24 then puts "#{padding}GMT (#{nice_path} - #{indent}): #{value}"
                when 26 then puts "#{padding}TEXT (#{nice_path} - #{indent}): #{value}"
                when 27 then puts "#{padding}TEXT (#{nice_path} - #{indent}): #{value}"
                when 28 then puts "#{padding}TEXT (#{nice_path} - #{indent}): #{value}"
                else puts "#{padding}[#{asn_element.tag_class}] #{asn_element.tag} (#{nice_path} - #{indent}): #{value}"
                end
            else
                puts "#{padding}[#{asn_element.tag_class}] #{asn_element.tag} (#{nice_path} - #{indent}): #{value}"
            end
        end
    end


    def display_value(rough_value)
        return '---' unless rough_value
        value = rough_value.strip
        value = value.ascii_only? ? value : value.unpack('H*').first
        value = value.size > 100 ? "#{value[0..100]}..." : value
        # result = ''
        # value.each_byte { |byte| puts byte.to_s('H')}
        # value.each_byte { |byte| result << byte.to_i < 32 ? ('..') : byte}
        # result
    end

    class Pattern

        def initialize(searched_path_string)
            @searched_path = searched_path_string.split '/' # Convert in arrzay
        end

        def match?(path)
            return false if path.length != @searched_path.length # if array-sizes are different, no match
            right_way?(path) # else, knowing lengths are identical, compare them
        end

        def right_way?(path)
            # For the length of path, check that all elements are identical
            path.size.times { |i| return false unless path[i] == @searched_path[i]}
            true
        end
    end


    class ASNExtractor

        def initialize(asn, search_path)
            @result = []
            @pattern = Pattern.new(search_path)
            extract(asn)
        end

        def extract(asn, path = [])
            path << ASNTool::path(asn) if path.empty?
            if asn.value.is_a? Array
                asn.value.each do |node|
                    local_path = path.clone
                    local_path << ASNTool::path(node)
                    extract(node, local_path) if @pattern.right_way?(local_path)
                end
            else
                @result << (asn.value.strip || '_NONE_') if @pattern.match?(path) and asn.value # Special case for nil values
            end
            nil
        end

        def result
            @result
        end
    end

end