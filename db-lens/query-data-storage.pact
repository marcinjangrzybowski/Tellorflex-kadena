
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
