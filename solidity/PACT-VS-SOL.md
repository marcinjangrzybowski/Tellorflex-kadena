# Tellor's `begin-dispute` function: A comparison between Solidity and Pact Implementations

In this document, we will compare the implementation of Tellor's `begin-dispute` function in both Solidity and Pact programming languages. The objective is to showcase the syntax, functional similarities, and distinct features offered by both languages, assuming the reader has a foundational understanding of Solidity. The comparison serves as a pedagogical introduction to the Pact, smart contract languages with its own unique set of features.

Solidity version of discussed code comes from [/solidity/Governance.sol](/Governance.sol#L111C5-L179C6)

Pact version comes from [/modules/governance.pact](../modules/governance.pact#L120C1-L216C4)

## Overview of `begin-dispute` Function

The `begin-dispute` function is a key component of Tellor's oracle service, enabling users to initiate disputes over submitted data through a given query ID and timestamp. The function ensures the existence of a report for the specified timestamp and subsequently handles various mechanics like creating new voting rounds, transferring fees, and slashing the stake of a reporter in case of false reporting.

Now, let's delve into comparing the specifics of this function as implemented in Solidity and Pact.

## Function Signature

**Solidity (Ethereum):**


```solidity
function beginDispute(bytes32 _queryId, uint256 _timestamp) external {...}
```

 The `external` modifier used here restricts the function invocation to external calls only.

**Pact (Kadena):**


```pact
(defun begin-dispute:bool (account:string query-id:string timestamp:integer) {...})
```


## Checking Report Existence

**Solidity:**
In Solidity, it's necessary to use the `require` statement to validate if a report exists for the given timestamp and query ID.

```solidity
require(
    oracle.getBlockNumberByTimestamp(_queryId, _timestamp) != 0,
    "no value exists at given timestamp"
);
```

The `require` statement here will throw an exception if no report values are returned for the specified timestamp.

**Pact:**
Pact substitutes `require` with the `enforce` keyword, yielding similar functionality.

```pact
(enforce (!= block-number 0)
  (format "No value exists at given timestamp {}"[block-number]))
```

The `enforce` keyword declares a condition that must be fulfilled. In case of failure, an error with the provided message is raised.

## Inserting Data for a New Vote Round 

**Solidity:** 
Solidity manages disputes using mappings and arrays and employs them to facilitate dispute management.

```solidity
_voteRounds.push(_disputeId);
thisVote.identifierHash = _hash;
```

**Pact:** 
Pact, on the other hand, integrates seamless database operation handling within the language. 

```pact
(insert dispute-info (str dispute-id)
    { 
        "query-id": query-id,
        "timestamp": timestamp,
        "value": (tellorflex.retrieve-data query-id timestamp),
        "disputed-reporter": disputed-reporter,
        "slashed-amount": (tellorflex.slash-reporter disputed-reporter (gov-account))
    })
```

This eliminates the need for a separate mapping or array and directly stores the data into a dedicated `dispute-info` table.

## Regulatory Mechanisms

Both Solidity and Pact use their respective control structures to ensure specific conditions are adhered to in creating a dispute.

**Solidity:** 

```solidity
require(
    block.timestamp - _timestamp < 12 hours,
    "Dispute must be started within reporting lock time"
);
```

**Pact:** 

```pact
(enforce (< (- block-time timestamp) TWELVE_HOURS)
    "Dispute must be started within reporting lock time"
)
```

## Final Thoughts

The comparison above provides a direct measure of the similarities and differences between Solidity and Pact in implementing a function central to the Tellor oracle, `begin-dispute`. 

Pact especially stands out with its declarative nature, inbuilt database operations, enhanced security with capabilities, and robust provision for contract upgrade potential.
