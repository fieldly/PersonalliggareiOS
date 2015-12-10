class BaseScreen < PM::Screen

  Notifier = Motion::Blitz

  include Elements

  def didReceiveMemoryWarning

    super
    
  end

  def preferredStatusBarStyle

    return UIStatusBarStyleLightContent
    
  end

  def set_resource(id, type, title)
    
    old = Resource.first
    old.destroy

    cdq.save

    Resource.create(id: id, type: type, title: title)
  
    cdq.save

  end

  def set_value(value)
    
    if value.present?

      value

    else

      I18n.t("message.no_value")

    end
    
  end

  def set_badge(value)

    self.navigationController.tabBarItem.badgeValue = "#{value}"

  end

  def remove_badge

    self.navigationController.tabBarItem.badgeValue = nil

  end
  
  def save_image (image_org, name)

    documentsPath = App.documents_path
    filePath = documentsPath.stringByAppendingPathComponent("#{name}.jpg")
    image_mini = image_org.scale_to_fill([600,600], position: :center)
    image_to_save = UIImageJPEGRepresentation(image_mini, 0.8)
    image_to_save.writeToFile(filePath, atomically:true)

  end

  def save_image_only (image_org, name)

    documentsPath = App.documents_path
    filePath = documentsPath.stringByAppendingPathComponent("#{name}.jpg")
    image_to_save = UIImageJPEGRepresentation(image_org, 0.8)
    image_to_save.writeToFile(filePath, atomically:true)

  end

  def current_segment

    get_data("current_segment")

  end

  def convert_date(date)

    dateFormatter = NSDateFormatter.alloc.init
    dateFormatter.setDateFormat("yyyy-MM-dd HH:mm")
    dateString = dateFormatter.dateFromString(date)
    
    dateString

  end

  def internet_connected?

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

  def queued_tasks(object)

    case object
      when "task"
        time = Enqueue.where(:type).eq('timereport').count
        start = Enqueue.where(:type).eq('start').count
        stop = Enqueue.where(:type).eq('stop').count
        reject = Enqueue.where(:type).eq('task_reject').count
        complete = Enqueue.where(:type).eq('task_complete').count
        accept = Enqueue.where(:type).eq('task_accept').count
        signature = Enqueue.where(:type).eq('signature').count
        travel = Enqueue.where(:type).eq('travel').count 
        cost = Enqueue.where(:type).eq('cost').count 
        cost_edit = Enqueue.where(:type).eq('cost_edit').count 
        if start > 0 || stop > 0 || reject > 0 || complete > 0 || accept > 0 || signature > 0 || travel > 0 || cost > 0 || cost_edit > 0
          tasks = true
        else
          tasks = false
        end
      when "message"
        tasks = Enqueue.where(:type).eq('message').count > 0
      when "cost"
        tasks = Enqueue.where(:type).eq('cost').count > 0
      when "cost_edit"
        tasks = Enqueue.where(:type).eq('cost_edit').count > 0
      when "attachments"
        tasks = Enqueue.where(:type).eq('attachments').count > 0
      else
        tasks = Enqueue.count > 0
    end
    
    if tasks.present?

      SVProgressHUD.showImage(UIImage.imageNamed('body/icon_bones.png'), status: I18n.t("loading.queued_tasks"))

      true

    end

  end

  def show_connection_error
    
    SVProgressHUD.showImage(UIImage.imageNamed('body/icon_bones.png'), status: I18n.t("loading.no_connection"))

  end

  def iphone5

    if UIScreen.mainScreen.bounds.size.height == 568.0
      true
    else
      false
    end

  end

  def self.iphone4

    if UIScreen.mainScreen.bounds.size.height == 480.0
      true
    else
      false
    end

  end

  def self.iphone5

    if UIScreen.mainScreen.bounds.size.height == 568.0
      true
    else
      false
    end

  end

  def self.iphone6

    if UIScreen.mainScreen.bounds.size.height == 667.0
      true
    else
      false
    end

  end

  def self.iphone6plus

    if UIScreen.mainScreen.bounds.size.height == 736.0
      true
    else
      false
    end

  end

  def in_motion (speed)

    if speed == 0
      false
    elsif speed > 0
      true
    else
      false
    end

  end

  def calculate_speed (distance, speed)

    distance = distance * 10000

    speed = speed * 3600

    distance / speed

  end

  def set_data (name, data) 

    App::Persistence[name] = data

  end

  def get_data (name) 

    App::Persistence[name]

  end

  def close_modal

    self.dismissModalViewControllerAnimated(true) 

  end

  def show_connection_error
    
    App.alert I18n.t("loading.no_connection")

  end

  def location_enabled?

    if CLLocationManager.authorizationStatus == 3

      true

    else

      false

    end
    
  end

  def location_running?

    if @locationManager.nil? && get_data("travel_running")

      true

    else

      false
      
    end

  end

  def show_tab_bar

    if Device.ios_version.to_f >= 7.0

      self.tab_bar.tabBar.setTranslucent(false) 

      frame = self.view.frame

      self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 50)

    end

    self.tab_bar.tabBar.setHidden(false)

  end

  def hide_tab_bar

    if Device.ios_version.to_f >= 7.0
      
      self.tab_bar.tabBar.setTranslucent(true) 

      frame = self.view.frame

      self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 50)

    end

    self.tab_bar.tabBar.setHidden(true)
    
  end

  def translate_priority (priority)

    case priority

      when 1 then "Low"
      when 2 then "Medium"
      when 3 then "High"

    end

  end

  def convert_datetime(datetime, time)

    if time

      datetime.strftime('%Y-%m-%d %H:%M')

    else

      datetime.strftime('%Y-%m-%d')

    end

  end

  def self.convert_utc_to_date(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone(NSTimeZone.timeZoneWithAbbreviation("UTC"))
    df.setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

    date = df.dateFromString(date)

    date

  end

  def convert_to_date(date)

    df = NSDateFormatter.alloc.init
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    date = df.dateFromString(date)

    date

  end

  def convert_to_date_table(date)

    if date.present?

      df = NSDateFormatter.alloc.init
      df.setDateFormat("yyyy-MM-dd HH:mm:ss")

      date = df.dateFromString("#{date}:00")
      date.strftime('%b %d')
      
      date

    end

  end

  def convert_to_utc(date)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    date = df.dateFromString(date)

    date.utc

  end

  def convert_to_timestamp(date)

    df = NSDateFormatter.alloc.init
    df.setDateFormat("yyyy-MM-dd HH:mm")

    date = df.dateFromString(date)
    time_in_utc = date.to_time.utc
    results = time_in_utc.to_i * 1000

    results

  end

  def convert_to_seconds(date, start_time, end_time)

    df = NSDateFormatter.alloc.init
    df.setTimeZone("UTC".nstimezone)
    df.setDateFormat("yyyy-MM-dd HH:mm:ss")

    start_date = df.dateFromString("#{date} #{start_time}:00")
    end_date = df.dateFromString("#{date} #{end_time}:00")

    converted = (end_date - start_date).to_i

    converted

  end

  def split_time(seconds)

    seconds = seconds.round
    @hours = seconds / 3600
    seconds -= @hours * 3600
    @minutes = seconds / 60
    seconds -= @minutes * 60

    "#{@hours} #{I18n.t("timereports.label_hours")} #{@minutes} #{I18n.t("timereports.label_minutes")}"

  end

  def get_hours_or_minutes(seconds, type)

    seconds = seconds.round
    @hours = seconds / 3600
    seconds -= @hours * 3600
    @minutes = seconds / 60
    seconds -= @minutes * 60

    if type == "hours"
      @hours
    elsif type == "minutes"
      @minutes
    end

  end

  def calculate_seconds(start_date, start_time, end_date, end_time)

    first = convert_to_utc("#{start_date} #{start_time}:00")
    second = convert_to_utc("#{end_date} #{end_time}:00")

    converted = (second - first).to_i

    converted

  end

  def get_week_number(date)

    date.strftime("%V").to_i
    
  end

  def convert_day_name(name)

    case name
      when "Monday" then "Måndag"
      when "Tuesday" then "Tisdag"
      when "Wednesday" then "Onsdag"
      when "Thursday" then "Torsdag"
      when "Friday" then "Fredag"
      when "Saturday" then "Lördag"
      when "Sunday" then "Söndag"
    end

  end

  def handle_error(code)

    if code == 401

      App.alert I18n.t("loading.login_failed")

    elsif code == 422

      App.alert I18n.t("loading.missing")

    elsif code == 500

      App.alert I18n.t("loading.server_error")

    elsif code == 0

      App.alert I18n.t("loading.server_error")

    end

  end
  
end