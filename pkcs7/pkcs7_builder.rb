Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

require_relative 'pkcs7_root'
require 'singleton'

class PKCS7Builder

    include Singleton

    def initialize
        @root = PKCS7Root.new
        @root.name = 'PKCS7'
        Debug.instance.turn_on
    end

    def parse(der)
        root_asn = OpenSSL::ASN1.decode(der)
        # puts "ROOT TAG: #{tag root_asn}"
        content_info = ContentInfo.new
        content_info.name = 'contentInfo'
        content_info.level = 0
        @root << content_info
        content_info.parse_element root_asn, 0
    end

    # def parse_element(asn_element, parent, level)
    #     puts "\n***** Start parsing element '#{tag(asn_element)}' using #{parent.class} at level #{level}"
    #     # begin
    #     if asn_element.value.is_a?(Array)
    #         asn_element.value.each do |asn_child_element|
    #             tag = tag(asn_child_element)
    #             Debug.instance.show "\n['#{tag}' in '#{parent.class}' [#{level}]"
    #             new_node = parent.instance_for_tag(tag, level + 1)
    #             raise "Could not create node in #{parent.class} for tag #{tag}" unless new_node
    #             parent << new_node
    #             new_node.tag = tag
    #             parse_element asn_child_element, new_node, level + 1
    #         end
    #         # puts "\nEnd parsing element #{parent.class}"
    #     else
    #         parent.value = asn_element.value.to_s
    #     end
    #     # rescue => e
    #     #     dump
    #     #     raise e
    #     # end
    # end

    def dump
        @root.dump(0)
    end

    # def tag(asn_node)
    #     "#{asn_node.tag_class.to_s[0]}#{asn_node.tag}"
    # end

end