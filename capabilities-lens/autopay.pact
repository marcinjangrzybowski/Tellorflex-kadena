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
