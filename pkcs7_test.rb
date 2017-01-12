#!/usr/bin/env ruby

require 'origami'
Dir[File.join(File.dirname(__FILE__), 'pkcs7', '*.rb')].each {|file| require file }

include Origami

doc = Origami::PDF.read './arbressignandTSA.pdf'
# doc = Origami::PDF.read './signed.pdf'


def value(content, offset, length)
    val = content[offset..offset + length + 1]
    val = val.strip
    val = val.ascii_only? ? val : val.unpack('H*').first
    val = (val.size > 100 ? "#{val[0..100]}..." : val)
    val
end

# puts "Initial traverse"
# content = doc.signature.to_hash[:Contents].strip
# OpenSSL::ASN1.traverse(content) do | depth, offset, header_len, length, constructed, tag_class, tag|
#     puts "#{''.ljust(depth * 2)}#{tag_class[0]}#{tag}: #{constructed ? '': value(content, offset, length)}"
# end

PKCS7Builder.instance.parse(doc.signature.to_hash[:Contents].strip)

PKCS7Builder.instance.dump