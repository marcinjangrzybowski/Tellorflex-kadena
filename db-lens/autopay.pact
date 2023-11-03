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
