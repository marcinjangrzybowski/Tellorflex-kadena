
==> autopay.pact <==
; ***************************CAPABILITIES**************************************
  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))
  (defcap PRIVATE ()
    true
  )
; ***************************MAIN-FUNCTIONS************************************
  (defun constructor (autopay-account:string fee:integer)
      ...
  )
  (defun claim-one-time-tip ()
      
        (with-capability (PRIVATE)
          
             
              (install-capability (f-TRB.TRANSFER "autopay" claimant (to-decimal pay-amount)))
              ...
              (install-capability (f-TRB.TRANSFER "autopay" "tellorflex" (to-decimal fee-total)))
              ...
            
          
        )
      
  )
  (defun tip ()
     ...
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun calc-total-rewards (reward-details idx)
    @doc "Calculate total tips payout"
    (require-capability (PRIVATE))
    ...
  )
  (defun search (tips-details _)
    @doc "Binary search tips list"
    (require-capability (PRIVATE))
    ..
  )
  (defun get-one-time-tip-amount ()
    (require-capability (PRIVATE))
  )
; ***************************GETTERS*******************************************
; getters are not using capabilities

==> f-TRB.pact <==

(module f-TRB GOVERNANCE


    (defcap GOVERNANCE ()
      (enforce-guard 
        (keyset-ref-guard (+ (read-msg "ns") ".admin-keyset"))))
  
    (defcap DEBIT (sender:string)
      "Capability for managing debiting operations"
      (enforce-guard (at 'guard (read coin-table sender)))
      (enforce (!= sender "") "valid sender"))
  
    (defcap CREDIT (receiver:string)
      "Capability for managing crediting operations"
      (enforce (!= receiver "") "valid receiver"))
  
    (defcap ROTATE (account:string)
      @doc "Autonomously managed capability for guard rotation"
      @managed
      true)
  
    (defcap TRANSFER:bool
      ( sender:string
        receiver:string
        amount:decimal
      )
      @managed amount TRANSFER-mgr
      (enforce (!= sender receiver) "same sender and receiver")
      (enforce-unit amount)
      (enforce (> amount 0.0) "Positive amount")
      (compose-capability (DEBIT sender))
      (compose-capability (CREDIT receiver))
    )
  
    (defun TRANSFER-mgr:decimal
      ( managed:decimal
        requested:decimal
      )
  
      (let ((newbal (- managed requested)))
        (enforce (>= newbal 0.0)
          (format "TRANSFER exceeded for balance {}" [managed]))
        newbal)
    )

    (defcap TRANSFER_XCHAIN:bool
      ( sender:string
        receiver:string
        amount:decimal
        target-chain:string
      )
  
      @managed amount TRANSFER_XCHAIN-mgr
      (enforce-unit amount)
      (enforce (> amount 0.0) "Cross-chain transfers require a positive amount")
      (compose-capability (DEBIT sender))
    )
    
    (defun TRANSFER_XCHAIN-mgr:decimal
      ( managed:decimal
        requested:decimal
      )
  
      (enforce (>= managed requested)
        (format "TRANSFER_XCHAIN exceeded for balance {}" [managed]))
      0.0
    )
  
    (defun TRANSFER-mgr:decimal ()
        ..
    )

    (defcap TRANSFER_XCHAIN:bool ()
       ...
      (compose-capability (DEBIT sender))
    )
    
    (defun TRANSFER_XCHAIN-mgr:decimal ()
       ...
    )

     
    (defun enforce-unit:bool (amount:decimal)
       ...
      )
  
    (defun validate-account (account:string)
  
    ...
      
    )
  
    ; --------------------------------------------------------------------------
    ; Coin Contract
  
    (defun create-account:string (account:string guard:guard)
      ...
      )
  
    (defun get-balance:decimal (account:string)
      ...
      )
  
    (defun details:object{fungible-v2.account-details}
      ( account:string )
      
      )
  
    (defun rotate:string (account:string new-guard:guard)
      (with-capability (ROTATE account)
        ...)
      )
  
  
    (defun precision:integer
      ()
      MINIMUM_PRECISION)
  
    (defun transfer:string (sender:string receiver:string amount:decimal)
      ...
      (with-capability (TRANSFER sender receiver amount)
        ...
        )
      )
  
    (defun transfer-create:string
      ()
  
      ..
  
      (with-capability (TRANSFER sender receiver amount)
        ...)
      )
  
    (defun mint:string ()  
      (with-capability (GOVERNANCE)
        ...
        (with-capability (CREDIT account)
          ...)
        )
      )
  
    (defun debit:string (account:string amount:decimal)
      ...
      (require-capability (DEBIT account))
      ...
      )
  
  
    (defun credit:string (account:string guard:guard amount:decimal)
      
  
       ...
      (require-capability (CREDIT account))
      ...)
  
    (defun check-reserved:string (account:string)
      ...)
  
    (defun enforce-reserved:bool (account:string guard:guard)
      ...)



    (defpact transfer-crosschain:string ()
  
      (step
        (with-capability
          (TRANSFER_XCHAIN sender receiver amount target-chain)
           ...)
  
      (step
        (resume
          ...
  

          (with-capability (CREDIT receiver)
            ...)
          ))
      )
  )

==> governance.pact <==
; ***************************CAPABILITIES**************************************
  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))
  (defcap TELLOR:bool ()
    (enforce-guard 
      (keyset-ref-guard (+ (read-msg "ns") ".admin-keyset")))
  )
  (defcap PRIVATE:bool () 
    true
  )
; ***************************MAIN-FUNCTIONS************************************
  (defun constructor:string ()
    ...
  )

  (defun register-gov-guard:string ()
      (with-capability (TELLOR)
        ...
      )
  )

  (defun begin-dispute:bool ()
    
      ...
      ( ... 
          (with-capability (PRIVATE)
           ...
            )
        
      )
      ...
    
  )

  (defun execute-vote:bool ()
    ...

        (with-capability (PRIVATE)
         ... )
      )
      ...
    )
  )

  (defun tally-votes:bool (dispute-id:integer)
    ( ...

      (with-capability (PRIVATE)
        ...
      )
    )
  )

  (defun vote:bool ()
    ...
        (with-capability (PRIVATE) ... )
        ...
      )
      )
    )
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun transfer-from-gov (account:string amount:decimal)
    (require-capability (PRIVATE))
    (install-capability
      (f-TRB.TRANSFER (gov-account) account amount))
      (f-TRB.transfer (gov-account) account amount)
  )

  (defun vote-passed (hash:string idx:integer)
    @doc "Internal helper function to transfer fee and \
    \ stake to initiator and fee only to other disputers"
    (require-capability (PRIVATE))
    ...
  )

  (defun vote-invalid (hash:string idx:integer)
    @doc "Internal helper function to transfer fee \
    \ to each dispute round initiator"
    (require-capability (PRIVATE))
    ...

  )

  (defun vote-failed (num:integer dispute-id:integer)
    @doc "Sum the fee of each round"
    (require-capability (PRIVATE))
    ...
  )

  (defun calculate-vote-to-scale (votes vote-sum)
    (require-capability (PRIVATE))
    ...
  )

  (defun insert-vote-info ()
    (require-capability (PRIVATE))
    ...
  )

  (defun replace-key-value:object{results-schema} ()
    (require-capability (PRIVATE))
    ...
  )
