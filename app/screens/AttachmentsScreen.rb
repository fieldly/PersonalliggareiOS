class AttachmentsScreen < BaseScreen

  attr_accessor :attachable_id, :attachable_type

  title I18n.t("attachments.heading")

  def on_load

    @attachments ||= []

    create_nav_button_plain :action => 'close_window', :position => 'left', :label => "", :size => 18
    
  end

  def will_appear

    @setup_layout ||= setup_layout
    @setup_observers ||= setup_observers

  end

  def will_dismiss

    App.notification_center.unobserve @update_attachments_observer

  end

  def setup_layout

    @layout = AttachmentsLayout.new(root: self.view).build

    @table = @layout.table
    @table.delegate = self
    @table.dataSource = self

    create_refresh

    table_data_check

  end

  def setup_observers

    @update_attachments_observer = App.notification_center.observe "updateTableAttachments" do |notification|

      table_data_check

    end

  end

  def table_data_check

    data = Attachment.count

    if data > 0

      table_data_cache

    else

      table_data

    end

  end

  def table_data_cache

    @attachments = Attachment.where(attachable_id: @attachable_id).sort_by(:created_at, :descending) 

    if @attachments.count > 0

      @table.tableHeaderView = create_table_info_header text: I18n.t("attachments.label_archive")

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

        Attachment.fetch_content(@attachable_id, @attachable_type, true) do |success, response|

          case success

            when true 

              @attachments = Attachment.where(attachable_id: @attachable_id).sort_by(:created_at, :descending) 

              @table.tableHeaderView = create_table_info_header text: I18n.t("attachments.label_archive")
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

             when false

              @attachments = []

              @table.tableHeaderView = @layout.empty.setHidden(false)
              @table.reloadData
              @table.pullToRefreshView.stopAnimating

              handle_error response

          end

        end

    end

  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)

    data = @attachments[indexPath.row]

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

    icon = UILabel.new
    icon.frame = [[265,0],[50,35]] if BaseScreen.iphone4
    icon.frame = [[265,0],[50,35]] if BaseScreen.iphone5
    icon.frame = [[320,0],[50,35]] if BaseScreen.iphone6
    icon.frame = [[360,0],[50,35]] if BaseScreen.iphone6plus
    icon.text = ""
    icon.font = "SSSymboliconsLine".uifont(15)
    icon.textColor = "#333333".to_color
    icon.backgroundColor = UIColor.clearColor

    filetype = UILabel.new
    filetype.frame = [[10,0],[250,32]] if BaseScreen.iphone4
    filetype.frame = [[10,0],[250,32]] if BaseScreen.iphone5
    filetype.frame = [[10,0],[250,32]] if BaseScreen.iphone6
    filetype.frame = [[10,0],[250,32]] if BaseScreen.iphone6plus
    filetype.text = set_value(data.filetype)
    filetype.font = "OpenSans-Semibold".uifont(13)
    filetype.textColor = "#a1acc2".to_color
    filetype.textAlignment = UITextAlignmentLeft
    filetype.backgroundColor = UIColor.clearColor

    top = UIView.alloc.initWithFrame([[0, 0],[290, 32]]) if BaseScreen.iphone4
    top = UIView.alloc.initWithFrame([[0, 0],[290, 32]]) if BaseScreen.iphone5
    top = UIView.alloc.initWithFrame([[0, 0],[345, 32]]) if BaseScreen.iphone6
    top = UIView.alloc.initWithFrame([[0, 0],[385, 32]]) if BaseScreen.iphone6plus
    top.backgroundColor = rounded_top
    top.addSubview(title)
    top.addSubview(icon)

    bottom = UIView.alloc.initWithFrame([[0, 32],[290, 32]]) if BaseScreen.iphone4
    bottom = UIView.alloc.initWithFrame([[0, 32],[290, 32]]) if BaseScreen.iphone5
    bottom = UIView.alloc.initWithFrame([[0, 32],[345, 32]]) if BaseScreen.iphone6
    bottom = UIView.alloc.initWithFrame([[0, 32],[385, 32]]) if BaseScreen.iphone6plus
    bottom.backgroundColor = rounded_bottom
    bottom.addSubview(filetype)

    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell.backgroundColor = UIColor.clearColor
    cell.addSubview(top)
    cell.addSubview(bottom)

    cell

  end

  def tableView(tableView, numberOfRowsInSection:section)

    @attachments.count

  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)

    80

  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)

    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    open AttachmentsShowScreen.new url: @attachments[indexPath.row].fileurl, scale_to_fit: true

  end

  def close_window
    
    close do_nothing: true

  end

end