class LoginSetupLocationScreen < BaseScreen

  title I18n.t("login_setup.heading_location")

  def on_load

    create_nav_button_plain :action => 'blank', :position => 'left', :image => 'button_blank'

  end

  def will_appear

    @setup_layout ||= setup_layout
    @setup_actions ||= setup_actions

  end

  def setup_layout

    @layout = LoginSetupLocationLayout.new(root: self.view).build

  end

  def setup_actions

    @layout.button_activate.when_tapped do

      activate_location

    end

  end

  def activate_location

    BW::Location.location_manager.requestAlwaysAuthorization if Base.ios8?
    BW::Location.get(distance_filter: 10, desired_accuracy: :nearest_ten_meters) do |result|

      BW::Location.stop

      user = BackendUser.all.first

      set_data("activated_location", true)

      self.dismissModalViewControllerAnimated(true)

    end

  end

  def blank

  end

end