 class Base

  def self.version

    "1.0.1"
    
  end

  def self.base_url

    #"https://fieldly.com/api/v2/"
    #"http://qa.fieldly.com/api/v2/"
    "http://66454c5b.ngrok.io/api/v2/"

  end

  def self.access_token

    user = BackendUser.first

    if user
      user.access_token
    else
      nil
    end

  end

  def self.encrypt_channel(string)

    NSData.MD5HexDigest("#{string}".dataUsingEncoding(NSUTF8StringEncoding))
    
  end

  def self.user_data

    BackendUser.first

  end

  def self.pubnub_publishKey

    "pub-c-f9a7c910-dfda-480b-a32f-7d823e7fd840"

  end

  def self.pubnub_subscribeKey

    "sub-c-283196b0-e58f-11e3-bff7-02ee2ddab7fe"
    
  end

  def self.pubnub_secretKey

    "sec-c-Mzg2MzdiZTktMjNlZi00ZmM5LWFiNjYtNjZlN2NlNWRhY2I4"
    
  end
  
  def self.pusher_app_key

    "8a2d8b320a6dc0db7694"

  end

  def self.pusher_auth_url 

    "https://fieldly.com/api/v1/pushers/auth?access_token=#{Base.access_token}"

  end

  def self.ios8?
    
    Device.ios_version.to_f >= 8.0 ? true : false

  end

  def self.internet_connected?

    if Device.ios_version.to_f >= 7.0 and not Device.simulator?

      reach = Reachability.reachabilityForLocalWiFi.init

      unless reach.currentReachabilityStatus == 2

        telephonyInfo = CTTelephonyNetworkInfo.new

        case telephonyInfo.currentRadioAccessTechnology
          when CTRadioAccessTechnologyWCDMA then true
          when CTRadioAccessTechnologyHSDPA then true
          when CTRadioAccessTechnologyHSUPA then true
          when CTRadioAccessTechnologyCDMA1x then true
          when CTRadioAccessTechnologyCDMAEVDORev0 then true
          when CTRadioAccessTechnologyCDMAEVDORevA then true
          when CTRadioAccessTechnologyCDMAEVDORevB then true
          when CTRadioAccessTechnologyeHRPD then true
          when CTRadioAccessTechnologyLTE then true
          when CTRadioAccessTechnologyGPRS then false
          when CTRadioAccessTechnologyEdge then false
          else false
        end

      else

        true

      end

    else
      
      reach = Reachability.reachabilityWithHostname("www.google.com")
      reach.isReachable

    end

  end

  def self.get_distance(meters)

    meters = meters.to_i

    if I18n.locale == "sv" or I18n.locale == "sv-SE"

      "#{meters.in_kilometers.round} kilometer"

    else

      "#{meters.in_feet.round * 0.00018939} miles"

    end
    
  end

  def self.save_coordinates_once

    App::Persistence["latitude"] = nil
    App::Persistence["longitude"] = nil

    if BW::Location.enabled? && BW::Location.authorized?

      BW::Location.location_manager.requestAlwaysAuthorization if Base.ios8?
      BW::Location.get_once(desired_accuracy: :best) do |result|

        p "result: #{result}"

        if result.is_a?(CLLocation)

          App::Persistence["latitude"] = result.coordinate.latitude
          App::Persistence["longitude"] = result.coordinate.longitude

        else

          App::Persistence["latitude"] = 0
          App::Persistence["longitude"] = 0

        end

      end

    else

      App::Persistence["latitude"] = 0
      App::Persistence["longitude"] = 0

    end
      
  end

  def self.save_coordinates

    App::Persistence["latitude"] = nil
    App::Persistence["longitude"] = nil

    if BW::Location.enabled? && BW::Location.authorized?

      BW::Location.location_manager.requestAlwaysAuthorization if Base.ios8?
      BW::Location.get(desired_accuracy: :best) do |result|

        if result[:to]

          App::Persistence["latitude"] = result[:to].latitude
          App::Persistence["longitude"] = result[:to].longitude

          p "App::Persistence['latitude']: #{App::Persistence["latitude"]}"
          p "App::Persistence['longitude']: #{App::Persistence["longitude"]}"

        else

          App::Persistence["latitude"] = 0
          App::Persistence["longitude"] = 0

        end

      end

    else

      App::Persistence["latitude"] = 0
      App::Persistence["longitude"] = 0

    end
    
  end

  def self.fetch_coordinates(&callback)

    if BW::Location.enabled? && BW::Location.authorized?

      BW::Location.location_manager.requestAlwaysAuthorization if Base.ios8?
      BW::Location.get(distance_filter: 2, desired_accuracy: :best_for_navigation) do |result|

        BW::Location.stop

        if result[:to]

          latitude = result[:to].latitude

          longitude = result[:to].longitude

        else

          latitude = nil

          longitude = nil

        end

        callback.call(latitude, longitude)

      end

    else

      callback.call(nil, nil)

    end

  end

  def self.create_utc_timestamp(date, time)

    df = NSDateFormatter.alloc.init
    df.setDateFormat("yyyy-MM-dd HH:mm")

    date = df.dateFromString("#{date} #{time}")
    time_in_utc = date.to_time.utc
    results = time_in_utc.to_i * 1000

    results

  end

  def self.create_utc_timestamp_single(date)

    df = NSDateFormatter.alloc.init
    df.setDateFormat("yyyy-MM-dd HH:mm")

    date = df.dateFromString(date)
    time_in_utc = date.to_time.utc
    results = time_in_utc.to_i * 1000

    results

  end

  def self.create_short_date(datetime)

    if datetime.present?

      datetime.strftime('%d %b').to_s

    else

      I18n.t("message.no_value")

    end

  end

  def self.create_short_time(datetime)

    if datetime.present?

      datetime.strftime('%H:%M').to_s

    else

      I18n.t("message.no_value")

    end

  end

  def self.create_simple_date(datetime, time)

    if time

      datetime.strftime('%Y-%m-%d %H:%M')

    else

      datetime.strftime('%Y-%m-%d')

    end

  end

  def self.create_date_from_server_utc(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone(NSTimeZone.timeZoneWithAbbreviation("UTC"))
    df.setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

    date = df.dateFromString(date)

    date

  end

  def self.create_seconds(date, start_time, end_time)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    start_date = df.dateFromString("#{date} #{start_time}:00")
    end_date = df.dateFromString("#{date} #{end_time}:00")

    converted = (end_date - start_date).to_i
    converted

  end

  def self.create_seconds_single(date_start, date_end)

    converted = (date_end - date_start).to_i
    converted

  end

  def self.create_normal_date(date, time, utc = true)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone) if utc
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    converted = df.dateFromString(date + " " + time + ":00")
    converted

  end

  def self.create_semisimple_date(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm")

    date = df.dateFromString(date)

    date

  end

  def self.create_picker_date(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    date = df.dateFromString(date)

    date.utc

  end

  def self.create_utc_date(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    date = df.dateFromString(date)

    date#.utc

  end

  def self.convert_state(value)
    
    case value
      when "pending" then I18n.t("general.state_pending")
      when "activated" then I18n.t("general.state_activated")
      when "paused" then I18n.t("general.state_paused")
      when "completed" then I18n.t("general.state_completed")
      when "closed" then I18n.t("general.state_closed")
    end

  end

end