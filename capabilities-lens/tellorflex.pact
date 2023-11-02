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
