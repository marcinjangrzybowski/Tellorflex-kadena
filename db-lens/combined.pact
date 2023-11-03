
==> autopay.pact <==
; ***************************TABLE-SCHEMA**************************************
  (defschema global-schema
    autopay-account:string
    fee:integer
    query-ids-with-funding:[string]
  )
  (defschema tips-schema
    tips:[object{TIP}]
  )
  (defschema query-ids-with-funding-index-schema
    index:integer
  )
  (defschema user-tips-total-schema
    total:integer
  )
; ***************************OBJECT-SCHEMA*************************************
  (defschema TIP
    amount:integer
    cumulative-tips:integer
    timestamp:integer
  )
; ***************************TABLE-DEFINITION**********************************
  (deftable global:{global-schema})
  (deftable tips:{tips-schema})
  (deftable query-ids-with-funding-index:{query-ids-with-funding-index-schema})
  (deftable user-tips-total:{user-tips-total-schema})
; ***************************MAIN-FUNCTIONS************************************
  (defun constructor ()
      (insert global "global" ...)
      ...
  )
  (defun claim-one-time-tip ()
      (read tips ...)
      (read global ...)
      (read query-ids-with-funding-index ...)
      (read query-ids-with-funding-index ...)
      (read global ...)

       (update global ... ...)
       (update query-ids-with-funding-index ... ...)
       (update query-ids-with-funding-index ... ...)
                      
  )
  (defun tip ()
    ...
    (with-default-read tips ... ... ...
        (write tips ... ...)
              
        (update tips ... ... )
        (update tips ... ... )
                  
        )
    (with-default-read query-ids-with-funding-index ... ... ...
            (update global ... ...)
            (write query-ids-with-funding-index ... ...)
                
        )
        (with-default-read user-tips-total ... ...
            (write user-tips-total ... ...)
     )
    
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun calc-total-rewards ()
  ...)
  (defun search ()
    ...
  )
  (defun get-one-time-tip-amount ()    
    (read tips ...)
    (update tips ... ...)
  )
; ***************************GETTERS*******************************************
  (defun autopay-account:string ()
    (read global ...)
  )
  (defun blockTime:integer ()
    ...
  )
  (defun fee:integer ()
    (read global ...)
  )
  (defun get-current-tip:integer ()
    (with-default-read tips ... ... ...
      ...
    )
  )
  (defun get-funded-query-ids:list ()
    (read global ...)
  )
  (defun get-past-tip-count () 
    ...
  )
  (defun get-past-tips ()
     (read tips ...)
  )
  (defun get-past-tip-by-index ()
    (read tips ...)
  )
  (defun get-query-ids-with-funding-index:integer ()
    (read query-ids-with-funding-index ...)
  )
  (defun get-tips-by-user ()
      (read user-tips-total ...)
  )
  (defun to-decimal:decimal ()
    ...
  )
)
(if (read-msg "upgrade")
    ["upgrade"]
    [
      (create-table global)
      (create-table tips)
      (create-table query-ids-with-funding-index)
      (create-table user-tips-total)
      ...
    ]
)

==> f-TRB.pact <==

    ; Schemas and Tables
  
    (defschema coin-schema
      @doc "The coin contract token schema"
      @model [ (invariant (>= balance 0.0)) ]
  
      balance:decimal
      guard:guard)
  
    (deftable coin-table:{coin-schema})
  
  
    (defun enforce-unit:bool ()
       ...)
  
    (defun validate-account ()
      ...)
  
    ; --------------------------------------------------------------------------
    ; Coin Contract
  
    (defun create-account:string ()
      (insert coin-table ... ...)
      )
  
    (defun get-balance:decimal ()
      (with-read coin-table ... ...
                 ...
        )
      )
  
    (defun details:object{fungible-v2.account-details} ()
      (with-read coin-table ... ... ...)
      )
  
    (defun rotate:string ()      
        (with-read coin-table ... ...  
          (update coin-table ... ...))
      )
  
  
    (defun precision:integer () ...)
  
    (defun transfer:string ()
      (with-read coin-table ... ...
                 ...)
     )
  
    (defun transfer-create:string ()
     ... )
  
    (defun mint:string ()  
      ...)
  
    (defun debit:string ()
      (with-read coin-table ... ...
        (update coin-table ... ... )
      )
    )
  
  
    (defun credit:string ()  
      (with-default-read coin-table ... ... ...
        ...
          (write coin-table ... ...)
        )
     )
  
    (defun check-reserved:string ()
       ...)
  
    (defun enforce-reserved:bool ()
      ...)


    (defschema crosschain-schema
      @doc "Schema for yielded value in cross-chain transfers"
      receiver:string
      receiver-guard:guard
      amount:decimal
      source-chain:string)

    (defpact transfer-crosschain:string ()
       ...
    )
  )
  (if (read-msg "upgrade")
  ["upgrade"]
  [
    (create-table coin-table)
    ...
  ])

