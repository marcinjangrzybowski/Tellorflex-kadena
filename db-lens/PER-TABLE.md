|                       | Inserts          | Reads   | Writes  | Updates                           |
|-----------------------|------------------|---------|---------|-----------------------------------|
| **autopay.pact**      |                  |         |         |                                   |
| *global*              | constructor      | claim-one-time-tip, autopay-account, fee             |      | claim-one-time-tip             |
| *tips*                |                  | claim-one-time-tip, get-current-tip, get-past-tips, get-past-tip-by-index             | tip | tip, get-one-time-tip-amount |
| *query-ids-with-funding-index* |         | claim-one-time-tip, get-query-ids-with-funding-index             | tip | claim-one-time-tip, tip            |
| *user-tips-total*     | tip              | get-tips-by-user             |      |                               |
| **f-TRB.pact**        |                  |         |         |                                   |
| *coin-table*          | create-account   | get-balance, details, rotate         | transfer     | rotate, debit, credit                            |
|                      |                  |         |         |                                   |
| **governance.pact**   |                  |         |         |                                   |
| *dispute-ids-by-reporter* | begin-dispute | get-disputes-by-reporter    | begin-dispute | begin-dispute                            |
| *dispute-info*        | begin-dispute    | execute-vote, get-dispute-info | slash-reporter    | execute-vote                        |
| *global*              | constructor      | gov-account, vote-count, get-vote-count               | begin-dispute, execute-vote, vote             |
| *open-disputes-on-id* | begin-dispute    | get-open-disputes-on-id    | execute-vote | begin-dispute, execute-vote                            |
| *vote-info*           | insert-vote-info | execute-vote, tally-votes, vote, did-vote, get-vote-info | execute-vote, tally-votes, vote | execute-vote, tally-votes, vote                            |
| *vote-rounds*         | begin-dispute    | get-vote-rounds        | begin-dispute |                               |
| *vote-tally-by-address* | vote            | get-vote-tally-by-address |      |                               |
|                       |                  |         |         |                                   |
| **query-data-storage.pact** |             |         |         |                                   |
| *storage*             | store-data       | get-query-data         |       |              |
|                       |                  |         |         |                                   |
| **tellorflex.pact**   |                  |         |         |                                   |
| *staker-details*      | add-staker       | withdraw-stake, get-pending-reward-by-staker, get-staker-info, get-reports-submitted-by-address | withdraw-stake, deposit-stake | update-stake-and-pay-rewards, slash-reporter, deposit-stake, withdraw-stake, add-staker |
| *reports-submitted-count* | submit-value | get-reports-submitted-by-address-and-queryId | submit-value |                               |
| *reports*             | submit-value     | get-block-number-by-timestamp, get-report-details, get-reporter-by-timestamp, is-in-dispute, remove-value, retrieve-data, submit-value | remove-value |                               |
| *timestamps*          | submit-value     | get-data-before, get-new-value-count-by-query-id, get-timestamp-index-by-timestamp, get-timestampby-query-id-and-index | submit-value | submit-value, remove-value                            |
| *global-variables*    | constructor      | tellorflex-account, accumulated-reward-per-share, minimum-stake-amount, reporting-lock, reward-rate, stake-amount, stake-amount-dollar-target, staking-rewards-balance, staking-token-price-query-id, time-based-reward, time-of-last-allocation, time-of-last-new-value, total-reward-debt, total-stake-amount, total-stakers, to-withdraw, get-real-staking-rewards-balance, calculate-reward-rate, add-staking-rewards, deposit-stake, withdraw-stake, update-stake-and-pay-rewards, update-stake-amount  | add-staking-rewards, deposit-stake, withdraw-stake | update-stake-and-pay-rewards, add-staking-rewards, slash-reporter, deposit-stake, withdraw-stake, update-stake-amount                            |
| *governance-table*    | init             | get-governance-module             |       |              |
| *gov-guard*           | init-gov-guard   |           |         |                       |