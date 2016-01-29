class Attachment < CDQManagedObject

  Notifier = Motion::Blitz

  def self.fetch_content(attachable_id, attachable_type, type, message, &callback)

    Notifier.show(I18n.t("loading.fetching"), :gradient) if message

    EM.add_timer 3000.0 do
  
      Notifier.dismiss if message

    end

    url = "#{Base.base_url}projects/#{attachable_id}/attachments" if attachable_type == "Project"
    url = "#{Base.base_url}workorders/#{attachable_id}/attachments" if attachable_type == "Workorder"
    url = "#{Base.base_url}backend_users/#{attachable_id}/attachments" if attachable_type == "BackendUser"
    url = "#{Base.base_url}ledgers/#{attachable_id}/attachments" if attachable_type == "Ledger"

    p "#{url}?access_token=#{Base.access_token}"

    data = {access_token: Base.access_token, type: type}

    AFMotion::HTTP.get(url, data) do |result|

      Notifier.dismiss if message

      if result.success?

        object = BW::JSON.parse result.object

        output = []

        if object['total'] > 0

          attachments = Attachment.where(attachable_id: attachable_id)
          
          attachments.each { |attachment| attachment.destroy }

          object["attachments"].each do |attributes|

            attachment = Hash.new

            attachment['id'] = attributes["attachment"]["id"]
            attachment['remote_id'] = attributes["attachment"]["id"]
            attachment['account_id'] = attributes["attachment"]["account_id"]
            attachment['attachable_id'] = attributes["attachment"]["attachable_id"]
            attachment['attachable_type'] = attributes["attachment"]["attachable_type"]
            attachment['title'] = attributes["attachment"]["title"]
            attachment['filename'] = attributes["attachment"]["filename"]
            attachment['filetype'] = attributes["attachment"]["filetype"]
            attachment['fileurl'] = attributes["attachment"]["fileurl"]
            attachment['created_at'] = BaseScreen.convert_utc_to_date(attributes["attachment"]["created_at"])

            output << Attachment.create(attachment)

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