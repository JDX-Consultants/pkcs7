#!/usr/bin/env ruby

require 'origami'
Dir[File.join(File.dirname(__FILE__), 'pkcs7', '*.rb')].each {|file| require file }

include Origami

doc = Origami::PDF.read './arbressignandTSA.pdf'
# doc = Origami::PDF.read './signed.pdf'

builder = PKCS7Builder.new('ContentInfo', 'contentInfo')
builder.parse(doc.signature.to_hash[:Contents].strip)

builder.dump