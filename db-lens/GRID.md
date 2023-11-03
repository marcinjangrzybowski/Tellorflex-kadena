Table for **tellorflex.pact**:

|                       | *staker-details* | *reports-submitted-count* | *reports* | *timestamps* | *global-variables* | *governance-table* | *gov-guard* |
|-----------------------|------------------|---------------------------|-----------|--------------|--------------------|--------------------|-------------|
| **tellorflex.pact**   |                  |                           |           |              |                    |                    |             |
| *add-staker*          | I, W, U          |                           |           |              |                    |                    |             |
| *withdraw-stake*      | R, W, U          |                           | R         |              | R                  |                    |             |
| *get-pending-reward-by-staker* | R    |                           |           |              |                    |                    |             |
| *get-staker-info*     | R                |                           |           |              |                    |                    |             |
| *get-reports-submitted-by-address* | R  |                           |           |              |                    |                    |             |
| *submit-value*        | R, U             | I, W                      | I, R      | I, W, U      |                    |                    |             |
| *get-block-number-by-timestamp* |        |                           | R         |              |                    |                    |             |
| *get-report-details*  |                  |                           | R         |              |                    |                    |             |
| *get-reporter-by-timestamp* |            |                           | R         |              |                    |                    |             |
| *is-in-dispute*       |                  |                           | R         |              |                    |                    |             |
| *remove-value*        |                  |                           | R, W      | R, U         |                    |                    |             |
| *retrieve-data*       |                  |                           | R         |              |                    |                    |             |
| *request-staking-withdraw* | R, U        |                           |           |              | U                  |                    |             |
| *slash-reporter*      | R, U             |                           |           |              | U                  |                    |             |
| *update-stake-and-pay-rewards* |         |                           |           |              | R, U               |                    |             |
| *deposit-stake*       | R, U             |                           |           |              | R, U               |                    |             |
| *tellorflex-account*  |                  |                           |           |              | R                  |                    |             |
| *accumulated-reward-per-share* |          |                           |           |              | R                  |                    |             |
| *minimum-stake-amount* |                 |                           |           |              | R                  |                    |             |
| *reporting-lock*      |                  |                           |           |              | R                  |                    |             |
| *reward-rate*         |                  |                           |           |              | R                  |                    |             |
| *stake-amount*        |                  |                           |           |              | R                  |                    |             |
| *stake-amount-dollar-target* |            |                           |           |              | R                  |                    |             |
| *staking-rewards-balance* |               |                           |           |              | R                  |                    |             |
| *staking-token-price-query-id* |          |                           |           |              | R                  |                    |             |
| *time-based-reward*   |                  |                           |           |              | R                  |                    |             |
| *time-of-last-allocation* |               |                           |           |              | R                  |                    |             |
| *time-of-last-new-value* |                |                           |           |              | R                  |                    |             |
| *total-reward-debt*   |                  |                           |           |              | R                  |                    |             |
| *total-stake-amount*  |                  |                           |           |              | R                  |                    |             |
| *total-stakers*       |                  |                           |           |              | R                  |                    |             |
| *to-withdraw*         |                  |                           |           |              | R                  |                    |             |
| *get-real-staking-rewards-balance* |       |                           |           |              | R                  |                    |             |
| *calculate-reward-rate* |                |                           |           |              | R                  |                    |             |
| *add-staking-rewards* |                  |                           |           |              | R, U               |                    |             |
| *update-stake-amount* |                  |                           |           |              | R, U               |                    |             |
| *get-governance-module* |                |                           |           |              |                    | R                  |             |
| *init-gov-guard*      |                  |                           |           |              |                    |                    | I           |
| *init*                |                  |                           |           |              |                    | I                  |             |
| *constructor*         |                  |                           |           |              | I                  |                    |             |

Table for **autopay.pact**:

| Functions               |global |tips  |query-ids-with-funding-index |user-tips-total |
|-------------------------|-------|------|-----------------------------|----------------|
| constructor             | I     |      |                             |                |
| claim-one-time-tip      | R     | R    | R                           |                |
| fee                     | R     |      |                             |                |
| tip                     |       | RW   | RW                          | I              |
| get-one-time-tip-amount |       | RU   |                             |                |
| get-current-tip         |       | R    |                             |                |
| get-past-tips           |       | R    |                             |                |
| get-past-tip-by-index   |       | R    |                             |                |
| get-query-ids-with-funding-index |   |  | R                           |                |
| get-tips-by-user        |       |      |                             | R              |

Table for **f-TRB.pact**:

| Functions          | coin-table |
|--------------------|------------|
| create-account     | I          |
| get-balance        | R          |
| details            | R          |
| rotate             | RU         |
| transfer           | W          |
| debit              | U          |
| credit             | WU         |

Table for **governance.pact**:

| Functions          | dispute-ids-by-reporter | dispute-info | global | open-disputes-on-id | vote-info | vote-rounds | vote-tally-by-address |
|--------------------|-------------------------|--------------|--------|---------------------|-----------|-------------|----------------------|
| constructor        | I                       |              | I      |                     |           |             |                      |
| begin-dispute      | RWIU                    | I            | UR     | RU                  |           | W           |                      |
| execute-vote       |                         | R            | R      | RU                  | RU        |             |                      |
| tally-votes        |                         |              | R      |                     | U         |             |                      |
| vote               |                         |              | R      |                     | WU        |             | W                    |

Table for **query-data-storage.pact**:

| Functions   |  storage |
|-------------|----------|
| store-data  | I        |
| get-data    | R        |