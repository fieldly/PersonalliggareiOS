class AuthorityScreen < BaseScreen

  attr_accessor :ledger_id

  title I18n.t("ledgers.heading_details")

  def on_load

    @workorders ||= []

    create_nav_button_plain :action => 'close', :position => 'left', :label => "", :size => 18
 
  end

  def will_appear

    @setup_layout ||= setup_layout

  end

  def setup_layout

    @layout = AuthorityLayout.new(root: self.view).build

    @data = Ledger.where(:id).eq(@ledger_id).first

    setup_actions

  end

  def setup_actions

    @layout.button_fetch.when_tapped do

      process_data

    end

  end

  def process_data

    @layout.textfield.resignFirstResponder

    if @layout.textfield.text.present?

      fetch_ledger

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

          Ledger.fetch_entries(@data.id, @layout.textfield.text, true) do |result, code|

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

end