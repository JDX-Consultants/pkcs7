#!/usr/bin/env ruby

require 'openssl'
require 'origami'
require 'net/http'
require 'uri'
require 'base64'
require 'nokogiri'
require 'pp'

include Origami

def path(asn)
    "#{asn.tag_class.to_s[0]}#{asn.tag}"
end

def dump_asn(asn, indent = 0)
    path = path(asn)
    if asn.value.is_a? Array
        if asn.tag_class == :UNIVERSAL
            case asn.tag
            when 16 then puts "#{''.ljust(indent * 4)}SEQUENCE (#{path}):"
            when 17 then puts "#{''.ljust(indent * 4)}SET (#{path}):"
            else puts "#{''.ljust(indent * 4)}#{asn.tag_class}[#{asn.tag}] (#{path}):"
            end
        else
            puts "#{''.ljust(indent * 4)}#{asn.tag_class} [#{asn.tag}] (#{path}):"
        end
        asn.value.each { |node| dump_asn(node, indent + 1) }
    else
        if asn.tag_class ==  :UNIVERSAL
            value = asn.value || ''
            case asn.tag
            when 1 then puts "#{''.ljust(indent * 4)}Bool (#{path}): #{value}"
            when 2 then puts "#{''.ljust(indent * 4)}Int (#{path}): #{value}"
            when 3 then puts "#{''.ljust(indent * 4)}Bits (#{path}): #{value.unpack('H')}"
            when 4 then puts "#{''.ljust(indent * 4)}Bin (#{path}): #{value.ascii_only? ? value : value.unpack('H*').first}"
            when 5 then puts "#{''.ljust(indent * 4)}Null"
            when 6 then puts "#{''.ljust(indent * 4)}OID (#{path}): #{value}"
            when 19 then puts "#{''.ljust(indent * 4)}String (#{path}): #{value}"
            when 22 then puts "#{''.ljust(indent * 4)}Mail (#{path}): #{value}"
            when 23 then puts "#{''.ljust(indent * 4)}Date (#{path}): #{value}"
            else puts "#{''.ljust(indent * 4)}[#{asn.tag_class}] #{asn.tag} (#{path}): #{value}"
            end
        else
            puts "#{''.ljust(indent * 4)}[#{asn.tag_class}] #{asn.tag} (#{path}): #{value}"
        end
    end
end


class ASNExtractor

    class Pattern

        def initialize(searched_path)
            @searched_path = searched_path
        end

        def match?(path)
            return false if path.length != @searched_path.length
            right_way?(path)
        end

        def right_way?(path)
            path.size.times { |i| return false unless path[i] == @searched_path[i]}
            true
        end
    end

    def initialize(asn, search_path)
        extract(asn, Pattern.new(search_path))
    end

    def extract(asn, pattern, path = [], result = nil)
        path << path(asn) if path.empty?
        if asn.value.is_a? Array
            asn.value.each do |node|
                local_path = path.clone
                local_path << path(node)
                extract(node, pattern, local_path) if pattern.right_way?(local_path)
            end
        else
            @result = asn.value || '_NONE_' if pattern.match?(path)# Special case for nil values
        end
        nil
    end

    def result
        @result
    end
end


doc = Origami::PDF.read './Simple.pdf'

doc_info = doc.document_info
# puts "Class: #{doc_info.class}"
# puts doc_info

doc_info[Origami::Name.new('Mon architecte préféré')] = 'Alain Mouligneaux'

certificate = OpenSSL::X509::Certificate.new File.read 'cert.pem'
private_key = OpenSSL::PKey::RSA.new File.read 'key.pem'
page = doc.get_page 1

# puts "Page methods: #{page.public_methods}"


width = 200.0
height = 50.0
x = page.MediaBox[2].to_f - width - height
y = height
size = 8

