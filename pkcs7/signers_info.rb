require_relative 'array_node'
    
class SignersInfo < SetOf

    CHILD = { name: 'signersInfo', class_name: 'SignerInfo' }

end

# SignerInfos ::= SET OF SignerInfo