==> governance.pact <==

; ***************************SCHEMA********************************************
  (defschema dispute-ids-by-reporter-schema
    dispute-ids:[integer])
  (defschema dispute-schema
    query-id:string
    timestamp:integer
    value:string
    disputed-reporter:string
    slashed-amount:integer)
  (defschema global-schema
    team-multisig:string
    gov-account-name:string
    vote-count:integer)
  (defschema open-disputes-on-id-schema
    open-disputes-on-id:integer)
  (defschema results-schema
    does-support:integer
    against:integer
    invalid-query:integer)
  (defschema vote-rounds-schema
    dispute-ids:[integer])
  (defschema vote-schema
    identifier-hash:string
    vote-round:integer
    start-date:integer
    block-number:integer
    fee:integer
    tally-date:integer
    token-holders:object{results-schema}
    users:object{results-schema}
    reporters:object{results-schema}
    team-multisig:object{results-schema}
    executed:bool
    result:string
    initiator:string
    voters:[string])
  (defschema vote-tally-by-address-schema
    vote-tally-by-address:integer)
; ***************************TABLES********************************************
  (deftable dispute-ids-by-reporter:{dispute-ids-by-reporter-schema})
  (deftable dispute-info:{dispute-schema})
  (deftable global:{global-schema})
  (deftable open-disputes-on-id:{open-disputes-on-id-schema})
  (deftable vote-info:{vote-schema})
  (deftable vote-rounds:{vote-rounds-schema})
  (deftable vote-tally-by-address:{vote-tally-by-address-schema})
; ***************************MAIN-FUNCTIONS************************************
  (defun constructor:string ()
    (insert global ... ...)
    ...
  )

  (defun register-gov-guard:string ())

  (defun begin-dispute:bool ()      
      (with-default-read vote-rounds ... ... ...
        (with-default-read open-disputes-on-id ... ... ...
                                    
                 (insert dispute-info ... ...)
                 (write open-disputes-on-id ... ...)
                                  
                  (with-read dispute-info ... ...
                    (insert dispute-info ... ...))                
            )
            (write vote-rounds ... ...)
            (with-default-read dispute-ids-by-reporter ... ...
              (write dispute-ids-by-reporter ... ...))
            (with-read global ... ...
              (update global ... ...))
        )
      
      
    
  )

  (defun execute-vote:bool ()
         (read global "global-vars")
    (with-read vote-info ... ...
      
      (with-read vote-rounds ... ...
        (update vote-info ... ...)
          (with-read dispute-info ... ...
            ...
            (update open-disputes-on-id ... ...) ) )
      )
    
  )

  (defun tally-votes:bool ()
    (with-read vote-info ... ...

      (read global "global-vars")
              (update vote-info ... ...))    
  )

  (defun vote:bool ()
    (with-read vote-info ... ...


      (read global "global-vars")
      (update vote-info ... ...)

      (read global "global-vars")
      (update vote-info ... ... )
       (update vote-info ... ...)
      (update vote-info ... ...)
      (update vote-info ... ...)
      (update vote-info ... ...)
      (update vote-info ... ...)         
      (write vote-tally-by-address ... ...)
      
      
    )
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun transfer-from-gov ()
    ...
  )

  (defun vote-passed ()
      (with-read vote-info ... ...
        (read dispute-info (str vote-id)))
  )

  (defun vote-invalid ()
     (read vote-rounds hash)
      (with-read vote-info ... ...)
  )

  (defun vote-failed ()
    (with-read vote-info ... ... ...)
  )

  (defun calculate-vote-to-scale ()
    ...
  )

  (defun insert-vote-info ()     
      (insert vote-info ... ...)
  )

  (defun replace-key-value:object{results-schema} ()
  )
