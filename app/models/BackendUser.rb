class BackendUser < CDQManagedObject

  Notifier = Motion::Blitz

  def self.login(email, password, message, &callback)

    Notifier.show(I18n.t("loading.fetching"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    data = {email: email, password: password, device_token: "NO_TOKEN_YET", device_type: "iphone"}

    AFMotion::HTTP.post("#{Base.base_url}sessions", data) do |result|

      Notifier.dismiss if message
      
      if result.success?

        object = BW::JSON.parse result.object

        users = BackendUser.all
        users.each { |user| user.destroy }

        backend_user = Hash.new

        backend_user['id'] = object["id"]
        backend_user['account_id'] = object["account_id"]
        backend_user['access_token'] = object["access_token"]
        backend_user['firstname'] = object["firstname"]
        backend_user['lastname'] = object["lastname"]
        backend_user['email'] = object["email"]
        backend_user['phone'] = object["phone"]
        backend_user['locale'] = object["locale"]
        backend_user['manage_workorders'] = object["manage_workorders"]
        backend_user['currency_symbol'] = object["currency_symbol"]
        backend_user['currency_symbol_first'] = object["currency_symbol_first"]

        if object["destination"].present?
          
          backend_user['address'] = object["destination"]["address"]
          backend_user['address_2'] = object["destination"]["address_2"]
          backend_user['address_full'] = object["destination"]["address_full"]
          backend_user['zipcode'] = object["destination"]["zipcode"]
          backend_user['city'] = object["destination"]["city"]
          backend_user['state'] = object["destination"]["state"]
          backend_user['country'] = object["destination"]["country"]

        end

        BackendUser.create(backend_user)

        cdq.save

        callback.call(true, object)

      elsif result.failure?

        code = result.operation.response.blank? ? 0 : result.operation.response.statusCode

        callback.call(false, code)

      end

    end

  end

end