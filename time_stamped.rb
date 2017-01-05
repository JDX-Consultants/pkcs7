#!/usr/bin/env ruby

require 'openssl'
require 'origami'
require 'net/http'
require 'uri'
require 'base64'
require 'nokogiri'
require 'pp'
require './asn_tool'

include Origami


class Origami::PDF

    def signatures
        signatures_array = []

        self.each_field do |field|
            if field.FT == :Sig and field.V.is_a?(Dictionary)
                signatures_array << field.V
            end
        end
        if signatures_array.size > 0
            return signatures_array
        else
            raise SignatureError, "Cannot find digital signature"
        end
    end


    def insert_sign(signature_base64)
        #convert the base64 encoded signature to binary
        signature = Base64.decode64 signature_base64

        unless Origami::OPTIONS[:use_openssl]
            fail "OpenSSL is not present or has been disabled."
        end
        begin
            digsig = self.signature
        rescue  SignatureError
            raise "Document is not prepared for insert sign, call method prepare_for_sign first"
        end

        #insert signature to Contents field
        #digsig.Contents[0, signature.size] = signature
        # signature = OpenSSL::PKCS7.new(signature).to_der
        digsig.Contents[0, signature.size] = signature

        #
        # No more modification are allowed after signing.
        #
        self.freeze

    end
end

def dump_block(title, asn_tool, path)
    puts "_______________________________________________________"
    puts title
    asn_tool.dump_element_as_asn(path)
end


doc = Origami::PDF.read './arbressignandTSA.pdf'
# doc = Origami::PDF.read './signed.pdf'

signatures = doc.signatures

signatures.each do |signature|
    objects = signature.to_o
    binary = "<No content>"
    objects.each_key do |key|
        if key.to_s.include? 'Contents'
            binary = objects[key]
        end
    end
    # File.write('signature.pem', binary.value)
    puts "--------------------------------"
    asn_tool = ASNTool.new(binary.value)
    asn_tool.dump
    dump_block('OCSP', asn_tool, 'U16/C0/U16/U17/U16/C0/U16/U17/U16/C1/U16/U16/C0/U16/U4')
    dump_block('CRL', asn_tool, 'U16/C0/U16/U17/U16/C1/U16/U17/U16/C0/U16/C0/U16/U16/C3/U16/U16/U4')
    dump_block('Authority Key identifiers', asn_tool, 'U16/C0/U16/U17/U16/C1/U16/U17/U16/C0/U16/C0/U16/U16/C3/U16/U16/U4')
    dump_block('Certificate policies', asn_tool, 'U16/C0/U16/C0/U16/U16/C3/U16/U16/U4')
end

# 
# This part uses the SSL::PKCS7 class (quite limited)
# signatures.each do |signature|
#     objects = signature.to_o
#     binary = "<No content>"
#     objects.each_key do |key|
#         if key.to_s.include? 'Contents'
#             binary = objects[key]
#         end
#     end
#     pkcs7 = OpenSSL::PKCS7.new binary
#     puts "Type: #{pkcs7.type}"
#     puts "Recipients:"
#     pkcs7.recipients.each do |recipient|
#         puts "Recipient class: #{recipient.class}"
#     end
#     puts "Signers:"
#     pkcs7.signers.each do |signer|
#         puts "Signer class: #{signer.class}"
#         # puts "Signer Methods: #{signer.methods}"
#         puts "Signer name: #{signer.name}"
#         puts "Signer issuer: #{signer.issuer}"
#         puts '-----'
#     end
#     puts "certificates:"
#     pkcs7.certificates.each do |cert|
#         puts "Certificate class: #{cert.class}"
#         # puts "Certificate methods: #{cert.methods}"
#         puts "Certificate Name: #{cert.subject}"
#         puts "Certificate Issuer: #{cert.issuer}"
#         puts "Certificate Serial: #{cert.serial}"
#         puts "Certificate not before: #{cert.not_before}"
#         puts "Certificate not after after: #{cert.not_after}"
#         puts '-----'
#     end
# end