text_annotation = Annotation::AppearanceStream.new
text_annotation.Type = Origami::Name.new("XObject")
text_annotation.Resources = Resources.new
text_annotation.Resources.ProcSet = [Origami::Name.new("Text")]
text_annotation.set_indirect(true)
text_annotation.Matrix = [ 1, 0, 0, 1, 0, 0 ]
text_annotation.BBox = [ 0, 0, width, height ]
text_annotation.write("Signed at #{DateTime.now.iso8601}", x: size, y: (height/2)-(size/2), size: size)

signature_annotation = Annotation::Widget::Signature.new
signature_annotation.Rect = Rectangle[llx: x, lly: y+height, urx: x+width, ury: y]
signature_annotation.F = Annotation::Flags::PRINT
signature_annotation.set_normal_appearance(text_annotation)

page.add_annotation(signature_annotation)



puts "Signing"
doc.sign(certificate, private_key, annotation: signature_annotation, location: 'Belgium', method: 'adbe.pkcs7.sha1')

doc.save 'signed.pdf'

signature = doc.signature

objects = signature.to_o
binary = "<No content>"
# puts objects
objects.each_key do |key|
    if key.to_s.include? 'Contents'
        binary = objects[key].to_s
        # puts "======> '#{key}' [#{objects[key].class}] : #{objects[key].inspect}"
    end
end

puts "ASN.1 decoding"
der = [(binary[1..-2])].pack('H*')
File.write 'signature.bin', der
asn1 = OpenSSL::ASN1.decode der

dump_asn(asn1)

# hash = ASNExtractor.new(asn1, %w(U16 C0 U16 U16 C0 U4)).result.unpack('H*').first
# puts "Hash value: '#{hash}'"


# # Get a timestamp
# uri = URI.parse("http://tsa.belgium.be/web")
# data = {action: 'requestTimeStamp', hash: hash, hashEncoding: 'hex', hashAlgorithm: 'SHA1', policyOID: '2.16.56.9.3.2', certRequired: true}
# res = Net::HTTP.post_form(uri, data)
# # puts "Post result: #{res.body}"

# html_doc = Nokogiri::HTML res.body
# time_stamp = html_doc.xpath("//textarea[@id='timestamp']").first.content

# puts "Time Stamp: #{time_stamp}"

# ts_asn = OpenSSL::ASN1.decode Base64.decode64 time_stamp

# puts "\n\nDecoded time stamp"
# dump_asn(ts_asn, 0)

# class Origami::PDF
#     def insert_sign(signature_base64)
#         #convert the base64 encoded signature to binary
#         signature = Base64.decode64 signature_base64

#         unless Origami::OPTIONS[:use_openssl]
#             fail "OpenSSL is not present or has been disabled."
#         end
#         begin
#             digsig = self.signature
#         rescue  SignatureError
#             raise "Document is not prepared for insert sign, call method prepare_for_sign first"
#         end

#         #insert signature to Contents field
#         #digsig.Contents[0, signature.size] = signature
#         # signature = OpenSSL::PKCS7.new(signature).to_der
#         digsig.Contents[0, signature.size] = signature

#         #
#         # No more modification are allowed after signing.
#         #
#         self.freeze

#     end
# end


# doc.insert_sign(time_stamp)


# doc.save './signed-and-time-stamped.pdf'
 doc.save './signed.pdf'

# doc.each_page do |page|
#   i = i ? i + 1 : 1
#   puts "Page #{i}: #{page.inspect}"
#   puts "Methods: #{page.public_methods}"
#   page.each_content_stream do |stream|
#       puts "Stream: #{stream}"
#       # puts "Stream methods: #{stream.public_methods}"
#   end
# end

# puts "Reopening improved.pdf file"
# doc = Origami::PDF.read './improved.pdf'
# puts "Is new document signed: #{doc.signed?}"

# if doc.signed?
#   puts "Signature"
#   puts doc.signature
# end

# puts "Testing with signed by eID"
# puts doc.signature
# doc = Origami::PDF.read './feries_s2.pdf'
# puts doc.signature


# doc.attach_file './Second.pdf'

# doc.save './double_simple.pdf'

