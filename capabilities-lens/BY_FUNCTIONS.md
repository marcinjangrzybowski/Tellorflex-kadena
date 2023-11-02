| File | Function | Capability Required | Capability Granted |
|-----------|-------------------|-------------------|-------------------|
| autopay.pact | constructor | None | PRIVATE, f-TRB.TRANSFER |
| autopay.pact | claim-one-time-tip | PRIVATE | f-TRB.TRANSFER |
| autopay.pact | calc-total-rewards | PRIVATE | None |
| autopay.pact | search | PRIVATE | None |
| autopay.pact | get-one-time-tip-amount | PRIVATE | None |
| f-TRB.pact | TRANSFER-mgr | None | DEBIT, CREDIT |
| f-TRB.pact | TRANSFER_XCHAIN-mgr | None | DEBIT |
| f-TRB.pact | create-account | ROTATE | None |
| f-TRB.pact | transfer | TRANSFER | None |
| f-TRB.pact | transfer-create | TRANSFER | None |
| f-TRB.pact | mint | GOVERNANCE, CREDIT | None |
| f-TRB.pact | debit | DEBIT | None |
| f-TRB.pact | credit | CREDIT | None |
| f-TRB.pact | transfer-crosschain | TRANSFER_XCHAIN | CREDIT |
| governance.pact | register-gov-guard | TELLOR | None |
| governance.pact | begin-dispute | None | PRIVATE |
| governance.pact | execute-vote | None | PRIVATE |
| governance.pact | tally-votes | None | PRIVATE |
| governance.pact | vote | None | PRIVATE |
| governance.pact | transfer-from-gov | PRIVATE | f-TRB.TRANSFER |
| governance.pact | vote-passed | PRIVATE | None |
| governance.pact | vote-invalid | PRIVATE | None |
| governance.pact | vote-failed | PRIVATE | None |
| governance.pact | calculate-vote-to-scale | PRIVATE | None |
| governance.pact | insert-vote-info | PRIVATE | None |
| governance.pact | replace-key-value | PRIVATE | None |
| governance.pact | get-user-tips | PRIVATE | None |
| tellorflex.pact | constructor | TELLOR | None |
| tellorflex.pact | init | TELLOR | None |
| tellorflex.pact | add-staking-rewards | PRIVATE | None |
| tellorflex.pact | add-staker | PRIVATE | None |
| tellorflex.pact | deposit-stake | PRIVATE, STAKER | None |
| tellorflex.pact | remove-value | GOV_GUARD | None |
| tellorflex.pact | request-staking-withdraw | STAKER | None |
| tellorflex.pact | slash-reporter | GOV_GUARD | None |
| tellorflex.pact | submit-value | STAKER | None |
| tellorflex.pact | withdraw-stake | STAKER | None |
| tellorflex.pact | get-data-before | PRIVATE | None |
| tellorflex.pact | get-pending-reward-by-staker | PRIVATE | None |
| tellorflex.pact | get-real-staking-rewards-balance | PRIVATE | None |
| tellorflex.pact | transfers-from-flex | PRIVATE | None |
| tellorflex.pact | transfers-to-flex | PRIVATE | None |
| tellorflex.pact | update-rewards | PRIVATE | None |
| tellorflex.pact | update-stake-and-pay-rewards | PRIVATE | None |
| tellorflex.pact | get-updated-accumulated-reward-per-share | PRIVATE | None |
| tellorflex.pact | accumulated-reward | PRIVATE | None |
| tellorflex.pact | calculate-time-based-reward | PRIVATE | None |
| tellorflex.pact | calculate-reward-rate | PRIVATE | None |
| tellorflex.pact | new-accumulated-reward-per-share | PRIVATE | None |
| tellorflex.pact | pending-new-accumulated-reward-per-share | PRIVATE | None |
| tellorflex.pact | search-if-disputed | PRIVATE | None |
| tellorflex.pact | binary-search | PRIVATE | None |