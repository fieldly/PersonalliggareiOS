class EmergencyScreen < BaseScreen

  attr_accessor :ledger_id

  title I18n.t("emergency.heading")

  def on_load

    @users ||= []

    create_nav_button_plain :action => 'close', :position => 'left', :label => "", :size => 18
    
  end

  def will_appear

    @setup_layout ||= setup_layout

  end

  def setup_layout

    @layout = EmergencyLayout.new(root: self.view).build

    @table = @layout.table
    @table.delegate = self
    @table.dataSource = self

    @table.tableHeaderView = create_table_header_small

    create_refresh

    table_data

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

    if @users.count > 0

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

        LedgerUser.fetch_content(@ledger_id, true) do |success, response|

          case success

            when true 

              filter_query 

              if @users.count > 0

                @table.tableHeaderView = create_table_header_small text: I18n.t("ledgers.label_click_to_select")

              else

                @table.tableHeaderView = @layout.empty.setHidden(false)

              end
              
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

            when false

              @users = []

              @table.tableHeaderView = @layout.empty.setHidden(false)
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

              handle_error response

          end

        end

    end

  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)

    data = @users[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier("filter_cell") || begin

      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:"filter_cell")

    end

    title = UILabel.new
    title.frame = [[10,10],[250,20]] if BaseScreen.iphone4
    title.frame = [[10,10],[250,20]] if BaseScreen.iphone5
    title.frame = [[10,10],[250,20]] if BaseScreen.iphone6
    title.frame = [[10,10],[250,20]] if BaseScreen.iphone6plus
    title.text = data.fullname
    title.font = "OpenSans-Bold".uifont(13)
    title.textColor = "#333".to_color if data.status == "in"
    title.textColor = "#e74c3c".to_color if data.status == "out"
    title.textAlignment = UITextAlignmentLeft
    title.backgroundColor = UIColor.clearColor

    account = UILabel.new
    account.frame = [[10,30],[250,20]] if BaseScreen.iphone4
    account.frame = [[10,30],[250,20]] if BaseScreen.iphone5
    account.frame = [[10,30],[250,20]] if BaseScreen.iphone6
    account.frame = [[10,30],[250,20]] if BaseScreen.iphone6plus
    account.text = data.account_title
    account.font = "OpenSans-SemiBold".uifont(13)
    account.textColor = "#333".to_color
    account.textAlignment = UITextAlignmentLeft
    account.backgroundColor = UIColor.clearColor

    icon = UILabel.new
    icon.frame = [[265,0],[50,40]] if BaseScreen.iphone4
    icon.frame = [[265,0],[50,40]] if BaseScreen.iphone5
    icon.frame = [[317,0],[50,40]] if BaseScreen.iphone6
    icon.frame = [[357,0],[50,40]] if BaseScreen.iphone6plus
    icon.text = ""
    icon.font = "FontAwesome".uifont(15)
    icon.textColor = "#7db744".to_color
    icon.backgroundColor = UIColor.clearColor

    top = UIView.alloc.initWithFrame([[0, 0],[290, 60]]) if BaseScreen.iphone4
    top = UIView.alloc.initWithFrame([[0, 0],[290, 60]]) if BaseScreen.iphone5
    top = UIView.alloc.initWithFrame([[0, 0],[345, 60]]) if BaseScreen.iphone6
    top = UIView.alloc.initWithFrame([[0, 0],[385, 60]]) if BaseScreen.iphone6plus
    top.backgroundColor = UIColor.whiteColor
    top.addSubview(title)
    top.addSubview(account)
    top.addSubview(icon) if data.activated == 1

    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.backgroundColor = UIColor.clearColor
    cell.addSubview(top)

    cell

  end

  def tableView(tableView, numberOfRowsInSection:section)

    @users.count

  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)

    61

  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    data = @users[indexPath.row]

    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    toggle_selection(data)

    table_data_cache

  end

  def toggle_selection(object)

    if object.activated == 1

      object.activated = 0

    else

      object.activated = 1

    end
    
    cdq.save

  end

  def filter_query

    @users = LedgerUser.sort_by(:fullname, :ascending).sort_by(:status, :ascending)
    @users
    
  end

end