; ***************************GETTERS*******************************************
  (defun did-vote:bool (dispute-id:integer voter:string)
     ...
  )

  (defun get-dispute-fee:integer ()
     ...
  )

  (defun get-disputes-by-reporter:[integer] (reporter:string)
    ...
  )

  (defun get-dispute-info:object{dispute-schema} (dispute-id:integer)
    ...
  )

  (defun get-open-disputes-on-id:integer (query-id:string)
    ...
  )

  (defun get-vote-count:integer ()
    ...
  )

  (defun get-vote-info:object{vote-schema} (dispute-id:integer)
    ...
  )

  (defun get-vote-rounds:[integer] (hash:string)
    ...
  )

  (defun get-vote-tally-by-address:integer (voter:string)
    ...
  )

  (defun get-user-tips:integer (user:string)
    (require-capability (PRIVATE))
    ...
  )

  (defun gov-account:string ()
    ...
  )

  (defun open-disputes-count:integer (query-id:string)
     ...
  )

  (defun vote-count:integer ()
    ...
  )
; ***************************HELPERS*******************************************
; helpers do not use capabillities 
; ***************************INITIALIZE****************************************

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
(namespace (read-msg "ns"))

(module queryDataStorage NOT-UPGRADEABLE
  @doc
  "Storage of query data for mapping query id to corresponding query data"

  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))

