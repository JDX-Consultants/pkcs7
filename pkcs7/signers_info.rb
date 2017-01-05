require_relative 'array_node'
    
class SignersInfo < SetOf

    CHILD = Child.new('signersInfo', 'SignerInfo')

end

# SignerInfos ::= SET OF SignerInfo