; ***************************GETTERS*******************************************
  (defun did-vote:bool (dispute-id:integer voter:string)
      (read vote-info ...)
  )

  (defun get-dispute-fee:integer ()
  )

  (defun get-disputes-by-reporter:[integer] ()
     (read dispute-ids-by-reporter ...)
  )

  (defun get-dispute-info:object{dispute-schema} ()
    (read dispute-info ...)
  )

  (defun get-open-disputes-on-id:integer ()
    (read open-disputes-on-id ...)
  )

  (defun get-vote-count:integer ()
   (read global ...)
  )

  (defun get-vote-info:object{vote-schema} ()
    (read vote-info ...)
  )

  (defun get-vote-rounds:[integer] ()
    (read vote-rounds ...)
  )

  (defun get-vote-tally-by-address:integer ()
    (read vote-tally-by-address ...)
  )

  (defun get-user-tips:integer ()
    ...
  )

  (defun gov-account:string ()
    (read global ...)
  )

  (defun open-disputes-count:integer ()
    (read open-disputes-on-id ...)
  )

  (defun vote-count:integer ()
    (read global ...)
  )
; ***************************HELPERS*******************************************
  (defun str () ... )

  (defun to-decimal:decimal () ... )

  (defun block-time () ...
  )
)
; ***************************INITIALIZE****************************************
(if (read-msg "upgrade")
    ["upgrade"]
    [
      (create-table dispute-info)
      (create-table vote-info)
      (create-table vote-rounds)
      (create-table open-disputes-on-id)
      (create-table global)
      (create-table dispute-ids-by-reporter)
      (create-table vote-tally-by-address)
      ...
    ])

==> i-governance.pact <==
(namespace (read-msg "ns"))
(interface i-governance

  (defun get-vote-count:integer ()
  )
  (defun get-vote-tally-by-address:integer (voter:string)
  )
  (defun register-gov-guard:string () )

  )

==> query-data-storage.pact <==

; ***************************Table-Schema**************************************
  (defschema storage-schema
      query-data:string
    )
; ***************************Define table**************************************
  (deftable storage:{storage-schema})
; ***************************Setter********************************************
  (defun store-data:string ()
    (write storage ... ...)
  )
; ***************************Getter********************************************
  (defun get-query-data:string ()
      (read storage ...)
    )
)
(if (read-msg "upgrade")
    ...
    (create-table storage)
  )

==> tellorflex.pact <==

