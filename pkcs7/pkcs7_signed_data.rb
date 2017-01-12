require_relative 'sequence'
    
class PKCS7SignedData < Sequence

    CHILDREN = [{ name: 'signedData', class_name: 'SignedData' }]

end