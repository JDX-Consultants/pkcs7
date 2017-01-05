require_relative 'sequence'

class PKCS7Root < Sequence

    CHILDREN = [Child.new('contentInfo', 'ContentInfo')]

end