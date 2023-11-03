
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