(module tellorflex NOT-UPGRADEABLE

; ***************************TABLE-SCHEMA**************************************
  (defschema constructor-schema
    "Global variables schema that must be initialized before contract can be used"
    tellorflex-account:string  ;account name for oracle contract token account
    accumulated-reward-per-share:integer  ;accumulated staking reward per staked token
    minimum-stake-amount:integer  ;minimum amount of tokens required to stake
    reporting-lock:integer  ;base amount of time before a reporter is able to submit a value again
    stake-amount:integer  ;minimum amount required to be a staker
    stake-amount-dollar-target:integer  ;amount of US dollars required to be a staker
    reward-rate:integer  ;total staking rewards released per second
    staking-rewards-balance:integer  ;total amount of staking rewards
    staking-token-price-query-id:string  ;staking token SpotPrice queryId, used for updating stakeAmount
    time-of-last-allocation:integer  ;time of last update to accumulated-reward-per-share
    time-of-last-new-value:integer  ;time of the last new submitted value, originally set to the block timestamp
    total-reward-debt:integer  ;staking reward debt, used to calculate real staking rewards balance
    total-stake-amount:integer  ;total amount of tokens locked in contract (via stake)
    total-stakers:integer  ;total number of stakers with at least stakeAmount staked, not exact
    to-withdraw:integer)  ;total amount locked for withdrawal
  (defschema report
    "Submission reports' schema" ; Report struct in solidity contract
    index:integer  ;index for reports location in list of reports
    query-id:string  ;report identifier
    timestamp:integer  ;timestamp of when report was submitted
    block-height:integer  ;block where report was added
    value:string  ;submission's reported value
    reporter:string  ;reporter's identifier that submitted report
    is-disputed:bool)  ;report's dispute status 
  (defschema stake-info
    "Reporter's stake info schema"
    start-date:integer  ;date staker staked token's in contract
    staked-balance:integer  ;staker's token balance currently staked and used to report
    locked-balance:integer  ;staker's token balance currently locked for withdrawal not used to report
    reward-debt:integer  ;tracks rewards to be paid out per staker, used for calculating staking reward
    reporter-last-timestamp:integer  ;staker's last reported timestamp
    reports-submitted:integer  ;staker's count of reports submitted
    start-vote-count:integer  ;total number of governance votes
    start-vote-tally:integer  ;staker vote tally 
    is-staked:bool  ;staker's status
    guard:guard)  ;staker's keyset guard, used to enforce staker
  (defschema reports-submitted-by-queryid
    "Reports per query id schema"
    reports-submitted-by-queryid:integer)  ;count of reports per query id
  (defschema timestamps-schema
    "Reports' timestamps schema"
    timestamps:[object{timestamp-dispute-object}])  ;list of key-value of timestamp and dispute status
  (defschema governance-schema
    "Governance interface schema"
    governance:module{i-governance})
  (defschema gov-guard-schema
    "Governance guard schema"
    guard:guard)
; ***************************OBJECT-SCHEMA*************************************
  (defschema timestamp-dispute-object
    timestamp:integer  ;report's timestamp
    disputed:bool)  ;dispute status
  (defschema binary-search-object
    "Used for finding an undisputed report"
    found:bool
    target:integer
    start:integer
    end:integer
    timestamp-before:integer
    reports:[object{timestamp-dispute-object}]
    disputed:bool)
  (defschema data-before-value
    "Undisputed report's timestamp and value"
    timestamp:integer
    value:string)
; ***************************TABLES********************************************
  (deftable staker-details:{stake-info})
  (deftable reports-submitted-count:{reports-submitted-by-queryid})
  (deftable reports:{report})
  (deftable timestamps:{timestamps-schema})
  (deftable global-variables:{constructor-schema})
  (deftable governance-table:{governance-schema})
  (deftable gov-guard:{gov-guard-schema}) 
; ***************************GUARDS********************************************
  (defun tellorflex-account:string ()
    "Getter of Tellorflex account identifier in token contract"
    (at "tellorflex-account" (read global-variables "global-vars"))
  )
  (defun get-governance-module:module{i-governance} ()
    "Getter of Governance module"
    (at "governance" (read governance-table "governance"))
  )
  (defun accumulated-reward-per-share ()
    "Getter of accumulated reward in contract"
    (at "accumulated-reward-per-share" (read global-variables "global-vars"))
  )
  (defun minimum-stake-amount:decimal ()
    "Getter of minimum stake amount required to stake"
    (at "minimum-stake-amount" (read global-variables "global-vars"))
  )
  (defun reporting-lock:integer ()
    "Getter of seconds required to wait between reports per stake"
    (at "reporting-lock" (read global-variables "global-vars"))
  )
  (defun reward-rate:integer ()
    "Getter of reward amount per second"
    (at "reward-rate" (read global-variables "global-vars"))
  )
  (defun stake-amount:integer ()
    "Getter of minimum amount required to be a staker"
    (at "stake-amount" (read global-variables "global-vars"))
  )
  (defun stake-amount-dollar-target:integer ()
    "Getter of minimum amount required to be a staker in US dollars"
    (at "stake-amount-dollar-target" (read global-variables "global-vars"))
  )
  (defun staking-rewards-balance:integer ()
    "Getter of total amount of staking rewards in contract"
    (at "staking-rewards-balance" (read global-variables "global-vars"))
  )
  (defun staking-token-price-query-id:string ()
    "Getter of staking token's query id (TRB)"
    (at "staking-token-price-query-id" (read global-variables "global-vars"))
  )
  (defun time-based-reward:integer ()
    ...
  )
  (defun time-of-last-allocation:integer ()
    "Getter of when rewards were last calculated/allocated"
    (at "time-of-last-allocation" (read global-variables "global-vars"))
  )
  (defun time-of-last-new-value:integer ()
    "Getter of when a report was last submitted to oracle"
    (at "time-of-last-new-value" (read global-variables "global-vars"))
  )
  (defun total-reward-debt:integer ()
    "Getter of total reward debt, thats used when calculating staking rewards"
    (at "total-reward-debt" (read global-variables "global-vars"))
  )
  (defun total-stake-amount:integer ()
    "Getter of the total stake amount locked in contract"
    (at "total-stake-amount" (read global-variables "global-vars"))
  )
  (defun total-stakers:integer ()
    "Getter of number of stakers"
    (at "total-stakers" (read global-variables "global-vars"))
  )
  (defun to-withdraw:integer ()
    "Getter of amount of tokens locked in contract"
    (at "to-withdraw" (read global-variables "global-vars"))
  )
; ***************************MAIN-FUNCTIONS************************************
  (defun constructor:string ()
  
      ...
        (insert global-variables 'global-vars
          ...
        )
        ...
      
  )
  (defun init-gov-guard:string ()
    ...
    (insert gov-guard 'gov-guard ...)
  )
  (defun init ()
    ...
     (insert governance-table 'governance ...)
      
  )
  (defun add-staking-rewards ()
    
     (with-read global-variables 'global-vars ...
        (update global-variables 'global-vars ...))
      (update global-variables 'global-vars ...)
    
  )
  (defun add-staker ()
    (with-default-read staker-details staker
      ...
      
      (write staker-details staker
        ...))
  )
  (defun deposit-stake ()
       (with-read staker-details staker ...
         ( ...
                  (update staker-details staker ...)
                  (update global-variables 'global-vars ...)
              ) ( (update staker-details staker ...)
                  (update global-variables 'global-vars ...)
              )
          )
          (update staker-details staker ... )   
  )
  (defun remove-value:string ()
          (update reports ... ...)
          (with-read timestamps query-id ...
            (update timestamps query-id ... )
          )
  )
  (defun request-staking-withdraw ()
           (with-read staker-details ... ...
             (update staker-details ... ...)
             )
           (update global-variables ... ...)        
  )
  (defun slash-reporter:integer ()
      (with-read staker-details ... ...
                (update staker-details ... ...)
                (update global-variables ... ...)
                ...                        
                  (update staker-details ... ...)
                  (update global-variables ... ...)

                )
                  (update global-variables ... ...)
                  (update staker-details .. ...)

  )
  (defun submit-value ()
          (with-default-read timestamps ...
            ...
            ...
            
           (with-read staker-details ... ...
             (insert reports ... ...)
             (write timestamps ... ...)
            

            (update global-variables ... ...)
            (update staker-details ... ...)
            (with-default-read reports-submitted-count ... ... ...
              (write reports-submitted-count ... ...)
            )
          )
        )
  )
  (defun update-stake-amount ()            
              (update global-variables ... ...)
              (update global-variables ... ...)
  )
  (defun withdraw-stake ()    
      (with-read staker-details ... ...
        (update staker-details ... ... )
        (update global-variables ... ...)
      )     
  )

; ***************************GETTERS*******************************************
  (defun get-block-number-by-timestamp:integer ()
    (read reports ...)
  )
  (defun get-current-value ()
    ...
  )
  (defun get-data-before:object{data-before-value} ()    
      (read timestamps query-id ...)
      ...    
  )
  (defun get-new-value-count-by-query-id:integer ()
    (read timestamps query-id ...)
  )
  (defun get-pending-reward-by-staker:integer ()
       (with-read staker-details ... ... ...)
  )
  (defun get-real-staking-rewards-balance:integer ()
     (with-read global-variables 'global-vars ...)
  )
  (defun get-report-details ()
    (with-read reports (concatenate query-id timestamp) ... ...)
  )
  (defun get-reporter-by-timestamp:string ()
    (read reports (concatenate query-id timestamp))
  )
  (defun get-reporter-last-timestamp ()
    (read staker-details reporter)
  )
  (defun get-reports-submitted-by-address:integer ()
    (read staker-details reporter)
  )
  (defun get-reports-submitted-by-address-and-queryId:integer
    (read reports-submitted-count ...)
  )
  (defun get-staker-info:object ()
    (read staker-details reporter)
  )
  (defun get-timestampby-query-id-and-index:integer ()
    (read timestamps query-id)
  )
  (defun get-timestamp-index-by-timestamp:integer ()
    (read reports (concatenate query-id timestamp))
  )
  (defun get-total-time-based-rewards-balance:integer ()
    (with-read global-variables ... ...
      ...  )
  )
  (defun is-in-dispute:bool ()
    (read reports (concatenate query-id timestamp))
  )
  (defun retrieve-data:string ()
   (read reports (concatenate query-id timestamp))
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun transfers-from-flex ()
    ...
  )
  (defun transfers-to-flex ()
    ...
  )
  (defun update-rewards ()
    (with-read global-variables ... ...
      (...
         (update global-variables ... ... )
         ...
         (update global-variables ... ...)
         (update global-variables ... ...))
      )
      (update global-variables ... ...)    
  )
  (defun update-stake-and-pay-rewards ()
    (with-read staker-details ... ...
      ( with-read global-variables ... ...
                    (update global-variables ... ...))
                      (update global-variables ... ...)
              (update global-variables ... ...)
            
    )
    (update staker-details ... ...)
    (with-read staker-details ... ...
      

              (update global-variables 'global-vars { 'total-stakers: stakers-total })
              (update staker-details staker { 'is-staked: true })
            
              (update global-variables 'global-vars { "total-stakers": stakers-total })
             
            (update staker-details staker {'is-staked: false })
     )
      
      (update staker-details ... ...)
    
    (with-read staker-details ... ...
      (update global-variables ... ...)
    )
  )
  (defun get-updated-accumulated-reward-per-share:integer ()
    (with-read global-variables ... ...
    ...)
  )
; ***************************HELPER-FUNCTIONS**********************************
  (defun accumulated-reward:integer
    ...
  )
  (defun block-time-in-seconds:integer ()
    ...
  )
  (defun calculate-time-based-reward:integer ()
    ...
    (with-read global-variables ... ...

      ...
      
    )
  )
  (defun calculate-reward-rate:integer ()
    (with-read global-variables ... ...
      ...)
  )
  (defun concatenate ()
     ...
  )
  (defun plus-one:integer ()
     ...
  )
  (defun precision:integer ()
    ...
  )
  (defun to-decimal:decimal ()
    ...
  )
  (defun new-accumulated-reward-per-share:integer ()
    (with-read global-variables ... ...
        ...
    )
  )
  (defun pending-new-accumulated-reward-per-share:integer ()
    ...
  )
  (defun search-if-disputed:object{binary-search-object} ()
    ...
  )
  (defun binary-search:object{binary-search-object} ()
    ...
  )
)
; **************************INITIALIZE*****************************************
(if (read-msg "upgrade")
    ["upgrade"]
    [
      (create-table global-variables)
      (create-table governance-table)
      (create-table gov-guard)
      (create-table reports)
      (create-table reports-submitted-count)
      (create-table staker-details)
      (create-table timestamps)
      ...
    ]    
)
