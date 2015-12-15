class Ledger < CDQManagedObject

  Notifier = Motion::Blitz

  def self.fetch_content(latitude, longitude, message, &callback)

    data = {access_token: Base.access_token, latitude: latitude, longitude: longitude}

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

          ledgers = Ledger.all

          ledgers.each { |ledger| ledger.destroy }

          object["ledgers"].each do |attributes|

            ledger = Hash.new

            ledger['id'] = attributes["ledger"]["id"]
            ledger['title'] = attributes["ledger"]["title"]
            ledger['location'] = attributes["ledger"]["location"]
            ledger['site_id_number'] = attributes["ledger"]["site_id_number"]
            ledger['starts_at'] = Base.create_date_from_server_utc(attributes["ledger"]["starts_at"])
            ledger['ends_at'] = Base.create_date_from_server_utc(attributes["ledger"]["ends_at"])

            output << Ledger.create(ledger)

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

  def self.send_to_authorities(ledger, code, message, &callback)

    data = {access_token: Base.access_token, code: code}

    Notifier.show(I18n.t("loading.fetching"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    AFMotion::HTTP.get("#{Base.base_url}ledgers/#{ledger}", data) do |result|

      if result.success?

        object = BW::JSON.parse result.object

        Notifier.dismiss if message

        callback.call(true, object['code'])

      elsif result.failure?

        code = result.operation.response.blank? ? 0 : result.operation.response.statusCode

        callback.call(false, code)

      end

    end

  end

end