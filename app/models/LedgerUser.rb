class LedgerUser < CDQManagedObject

  Notifier = Motion::Blitz

  def self.fetch_content(ledger, message, &callback)

    data = {access_token: Base.access_token}

    Notifier.show(I18n.t("loading.fetching"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    p Base.access_token

    p "#{Base.base_url}ledgers/#{ledger}/employees"

    AFMotion::HTTP.get("#{Base.base_url}ledgers/#{ledger}/employees", data) do |result|

      Notifier.dismiss if message

      if result.success?

        object = BW::JSON.parse result.object

        output = []

        if object['total'] > 0

          users = LedgerUser.all

          users.each { |user| user.destroy }

          object["backend_users"].each do |attributes|

            user = Hash.new

            user['id'] = attributes["backend_user"]["id"]
            user['account_id'] = attributes["backend_user"]["account_id"]
            user['fullname'] = attributes["backend_user"]["fullname"]
            user['email'] = attributes["backend_user"]["email"]
            user['phone'] = attributes["backend_user"]["phone"]
            user['activated'] = false
            user['status'] = attributes["backend_user"]["ledger_status"]
            user['created_at'] = Base.create_date_from_server_utc(attributes["backend_user"]["created_at"])

            output << LedgerUser.create(user)

          end

          cdq.save

          callback.call(true, output)

        else

          callback.call(false, nil)
      
        end

      elsif result.failure?

        code = result.operation.response.blank? ? 0 : result.operation.response.statusCode

        callback.call(false, code)

      end

    end

  end

end