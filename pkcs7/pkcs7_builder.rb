Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class PKCS7Builder

    def initialize(root, name)
        @root = eval "#{root}.new"
        @root.name = name
        Debug.instance.turn_off
    end

    def parse(der)
        @root.parse_element(OpenSSL::ASN1.decode(der), 0)
    end

    def dump(out, level = 0)
        @root.dump(out, level)
    end

end