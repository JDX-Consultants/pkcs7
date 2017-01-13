require_relative 'typed_sequence'
require_relative 'pkcs7_signed_data'
require_relative 'binary_node'


class ContentInfo < TypedSequence

    DATA_TYPES = {
        'pkcs7-signedData' => 'PKCS7SignedData',
        'pkcs7-data' => 'BinaryNode',
        'pkcs7-envelopedData' => 'EnvelopedData',
        'pkcs7-authenticatedData' => 'AuthenticatedData',
    }

    CHILDREN = [
        { name: 'contentType', class_name: 'ContentType' },
    ]

end