; ***************************Table-Schema**************************************
  (defschema storage-schema
      query-data:string
    )
; ***************************Define table**************************************
  (deftable storage:{storage-schema})
; ***************************Setter********************************************
  (defun store-data:string (query-data:string)
    (write storage (hash query-data) { "query-data": query-data })
  )
; ***************************Getter********************************************
  (defun get-query-data:string (query-id:string)
      (at 'query-data (read storage query-id))
    )
)
(if (read-msg "upgrade")
    "upgrade"
    (create-table storage)
  )

==> tellorflex.pact <==
; ***************************CAPABILITIES**************************************
  (defcap NOT-UPGRADEABLE () (enforce false "Enforce non-upgradeability"))
  (defcap TELLOR ()
    "Capability to enforce admin only operations"
    (enforce-guard (keyset-ref-guard (+ (read-msg "ns") ".admin-keyset"))))
  (defcap PRIVATE () 
    "Capability for internal only operations"
    true)
  (defcap STAKER (account-name:string)
    "Capability to enforce staker only operations with 'PRIVATE' capability enabled"
    (enforce-guard (at "guard" (read staker-details account-name)))
    (compose-capability (PRIVATE)))
  (defcap GOV_GUARD ()
    "Capability to enforce governance module only operations with 'PRIVATE' capability enabled"
    (enforce-guard (at "guard" (read gov-guard "gov-guard")))
    (compose-capability (PRIVATE)) )
; ***************************Global-GETTERS************************************
 ; are not using capabilities
; ***************************MAIN-FUNCTIONS************************************
  
  (defun constructor:string ()


    (with-capability (TELLOR)
      ...
    )
  )
  (defun init-gov-guard:string (guard:guard)
    ...
  )
  (defun init (governance:module{i-governance})
    (with-capability (TELLOR)
      ... )
  )
  (defun add-staking-rewards (account:string amount:integer)
    (with-capability (PRIVATE)
      ...
    )
  )
  (defun add-staker (staker:string guard:guard)
    (require-capability (PRIVATE))
    ...
  )
  (defun deposit-stake () 
    
      (with-capability (PRIVATE) (add-staker staker guard) )

      (with-capability (STAKER staker)
        ...
       )
     )
    ...
   )
  )
  (defun remove-value:string (query-id:string timestamp:integer)
    @doc "Remove disputed value only called by governance"
    (with-capability (GOV_GUARD)
      ...
    )
  )
  (defun request-staking-withdraw (staker:string amount:integer)
    
         (with-capability (STAKER staker)
        ...
        )
    
  )
  (defun slash-reporter:integer (reporter:string recipient:string)
    (with-capability (GOV_GUARD)
      ...
    )
  )
  (defun submit-value()
        (with-capability (STAKER staker)
          ...
        )
      )
    )
  )
  (defun update-stake-amount ()
    ...
  )

  (defun withdraw-stake (staker:string)
    (with-capability (STAKER staker)
      ...
    )
  )

