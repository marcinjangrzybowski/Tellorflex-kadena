## Overview of the Pact Modules

Here we are giving breif overview of how implementation of Tellorflex in Pact is strucutred, while introducing basic concepts of Pact language.

Key modules like `tellorflex.pact`, `governance.pact`, `autopay.pact` were devised to reproduce Tellor functionalities in Pact. They are replicating functionalities of analogous solidity contract also developed by Tellor team.

1. `tellorflex.pact` forms the nucleus of the Tellor oracle system implementation, encapsulating critical operations like staking, reporting, slashing, and data retrieval. 

```pact
(module tellorflex NOT-UPGRADEABLE
  (implements i-governance)
    
  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))
  
  ; other capabilities...
  
  ; table schemas...
  
  ; main functions...
  
  ; getters
  
  ; helper functions
)

; initialisation
```

2. The `governance.pact` module is in charge of the oracle's governance strategy and the voting method.

```pact
(module governance NOT-UPGRADEABLE
  (implements i-governance)
  
  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))

  ; other capabilities...
  
  ; schemas...
  
  ; main functions...
  
)
```

(TODO : comment on similarites)

## Schema, Tables, and Objects

In Pact, each table's data structure is defined by a schema. For example, the `constructor-schema` in `tellorflex.pact` declares the global variables and their data types.

```pact
(defschema constructor-schema
  tellorflex-account:string 
  accumulated-reward-per-share:integer 
  ; rest of the properties...
)
```

Tables in Pact are SQL-like structures used to store typed data, where each row corresponds to an object matching the table's schema.

```pact
(deftable global-variables:{constructor-schema})
```

Pact also supports object schemas to outline complex data types. In `tellorflex.pact`, the `timestamp-dispute-object` defines the structure of a report's timestamp and its potential disputed status.

```pact
(defschema timestamp-dispute-object
  timestamp:integer  
  disputed:bool)
```

## Capabilities

Capabilities, a core security feature in Pact, controls access rights within a module. `NOT-UPGRADEABLE`, `TELLOR`, `PRIVATE`, `STAKER`, and `GOV_GUARD` are some capabilities defined in `tellorflex.pact`. 

```pact
(defcap TELLOR ()
  "Capability to enforce admin-only operations"
  ; enforcement logic...
)
```

## Functions

A module mainly includes three types of functions: Main, Getter, and Helper functions.

```pact
(defun constructor:string  ; main function
  tellorflex-account:string
  ; parameters...
)

(defun get-query-data:string (query-id:string)  ; getter function
  (at 'query-data (read storage query-id))
)

(defun calc-total-rewards (reward-details idx)  ; helper function
  ; implementation...
)
```

## Event Capabilities

Event capabilities facilitates real-time updates, thus allowing participants to be abreast of changes directly from contract actions. For instance, in `tellorflex.pact`, the `NewReport` event capability signals the arrival of new information to the consumers.

## Constants

Some module-wide constants are defined using `defconst` in Pact. These can be of any simple type such as string, integer, decimal or boolean.

``` pacts
(defconst TIME_BASED_REWARD (* 5 (^ 10 17))  
  "Amount of TRB rewards released per 5 minutes"
)
```

## Conclusion

Replicating the TellorFlex Decentralized Oracle System on Kadena's Pact harnesses the unique security attributes and simplicity of the Pact language. Its modular structure encases functionalities and restricts actions using Capabilities, making the contract not only secure, but also readable. 
