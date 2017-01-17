class PolicyInformation < Sequence

    CHILDREN = [
        { name: 'policyIdentifier', class_name: 'OIDNode' },
        { name: 'policyQualifiers', class_name: 'PolicyQualifierInfos' },
    ]
end