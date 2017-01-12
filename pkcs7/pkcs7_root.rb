require_relative 'sequence'

class PKCS7Root < Sequence

    CHILDREN = [{ name: 'contentInfo', class_name: 'ContentInfo' }]

end