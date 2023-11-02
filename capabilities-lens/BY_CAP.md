| Capability | File | Function | Type |
|--------|----------|-------------|-------|
| NOT-UPGRADEABLE | Various Files | Various Functions | Required |
| PRIVATE | Various Files | Various Functions | Required/Granted |
| f-TRB.TRANSFER | autopay.pact | constructor, claim-one-time-tip | Granted |
| TELLOR | f-TRB.pact, governance.pact, tellorflex.pact | constructor, init | Required |
| DEBIT, CREDIT | f-TRB.pact | TRANSFER-mgr | Granted |
| DEBIT | f-TRB.pact | TRANSFER_XCHAIN-mgr | Granted |
| ROTATE | f-TRB.pact | create-account | Required |
| TRANSFER | f-TRB.pact | transfer, transfer-create | Required |
| GOVERNANCE, CREDIT | f-TRB.pact | mint | Required |
| DEBIT | f-TRB.pact | debit | Required |
| CREDIT | f-TRB.pact | credit, transfer-crosschain | Required |
| TRANSFER_XCHAIN | f-TRB.pact | transfer-crosschain | Required |
| GOV_GUARD | tellorflex.pact | remove-value, slash-reporter | Required |
| STAKER | tellorflex.pact | deposit-stake, request-staking-withdraw, submit-value, withdraw-stake | Required |