; ***************************GETTERS*******************************************
  (defun get-block-number-by-timestamp:integer (query-id:string timestamp:integer)
   ...
  )
  (defun get-current-value (query-id:string)
    ...
  )
  (defun get-data-before:object{data-before-value} (query-id:string timestamp:integer)
    (with-capability (PRIVATE)
      ...
    )
  )
  (defun get-new-value-count-by-query-id:integer (query-id:string)
    "Get the number of values submitted for a query id"
    (let ((timestamps (at 'timestamps (read timestamps query-id))))
      (length timestamps) )
  )
  (defun get-pending-reward-by-staker:integer (staker:string)
    "Returns the pending staking reward for a given address"
    (with-capability (PRIVATE)
      ...)
  )
  (defun get-real-staking-rewards-balance:integer ()
    "Returns the real staking rewards balance after accounting for unclaimed rewards"
    (with-capability (PRIVATE)
      ...
    )
  )
  (defun get-report-details (query-id:string timestamp:integer)
    ...
  )
  (defun get-reporter-by-timestamp:string (query-id:string timestamp:integer)
    ...
  )
  (defun get-reporter-last-timestamp (reporter:string)
    ...
  )
  (defun get-reports-submitted-by-address:integer (reporter:string)
    ...
  )
  (defun get-reports-submitted-by-address-and-queryId:integer
    (reporter:string query-id:string)
    ...
  )
  (defun get-staker-info:object (reporter:string)
    ...
  )
  (defun get-timestampby-query-id-and-index:integer (query-id:string index:integer)
    ...
  )
  (defun get-timestamp-index-by-timestamp:integer (query-id:string timestamp:integer)
    ...
  )
  (defun get-total-time-based-rewards-balance:integer ()
    ...
  )
  (defun is-in-dispute:bool (query-id:string timestamp:integer)
    ...
  )
  (defun retrieve-data:string (query-id:string timestamp:integer)
    ...
  )
; ***************************INTERNAL-FUNCTIONS********************************
  (defun transfers-from-flex (amount:integer to:string)
    "Internal function to transfer tokens from contract account to user"
    (require-capability (PRIVATE))
    ...
  )
  (defun transfers-to-flex (amount:integer from:string)
    "Internal function to transfer tokens from user to tellorflex account"
    (require-capability (PRIVATE))
    ...
  )
  (defun update-rewards ()
    "Internal function to update accumulated staking rewards per staked token"
    (require-capability (PRIVATE))
    ...
  )
  (defun update-stake-and-pay-rewards (staker:string new-staked-balance:integer)
    (require-capability (PRIVATE))

  )
  (defun get-updated-accumulated-reward-per-share:integer ()
    "Internal function, gets the updated accumulated reward per share"
    (require-capability (PRIVATE))
    ...
  )
; ***************************HELPER-FUNCTIONS**********************************
  (defun accumulated-reward:integer
    (total-stake-amount:integer total-reward-debt:integer)
    (require-capability (PRIVATE))
    ...
  )
  (defun block-time-in-seconds:integer ()
    ...
  )
  (defun calculate-time-based-reward:integer (block-time:integer)
    (require-capability (PRIVATE))
    ...
  )
  (defun calculate-reward-rate:integer ()
    (require-capability (PRIVATE))
    ...
  )
  (defun concatenate (query-id:string timestamp:integer)
    ...
  )
  (defun plus-one:integer (amount:integer)
    ...
  )
  (defun precision:integer (amount:decimal)
    ...
  )
  (defun to-decimal:decimal (amount:integer)
    ...
  )
  (defun new-accumulated-reward-per-share:integer ()
    (require-capability (PRIVATE))
    ...
  )
  (defun pending-new-accumulated-reward-per-share:integer
    (reward-per-share:integer total-stake:integer)

    (require-capability (PRIVATE))
    ...
  )
  (defun search-if-disputed:object{binary-search-object}
    (search-obj:object{binary-search-object} _:integer)
    (require-capability (PRIVATE))
    ...
  )
  (defun binary-search:object{binary-search-object} (search-obj:object{binary-search-object} _:integer)
    (require-capability (PRIVATE))
    ...
  )
)
