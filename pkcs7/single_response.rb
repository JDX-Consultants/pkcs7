class SingleResponse < Sequence

    CHILDREN = [
        { name: 'certID', class_name: 'IntegerNode'  },
        { name: 'certStatus', class_name: 'AnyNode' }, # Should be a choice here
        { name: 'thisUpdate', class_name: 'DateNode' },
        { name: 'nextUpdate', class_name: 'DateNode', context_specific: 0 },
        { name: 'singleExtensions', class_name: 'Extensions', context_specific: 1 },
    ]

end


  # SingleResponse ::= SEQUENCE {
  #     certID                       CertID,
  #     certStatus                   CertStatus,
  #     thisUpdate                   GeneralizedTime,
  #     nextUpdate         [0]       EXPLICIT GeneralizedTime OPTIONAL,
  #     singleExtensions   [1]       EXPLICIT Extensions OPTIONAL }
 
  #  CertStatus ::= CHOICE {
  #      good        [0]     IMPLICIT NULL,
  #      revoked     [1]     IMPLICIT RevokedInfo,
  #      unknown     [2]     IMPLICIT UnknownInfo }
 
  #  RevokedInfo ::= SEQUENCE {
  #      revocationTime              GeneralizedTime,
  #      revocationReason    [0]     EXPLICIT CRLReason OPTIONAL }
