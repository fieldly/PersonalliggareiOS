class LedgersDetailsScreen < BaseScreen

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

    @layout = LedgersDetailsLayout.new(root: self.view).build

    @data = Ledger.where(:id).eq(@ledger_id).first

    Base.save_coordinates

    setup_actions

    setup_properties

  end

  def setup_actions

    @layout.icon_authority.when_tapped do

      #open ContactsScreen.new nav_bar: true, assignable_id: @data.id, assignable_type: "Project"

      p "Authority"

    end

    @layout.icon_emergency.when_tapped do

      #open AttachmentsScreen.new nav_bar: true, attachable_id: @data.id, attachable_type: "Project"

      p "Emergency"

    end

    @layout.icon_attachments.when_tapped do

      #open AttachmentsScreen.new nav_bar: true, attachable_id: @data.id, attachable_type: "Project"

      p "Attachments"

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
    @layout.line_3.setText(set_value(@data.site_id_number))

  end

  def checkin

    unless @running

      @running = true

      case internet_connected?

        when false

          show_connection_error

        when true

          Ledger.update_status(@data.id, "in", get_data("latitude"), get_data("longitude"), true) do |result|

            if result

              @running = false

              @layout.button_checkin.hidden = true
              @layout.button_checkout.hidden = false

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

          Ledger.update_status(@data.id, "out", get_data("latitude"), get_data("longitude"), true) do |result|

            if result

              @running = false

              @layout.button_checkin.hidden = false
              @layout.button_checkout.hidden = true

            end

          end

      end

    end

  end

end