class AuthorityScreen < BaseScreen

  attr_accessor :ledger_id

  title I18n.t("ledgers.heading_authority")

  def on_load

    @workorders ||= []

    create_nav_button_plain :action => 'close_window', :position => 'left', :label => "", :size => 18
 
  end

  def will_appear

    @setup_layout ||= setup_layout

  end

  def setup_layout

    @layout = AuthorityLayout.new(root: self.view).build

    @data = Ledger.where(:id).eq(@ledger_id).first

    @layout.textfield.delegate = self
    @layout.textfield_email.delegate = self

    setup_actions

  end

  def setup_actions

    @layout.button_fetch.when_tapped do

      process_data

    end

  end

  def process_data

    @layout.textfield.resignFirstResponder

    if @layout.textfield.text.present? && @layout.textfield_email.text.present?

      if @data.site_id_number.downcase == @layout.textfield.text.downcase

        fetch_ledger

      else

        App.alert(I18n.t("ledgers.label_do_not_match"))

      end

    else

      App.alert(I18n.t("ledgers.label_missing_fields"))

    end

  end

  def fetch_ledger

    unless @running

      @running = true

      case internet_connected?

        when false

          show_connection_error

        when true

          Ledger.send_to_authorities(@data.id, @layout.textfield.text, @layout.textfield_email.text, true) do |result, code|

            if result

              @running = false

              @layout.code.setText(code)

              @layout.info.hidden = true
              @layout.button_fetch.hidden = true
              @layout.code_container.hidden = false

            end

          end

      end

    end

  end

  def doneWithPad

    @layout.textfield.resignFirstResponder
    @layout.textfield_email.resignFirstResponder

  end

  def textFieldDidBeginEditing(textField)

    @layout.scroll.contentSize = CGSizeMake(320, 665) if BaseScreen.iphone4
    @layout.scroll.contentSize = CGSizeMake(320, 577) if BaseScreen.iphone5
    @layout.scroll.contentSize = CGSizeMake(345, 525) if BaseScreen.iphone6
    @layout.scroll.contentSize = CGSizeMake(345, 525) if BaseScreen.iphone6plus

  end

  def textFieldDidEndEditing(textField)

    @layout.scroll.contentSize = CGSizeMake(320, 440) if BaseScreen.iphone4
    @layout.scroll.contentSize = CGSizeMake(320, 440) if BaseScreen.iphone5
    @layout.scroll.contentSize = CGSizeMake(345, 500) if BaseScreen.iphone6
    @layout.scroll.contentSize = CGSizeMake(345, 500) if BaseScreen.iphone6plus

  end

  def textFieldShouldReturn(textfield)

    doneWithPad

  end

  def close_window

    App.notification_center.post "updateLedgerEntry"
    
    close

  end

end