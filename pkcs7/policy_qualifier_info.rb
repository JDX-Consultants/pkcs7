class PolicyQualifierInfo < Sequence

    CHILDREN = [
        { name: 'policyQualifierID', class_name: 'OIDNode' },
        { name: 'qualifier', class_name: 'AnyNode' },
    ]

end