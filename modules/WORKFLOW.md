# Workflow

This document provides a comprehensive explanation of how Pact code from this module operates to implement the Tellor oracle system. It covers the significant processes that serve as the backbone of the Tellor ecosystem - Staking, Reporting, and Voting, inclusive of Dispute Resolution and Vote Execution.
It elucidates how each function operates in detail, emphasizing the specific validation checks, consequential steps, and important interactions involved. The objective is to present a clear and thorough understanding of how the Tellor system, poorted to Pact, effectively establishes a robust and secure environment for validators, reporters, and voters.

All snipets are excerpts from code in this directory.

## 1. Staking Process:

Staking is a core mechanism in the Tellor system, wherein validators (referred to as stakers) pledge collateral to ensure honest behavior. The staking process involves locking a specified amount of TRB tokens (Tellor's native cryptocurrency) to secure the right to submit data to the Tellor network.

**1.1. Initiating the Stake:**

A user initiates the staking process by invoking the `deposit-stake` function, providing their identifying information (staker's name or address), a guard for their account, and the amount of TRB tokens they wish to stake.

```pact
    (defun deposit-stake (staker:string guard:guard amount:integer) ...)
```

At the beginning of this function, there are checks to ensure that the amount pledged is non-negative.

**1.2. Adding the Staker:**

The function then interacts with the governance module to add the staker's details (staker's name and guard) to the contract's database. This is done using a combination of `PRIVATE` and `STAKER` capabilities.

```pact
    (with-capability (PRIVATE) (add-staker staker guard))
    (with-capability (STAKER staker) ...)
```

**1.3. Updating the Stake Amounts:**

Depending on whether the staker already has a locked balance and if it covers the staking amount, the function either uses that amount or subtracts the locked balance from the amount before transferring the remaining balance from the staker's account. The contract takes into account cases where the staked balance is more than or equal to the locked balance, or where the locked balance is zero.

```pact
    (with-read staker-details staker
        { 'locked-balance := locked-balance , 'staked-balance := staked-balance } ...)
```

If the staked balance is zero, the function also updates the start vote count and tally in the staker's information, which pulls the counts from the governance contract. This is an essential step for calculating rewards later on.

**1.4. Updating Staking Rewards and Transfer of Pending Rewards:**

After setting any balances, the function then updates the staker's stake amount and any pending rewards. The staker's start date is reset to the current block time.

```pact
    (update-stake-and-pay-rewards staker
        (+ (at 'staked-balance (read staker-details staker)) amount))
    (update staker-details staker { 'start-date: block-time } )
```

The process ends by emitting a `NewStaker` event that informs of a successful stake deposit.

**1.5. Event Emission:**

```Pact
    (emit-event (NewStaker staker amount))
```

This staking process enables validators to participate in the Tellor ecosystem actively and plays a crucial part in ensuring robustness and data integrity within the system. By tying the capability to report data to stakes, Tellor encourages honest participation, as malicious actions could lead to delegitimization and loss of staked resources. 

Pact provides a fluid approach for enforcing such processes with its high-level, human-readable language and control features like capabilities and guards. The staking process in Pact's implementation of Tellor becomes straightforward and efficient due to these characteristics.


## 2. Reporting Process

One of the central functionalities of the Tellor system is the process of reporting data - this is where the staked reporters can submit values to the oracle. The reporting process is initiated when a staked reporter calls the `submit-value` function. The discussions in this section center around this process and its intricacies:

```pact
(defun submit-value
      (query-id:string
       value:string  
       nonce:integer 
       query-data:string  
       staker:string)  
```

Here is a step-by-step explanation:

**2.1. Value Submission:**
In the beginning, the staker is required to submit data to the Tellor oracle. The `submit-value` function takes the `value`, which is the data that the reporter wants to submit in base64 encoded format, and an identifier (`query-id`) that distinguishes this particular data feed.

   ```pact
   (enforce (!= value "") "value must be submitted")
   (enforce (= query-id (hash query-data)) 
     "query id must be hash of query data")
   ```

**2.2. Condition Validation:**
The function also takes in a `nonce` and `staker` (reporter's identifier that was used to stake). The `nonce` must either equal the length of existing timestamps for the `query-id` or be zero. This condition ensures the `nonce` is unique for each report and prevents the reporter from submitting data for the same timestamp twice (rate limiting). For the reporter to be eligible to submit the data, they must have staked enough tokens, and they must not be in a "reporting lock" period - a cooldown period to prevent spamming. 

```pact
    (enforce (or (= nonce (length timestamps-lis)) (= nonce 0))
      "Nonce must match timestamps list length or be zero")
    (enforce (>= staked-balance stake-amount)
       "balance must be greater than stake amount")
    (enforce (>
       (* 1000 (- block-time reporter-last-timestamp))
       (/ (* 1000 reporting-lock) (/ staked-balance stake-amount)))
       "still in reporter time lock, please wait!")
```

**2.3. Data Insertion:**
Once the conditions are satisfied, the function goes ahead and inserts the data into the reports table. The new entry contains various data fields such as the `query-id`, the block's timestamp (which is effectively the reporting time), the reported value, the reporter's `staker` string, and a boolean `is-disputed` field which is set to false initially.

```pact
    (insert reports (concatenate query-id block-time)
       { 'index: (length timestamps-lis)
         'query-id: query-id
         'timestamp: block-time
         'block-height: block-height
         'value: value
         'reporter: staker
         'is-disputed: false 
       })
```

**2.4. Reward Assignment:**
After the report's successful submission, time-based rewards are transferred to the reporting staker. The total reward amount is determined by a separate function (`calculate-time-based-reward`), which is not shown here.

```pact
    (transfers-from-flex (calculate-time-based-reward block-time) staker)
```

**2.5. Updating Global Records:**
The function updates the records for the reporter such as the timestamp of the most recent report and the total number of reports they have submitted. The total count of reports per a `query-id` submitted by the reporter is also updated.

```pact
    (update staker-details staker
      { 'reports-submitted: (plus-one reports-submitted)
      , 'reporter-last-timestamp: block-time})
    (write reports-submitted-count (+ query-id staker)
         {'reports-submitted-by-queryid:
             (plus-one reports-submitted-by-queryid)})
```
   
**2.6. Event Emission:**
Finally, an event `NewReport` is emitted marking the completion of the function call, providing a trail of the submitted report details.

```pact
(emit-event (NewReport query-id block-time value nonce query-data staker))
```

This reporting process ensures the Tellor oracle is continuously updated with data by staked reporters while maintaining security and governance through checks, conditions and dispute mechanisms. 



## 3. Voting And Dispute Resolution Process: 
The process of resolving a dispute in the Tellor system implemented in Pact starts with the commencement of a dispute. 

#### 3.1. Dispute Initiation:

The function `begin-dispute` is used to initiate a dispute for a given `query-id` and `timestamp`. 

```pact
 (defun begin-dispute:bool 
    (account:string query-id:string timestamp:integer)
   )
```

The process starts by retrieving the `block-number` corresponding to the `query-id` and `timestamp` provided. Enforcement ensures that the block number is not zero, indicating that there is indeed a value at the given timestamp. 

Then, the unique hash for the dispute is generated using the `query-id` and `timestamp`. This hash will be used as an identifier for this dispute through the entire resolution process.

Next, the function checks if there are any open disputes for the `query-id` and `timestamp` in question. 

If none exist, meaning this report hasn't been disputed before, a new dispute is initiated. However, it is necessary to ensure that the dispute is started within a predefined lock time after the report was submitted, this is set to 12 hours (TWELVE_HOURS) in the current contract. 

After this, a dispute fee is calculated based on the number of open disputes on the `query-id`. The dispute fee is transferred from the account of the user that initiated the dispute to the governance account. 

```pact
 (f-TRB.transfer account (gov-account) (to-decimal fee))
```

The disputed value is then removed using the function `tellorflex.remove-value`, and all related information about the dispute is stored in the `dispute-info` table, including the `query-id`, `timestamp`, value, reporter that is disputed and the slashed amount. 

If there are existing disputes for the report, a new dispute round is initiated. In this case, it is ensured that the new round is started within one day (ONE_DAY) after the tallying of votes for the previous round. 

The dispute fee, as previously, is calculated based on the existing number of dispute rounds and transferred to the governance account. In both scenarios, a new vote round is created and inserted into the `vote-info` table.

At the end of the dispute initiation process, the dispute ID of the current dispute is added to the list of disputes for the `query-id` and `timestamp`. In addition, the dispute ID is also added to the list of disputes for the disputed reporter. The global vote count is incremented by one.

Finally, the `NewDispute` event is triggered, notifying all stakeholders about the initiation of a new dispute. 

These initiation processes ensure fairness and transparency in the Tellor system while maintaining a rigorous timeline to guard against misuse. The calculated fees for initiating the dispute and the automatically managed governance switch also ensure that the system is self-sustaining and secure against tampering.



#### 3.2. Voting

One of the fundamental components of this implementation of the Tellor oracle system is the voting process. This process, intertwined with the dispute resolution mechanism, attempts to ensure the accuracy of submitted data. Especially in cases where data submitted by staked entities is disputed, the votes cast by various stakeholders may determine the validity of reported data. 

The 'vote' and 'tally-votes' functions in the implementation code embody this voting process. Let's delve further and shed light on how they operate within the Tellor oracle system in the context of Pact.

```pact
(defun vote:bool
  (dispute-id:integer supports:bool invalid:bool voter-account:string) ... )
```

**3.2.1 Voting Process**

The 'vote' function provides the mechanism for participating stakeholders to cast their votes on an ongoing dispute. The block of code handles the voting process in three possible scenarios—when the vote 'supports' the data, when it is 'against' the data, and when the reported data is deemed 'invalid.' 

To ensure security, the code uses a guard in the form of an enforce-guard function which verifies that only the actual holder of the account associated with the vote has the authority to vote. Before any vote happens, this function checks whether the dispute exists, has not been tallied (thus still ongoing), and the stakeholder has not already voted, ensuring the uniqueness of the vote from each account.

What's particularly interesting is the incorporation of the 'PRIVATE' capability. This checks an internal operation and is specifically used within the 'vote' function for updating the status and details of the vote in the database.

If a voter has voted 'invalid,' the code adds the stakeholder's balance and the number of reports they submitted to the dispute's 'invalid' tally. Similar updates happen when the stakeholder votes 'for' or 'against,' adding their associated weights to the respective tallies. 

Once the vote is processed, the function returns an event of successful voting using the 'emit-event' function.


**3.2.2. Vote Tallying Process**

```pact
(defun tally-votes:bool (dispute-id:integer) ... )
```

The 'tally-votes' function is integral to determining the result of a dispute. It uses a stake-weighted mechanism to tally the votes, calculating the overall standing of 'for,' 'against,' and 'invalid' votes for a specific dispute.

The function first enforces that the current dispute is still ongoing and that the voting round has elapsed. It then computes the totals of 'for,' 'against,' and 'invalid' votes, weighing them by the respective voter's stake and the number of reports they submitted.

Once the totals for all types of votes are calculated and scaled distributed over different stakeholders (token holders, reporters, and multisig), the function moves to determine the result of the dispute as 'PASSED,' 'FAILED,' or 'INVALID.' This is done based on which tally is the highest—'for' denoting 'PASSED,' 'against' meaning 'FAILED,' and 'invalid-query' resulting in 'INVALID.'

Following vote tallying, the code updates the result and tally date in the database and emits an event signaling the successful tallying of votes. 

#### 3.3. Executing Votes

In the Tellor system built on Pact, the act of vote execution finalizes the voting process for a particular dispute and triggers the appropriate transfer of stakes and fees based on the result. This functionality is encompassed in the `execute-vote` function. 

The `execute-vote` function takes one parameter, the dispute ID, and it performs several important steps to execute a vote:

```pact
(defun execute-vote:bool (dispute-id:integer)
```

**3.3.1. Ensuring Validity**

The function first checks the validity of the entered dispute id by ensuring that it is within the existing range of dispute ids.
```pact
(let ((vote-count (at "vote-count" (read global "global-vars"))))
  (enforce (and (<= dispute-id vote-count) (> dispute-id 0))
    "Dispute ID must be valid"))
```

It then checks that the vote has not yet been executed and that the vote has been tallied. Additionally, it ensures that one day has passed since the vote was tallied to allow time for any further disputes.
```pact
(enforce (not executed) "Vote has already been executed")
(enforce (> tally-date 0) "Vote must be tallied")
(enforce (>= (- (block-time) tally-date) ONE_DAY)
  "1 day has to pass after tally to allow for disputes")
```

**3.3.2. Transferring Stakes and Fees**

After these conditions are met, the function will initiate stake and fee transfers based on the result of the vote. If the vote was passed, or failed, or was deemed invalid, it handles the situations differently.

```pact
(with-capability (PRIVATE)
...
(if (= result "PASSED") 
...
(if (= result "INVALID")
...
(if (= result "FAILED")
...
```

- In case the vote result is "PASSED", the function `vote-passed` is called.
- In case the vote result is "INVALID", the function `vote-invalid` is called, and the slashed amount is transferred back to the disputed reporter.
- If the vote result is "FAILED", the function `vote-failed` is called. The disputed reporter then receives the slashed amount and the total fees.

**3.3.3. Update Dispute Count**

The function then updates the count of open disputes on the provided query ID. Every time a vote is executed, the contract decrements the count for open disputes on that query ID.

```pact
(update open-disputes-on-id query-id { "open-disputes-on-id": (- (open-disputes-count query-id) 1)}) )
```

**3.3.4. Emitting the VoteExecuted Event**

The function concludes by emitting a `VoteExecuted` event with the dispute ID and the vote result.

```pact
(emit-event (VoteExecuted dispute-id result))
```

This breakdown illustrates the vote executing process in the Tellor system built with Pact, maintaining the contract's security and integrity by following strict rules and conditions. 
