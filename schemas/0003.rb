schema "0003" do

  entity "BackendUser" do

    integer32 :id
    integer32 :account_id
    string    :access_token
    string    :firstname
    string    :lastname
    string    :email
    string    :phone
    string    :locale
    string    :currency_symbol
    boolean   :currency_symbol_first
    string    :address
    string    :address_2
    string    :address_full
    string    :zipcode
    string    :city
    string    :state
    string    :country
    boolean   :manage_workorders
    
  end

  entity "Ledger" do

    integer32 :id
    integer32 :ledgerable_id
    string    :ledgerable_type
    string    :title
    string    :location
    string    :site_id_number
    string    :current_state
    integer32 :backend_user_id
    datetime  :starts_at
    datetime  :ends_at

  end

  entity "LedgerEntry" do

    integer32 :id
    integer32 :remote_id
    integer32 :ledger_id
    string    :status
    datetime  :created_at

  end

  entity "LedgerUser" do

    integer32 :id
    integer32 :account_id
    string    :account_title
    string    :fullname
    string    :email
    string    :phone
    string    :status
    boolean   :activated
    datetime  :created_at

  end

  entity "Attachment" do

    integer32 :id
    integer32 :account_id
    integer32 :remote_id
    integer32 :attachable_id
    string    :attachable_type
    string    :title
    string    :filename
    string    :filetype
    string    :filesize
    string    :fileurl
    datetime  :created_at

  end

end