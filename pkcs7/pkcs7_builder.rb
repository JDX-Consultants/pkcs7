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
        content_info = ContentInfo.new
        content_info.name = 'contentInfo'
        content_info.level = 0
        @root << content_info
        content_info.parse_element root_asn, 0
    end

    def dump
        @root.dump(0)
    end

end