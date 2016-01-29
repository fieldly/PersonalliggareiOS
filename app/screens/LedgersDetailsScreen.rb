class LedgersDetailsScreen < BaseScreen

  attr_accessor :ledger_id

  title I18n.t("ledgers.heading_details")

  def on_load

    @workorders ||= []

    create_nav_button_plain :action => 'close_window', :position => 'left', :label => "", :size => 18
 
  end

  def will_appear

    @setup_layout ||= setup_layout

  end

  def setup_layout

    @layout = LedgersDetailsLayout.new(root: self.view).build

    @data = Ledger.where(:id).eq(@ledger_id).first

    setup_actions

    setup_properties

    fetch_state

  end

  def setup_actions

    @layout.icon_authority.when_tapped do

      open AuthorityScreen.new nav_bar: true, ledger_id: @ledger_id

    end

    @layout.icon_emergency.when_tapped do

      open EmergencyScreen.new nav_bar: true, ledger_id: @ledger_id

    end

    @layout.icon_attachments.when_tapped do

      open AttachmentsScreen.new nav_bar: true, attachable_id: @ledger_id, attachable_type: "Ledger", attachment_type: "ledger"

    end

    @layout.button_checkin.when_tapped do

      checkin

    end

    @layout.button_checkout.when_tapped do

      checkout

    end

  end

  def setup_properties

    @layout.line_1.setText(set_value(@data.title))
    @layout.line_2.setText(set_value(@data.location))

  end

  def setup_state(state, date)

    if state

      if state == "in"

        @layout.line_4.setText(date.strftime('%b %d %H:%M').to_s)

        @layout.button_checkin.hidden = true
        @layout.button_checkout.hidden = false
        @layout.date.hidden = false

      elsif state == "out"

        @layout.button_checkin.hidden = false
        @layout.button_checkout.hidden = true
        @layout.date.hidden = true

      end

    else

        @layout.button_checkin.hidden = false
        @layout.button_checkout.hidden = true
        @layout.date.hidden = true

    end

  end

  def save_to_database(id, status)

    entry = Hash.new

    entry['remote_id'] = id
    entry['ledger_id'] = @ledger_id
    entry['status'] = status
    entry['created_at'] = Time.now

    LedgerEntry.create(entry)

    cdq.save

  end

  def fetch_state

    unless @running

      @running = true

      case internet_connected?

        when false

          show_connection_error

        when true

          Ledger.check_state(@data.id, true) do |result, state, date|

            @running = false

            if result

              setup_state(state, date)

            else

              setup_state("out", Time.now)

            end

          end

      end

    end

  end

  def checkin

    unless @running

      @running = true

      case internet_connected?

        when false

          show_connection_error

        when true

          LedgerEntry.create_entry(@data.id, "in", get_data("latitude"), get_data("longitude"), true) do |result|

            if result

              @running = false

              @layout.line_4.setText(Time.now.strftime('%b %d %H:%M').to_s)

              @layout.button_checkin.hidden = true
              @layout.button_checkout.hidden = false
              @layout.date.hidden = false

              save_to_database(1, "in")

            end

          end

      end

    end

  end

  def checkout

    unless @running

      @running = true

      case internet_connected?

        when false

          show_connection_error

        when true

          LedgerEntry.create_entry(@data.id, "out", get_data("latitude"), get_data("longitude"), true) do |result|

            if result

              @running = false

              @layout.button_checkin.hidden = false
              @layout.button_checkout.hidden = true
              @layout.date.hidden = true

              save_to_database(1, "out")

            end

          end

      end

    end

  end

  def close_window

    close
    
  end

end