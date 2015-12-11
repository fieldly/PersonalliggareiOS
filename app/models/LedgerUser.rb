class LedgerUser < CDQManagedObject

  Notifier = Motion::Blitz

  def self.fetch_content(ledger, message, &callback)

    data = {access_token: Base.access_token}

    Notifier.show(I18n.t("loading.fetching"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    AFMotion::HTTP.get("#{Base.base_url}ledgers", data) do |result|

      Notifier.dismiss if message

      if result.success?

        object = BW::JSON.parse result.object

        output = []

        if object['total'] > 0

          users = LedgerUser.all

          users.each { |user| user.destroy }

          object["ledgers"].each do |attributes|

            user = Hash.new

            user['id'] = 1
            user['account_id'] = 1
            user['fullname'] = "Patrik Andersson"
            user['email'] = "patrik@fieldly.com"
            user['phone'] = "123456"
            user['activated'] = false
            user['status'] = "in"
            user['created_at'] = Time.now

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