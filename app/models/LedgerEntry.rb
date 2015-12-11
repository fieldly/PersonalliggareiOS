class LedgerEntry < CDQManagedObject

  Notifier = Motion::Blitz

  def self.create_entry(ledger, entry_type, latitude, longitude, message, &callback)

    data = {access_token: Base.access_token, entry_type: entry_type, latitude: latitude, longitude: longitude}

    Notifier.show(I18n.t("loading.sending"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    AFMotion::HTTP.post("#{Base.base_url}ledgers/#{ledger}/ledger_entries", data) do |result|

      if result.success?

        Notifier.dismiss if message

        callback.call(true)

      elsif result.failure?

        code = result.operation.response.blank? ? 0 : result.operation.response.statusCode

        callback.call(false, code)

      end

    end

  end

end