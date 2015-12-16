class LedgersScreen < BaseScreen

  title I18n.t("ledgers.heading")

  def on_load

    @ledgers ||= []

    create_nav_button_plain :action => 'logout_alert', :position => 'right', :label => "", :size => 19

  end

  def on_appear

    @user = BackendUser.count

    open_modal LoginScreen.new nav_bar: true if @user == 0

    Base.save_coordinates

    table_data_check unless @user == 0

  end

  def will_appear

    @setup_layout ||= setup_layout
    @setup_observers ||= setup_observers

  end

  def will_dismiss

    App.notification_center.unobserve @update_projects_observer

  end

  def setup_layout

    @layout = LedgersLayout.new(root: self.view).build

    @table = @layout.table
    @table.delegate = self
    @table.dataSource = self
    @table.tableHeaderView = create_table_header_small text: I18n.t("ledgers.label_click_to_select")

    create_refresh

  end

  def setup_observers

    @update_projects_observer = App.notification_center.observe "updateTableLedgers" do |notification|

      table_data_check

    end

  end

  def table_data_check

    data = filter_query

    if data.count > 0

      table_data_cache

    else

      table_data

    end

  end

  def table_data_cache

    filter_query

    if @ledgers.count > 0

      @table.tableHeaderView = create_table_header_small text: I18n.t("ledgers.label_click_to_select")

    else

      @table.tableHeaderView = @layout.empty.setHidden(false)

    end

    @table.reloadData

  end

  def table_data

    case internet_connected?

      when false 

        show_connection_error

        @table.pullToRefreshView.stopAnimating

      when true

        Ledger.fetch_content(get_data("latitude"), get_data("longitude"), true) do |success, response|

          case success

            when true 

              filter_query 

              if @ledgers.count > 0

                @table.tableHeaderView = create_table_header_small text: I18n.t("ledgers.label_click_to_select")

              else

                @table.tableHeaderView = @layout.empty.setHidden(false)

              end
              
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

            when false

              @ledgers = []

              @table.tableHeaderView = @layout.empty.setHidden(false)
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

              handle_error response

          end

        end

    end

  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)

    data = @ledgers[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier("attachment_cell") || begin

      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:"attachment_cell")

    end

    rounded_top = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top_wide.png")) if BaseScreen.iphone6
    rounded_top = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top.png")) unless BaseScreen.iphone6
    rounded_bottom = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom_wide.png")) if BaseScreen.iphone6
    rounded_bottom = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom.png")) unless BaseScreen.iphone6

    title = UILabel.new
    title.frame = [[10,0],[250,33]] if BaseScreen.iphone4
    title.frame = [[10,0],[250,33]] if BaseScreen.iphone5
    title.frame = [[10,0],[250,33]] if BaseScreen.iphone6
    title.frame = [[10,0],[250,33]] if BaseScreen.iphone6plus
    title.text = set_value(data.title)
    title.font = "OpenSans-Bold".uifont(13)
    title.textColor = "#333333".to_color
    title.textAlignment = UITextAlignmentLeft
    title.backgroundColor = UIColor.clearColor

    location = UILabel.new
    location.frame = [[10,0],[250,32]] if BaseScreen.iphone4
    location.frame = [[10,0],[250,32]] if BaseScreen.iphone5
    location.frame = [[10,0],[250,32]] if BaseScreen.iphone6
    location.frame = [[10,0],[250,32]] if BaseScreen.iphone6plus
    location.text = data.location
    location.font = "OpenSans-Semibold".uifont(13)
    location.textColor = "#929eb6".to_color
    location.textAlignment = UITextAlignmentLeft
    location.backgroundColor = UIColor.clearColor

    site_id = UILabel.new
    site_id.frame = [[10,0],[250,32]] if BaseScreen.iphone4
    site_id.frame = [[10,0],[250,32]] if BaseScreen.iphone5
    site_id.frame = [[10,0],[250,32]] if BaseScreen.iphone6
    site_id.frame = [[10,0],[250,32]] if BaseScreen.iphone6plus
    site_id.text = set_value(data.site_id_number)
    site_id.font = "OpenSans-Semibold".uifont(13)
    site_id.textColor = "#929eb6".to_color
    site_id.textAlignment = UITextAlignmentLeft
    site_id.backgroundColor = UIColor.clearColor

    top = UIView.alloc.initWithFrame([[0, 0],[290, 32]]) if BaseScreen.iphone4
    top = UIView.alloc.initWithFrame([[0, 0],[290, 32]]) if BaseScreen.iphone5
    top = UIView.alloc.initWithFrame([[0, 0],[345, 32]]) if BaseScreen.iphone6
    top = UIView.alloc.initWithFrame([[0, 0],[385, 32]]) if BaseScreen.iphone6plus
    top.backgroundColor = rounded_top
    top.addSubview(title)

    middle = UIView.alloc.initWithFrame([[0, 33],[290, 32]]) if BaseScreen.iphone4
    middle = UIView.alloc.initWithFrame([[0, 33],[290, 32]]) if BaseScreen.iphone5
    middle = UIView.alloc.initWithFrame([[0, 33],[345, 32]]) if BaseScreen.iphone6
    middle = UIView.alloc.initWithFrame([[0, 33],[385, 32]]) if BaseScreen.iphone6plus
    middle.backgroundColor = "#ffffff".to_color
    middle.addSubview(location)

    bottom = UIView.alloc.initWithFrame([[0, 65],[290, 32]]) if BaseScreen.iphone4
    bottom = UIView.alloc.initWithFrame([[0, 65],[290, 32]]) if BaseScreen.iphone5
    bottom = UIView.alloc.initWithFrame([[0, 65],[345, 32]]) if BaseScreen.iphone6
    bottom = UIView.alloc.initWithFrame([[0, 65],[385, 32]]) if BaseScreen.iphone6plus
    bottom.backgroundColor = rounded_bottom
    bottom.addSubview(site_id)

    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.backgroundColor = UIColor.clearColor
    cell.addSubview(top)
    cell.addSubview(middle)
    cell.addSubview(bottom)

    cell

  end

  def tableView(tableView, numberOfRowsInSection:section)

    @ledgers.count

  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)

    112

  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    data = @ledgers[indexPath.row]

    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    open LedgersDetailsScreen.new nav_bar: true, ledger_id: data.id

  end

  def filter_query

    @ledgers = Ledger.sort_by(:title, :ascending)
    @ledgers
    
  end

  def logout_alert

    UIAlertView.alert(I18n.t("ledgers.label_dialog_title"), message: I18n.t("ledgers.label_dialog_message_logout"), buttons: [I18n.t("ledgers.label_dialog_no"), I18n.t("ledgers.label_dialog_yes")]) do |button, button_index|
      
      if button == I18n.t("ledgers.label_dialog_yes")

        logout

      end

    end

  end

  def logout

    users = BackendUser.all
    users.each { |user| user.destroy }

    ledgers = Ledger.all
    ledgers.each { |ledger| ledger.destroy }

    ledger_entries = LedgerEntry.all
    ledger_entries.each { |ledger_entry| ledger_entry.destroy }

    ledger_users = LedgerUser.all
    ledger_users.each { |ledger_user| ledger_user.destroy }

    attachments = Attachment.all
    attachments.each { |attachment| attachment.destroy }

    cdq.save

    open_modal LoginScreen.new nav_bar: true

  end

end