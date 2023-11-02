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
