class ResponseBytes < Sequence


    CHILDREN = [
        { name: 'responseType', class_name: 'OIDNode' },
        { name: 'response', class_name: 'BinaryNode' },
    ]


    def dump(out, indent)
        response = instance_with_tag(:U4)
        builder = PKCS7Builder.new('BasicOCSPResponse', "EXPANDED from 'BasicOCSPResponse'")
        builder.parse(response.value)
        output = ''
        builder.dump(output, level + 3)
        response.dump_value = output
        super(out, indent)
    end
end

# ResponseBytes ::=       SEQUENCE {
#       responseType   OBJECT IDENTIFIER,
#       response       OCTET STRING }
