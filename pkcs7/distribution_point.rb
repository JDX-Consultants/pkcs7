class DistributionPoint < Sequence

CHILDREN = [
    {name: 'distributionPoint', class_name: 'GeneralNames', context_specific: 0, optional: true},
    {name: 'reasons', class_name: 'AnyNode', context_specific: 1, optional: true},
    {name: 'cRLIssuer', class_name: 'GeneralNames', context_specific: 2, optional: true},
]


end

# DistributionPoint ::= SEQUENCE {
#      distributionPoint       [0]     DistributionPointName OPTIONAL,
#      reasons                 [1]     ReasonFlags OPTIONAL,
#      cRLIssuer               [2]     GeneralNames OPTIONAL }
