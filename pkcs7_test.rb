#!/usr/bin/env ruby

require 'origami'
Dir[File.join(File.dirname(__FILE__), 'pkcs7', '*.rb')].each {|file| require file }

include Origami

doc = Origami::PDF.read './arbressignandTSA.pdf'
# doc = Origami::PDF.read './signed.pdf'

PKCS7Builder.instance.parse(doc.signature.to_hash[:Contents].strip)

PKCS7Builder.instance.dump