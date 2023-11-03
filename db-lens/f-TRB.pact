
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
