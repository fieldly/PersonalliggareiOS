class LoginScreen < BaseScreen

  title I18n.t("login.heading")

  def will_appear

    @setup_layout ||= setup_layout
    @setup_actions ||= setup_actions

  end

  def setup_layout

    @layout = LoginLayout.new(root: self.view).build

    @email = @layout.textfield_email
    @email.delegate = self

    @password = @layout.textfield_password
    @password.delegate = self

  end

  def setup_actions

    @layout.button_send.when_tapped do

      login

    end

  end

  def login

    unless @running

      @running = true

      unless @email.text.present? || @password.text.present?

        @running = false

        App.alert I18n.t("login.message_missing_fields")

        return

      end

      BackendUser.login(@email.text, @password.text, true) do |success, response|

        @running = false

        case success

          when true 

            clear_database

            App.notification_center.post "updateTableLedgers"

            if get_data("activated_location")

              self.dismissModalViewControllerAnimated(true)

            else

              open LoginSetupLocationScreen.new nav_bar: true

            end

          when false

            App.run_after(1) { @email.becomeFirstResponder } 

            handle_error response

        end

      end

    end

  end

  def clear_database

    ledgers = Ledger.all
    ledgers.each { |ledger| ledger.destroy }

    cdq.save

  end

  def textFieldDidBeginEditing(textField)

    @layout.scroll.contentSize = CGSizeMake(320,622) if BaseScreen.iphone4
    @layout.scroll.contentSize = CGSizeMake(320,534) if BaseScreen.iphone5
    @layout.scroll.contentSize = CGSizeMake(320,500) if BaseScreen.iphone6

  end

  def textFieldDidEndEditing(textField)

    @layout.scroll.contentSize = CGSizeMake(320,400) if BaseScreen.iphone4
    @layout.scroll.contentSize = CGSizeMake(320,400) if BaseScreen.iphone5
    @layout.scroll.contentSize = CGSizeMake(320,455) if BaseScreen.iphone6

  end

  def textFieldShouldReturn(textfield)

    @email.resignFirstResponder
    @password.resignFirstResponder

  end

end