module Elements

  include ProMotion::ScreenModule

  def create_table (hash = {})

    add @table = UITableView.new, stylename: "table", delegate: self, dataSource: self

  end

  def create_table_message (hash = {})

    case hash[:status]
      when "pending" then style = "message_label_pending"
      when "accepted" then style = "message_label_active"
      when "completed" then style = "message_label_completed"
      else style = "message_label"
    end

    add header = UIView.new, stylename: "message_container"
    add_to header, main = UIView.new, stylename: "message"
    add_to main, UIImageView.new, stylename: "message_image"
    add_to main, UILabel.new, stylename: style

    header

  end

  def create_table_header_small (hash = {})

    header = UIView.new
    header.frame = [[0,0],[300,hash[:height] || 15]]
    header

  end

  def create_filter_header (hash = {})

    top = UIView.new
    top.frame = [[0,50],[320,48]] if BaseScreen.iphone4
    top.frame = [[0,50],[320,48]] if BaseScreen.iphone5
    top.frame = [[0,50],[345,48]] if BaseScreen.iphone6
    top.frame = [[0,50],[385,48]] if BaseScreen.iphone6plus

    header = UIView.new
    header.frame = [[0,15],[320,32]] if BaseScreen.iphone4
    header.frame = [[0,15],[320,32]] if BaseScreen.iphone5
    header.frame = [[0,15],[345,32]] if BaseScreen.iphone6
    header.frame = [[0,15],[385,32]] if BaseScreen.iphone6plus
    header.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top_wide.png")) if BaseScreen.iphone6
    header.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top.png")) unless BaseScreen.iphone6
    header

    label = UILabel.new
    label.frame = [[10,0],[250,32]]
    label.text = hash[:text]
    label.textColor = "#333333".uicolor
    label.font = "OpenSans-Bold".uifont(13)

    header.addSubview(label)

    top.addSubview(header)

    top

  end

  def create_table_info_header (hash = {})

    top = UIView.new
    top.frame = [[0,50],[290,68]] if BaseScreen.iphone4
    top.frame = [[0,50],[290,68]] if BaseScreen.iphone5
    top.frame = [[0,50],[345,68]] if BaseScreen.iphone6
    top.frame = [[0,50],[385,68]] if BaseScreen.iphone6plus

    header = UIView.new
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone4
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone5
    header.frame = [[0,15],[345,36]] if BaseScreen.iphone6
    header.frame = [[0,15],[385,36]] if BaseScreen.iphone6plus
    header.backgroundColor = "#ffffff".uicolor
    header.layer.cornerRadius = 3.0

    label = UILabel.new
    label.frame = [[0,0],[290,36]] if BaseScreen.iphone4
    label.frame = [[0,0],[290,36]] if BaseScreen.iphone5
    label.frame = [[0,0],[345,36]] if BaseScreen.iphone6
    label.frame = [[0,0],[385,36]] if BaseScreen.iphone6plus
    label.text = hash[:text] || I18n.t("workorders.label_single_work_orders")
    label.textColor = "#a1acc2".uicolor
    label.font = "OpenSans-Bold".uifont(13)
    label.textAlignment = UITextAlignmentCenter

    header.addSubview(label)

    top.addSubview(header)

    top

  end

  def create_table_search_header (hash = {})

    top = UIView.new
    top.frame = [[0,50],[290,68]] if BaseScreen.iphone4
    top.frame = [[0,50],[290,68]] if BaseScreen.iphone5
    top.frame = [[0,50],[345,68]] if BaseScreen.iphone6
    top.frame = [[0,50],[385,68]] if BaseScreen.iphone6plus

    header = UIView.new
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone4
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone5
    header.frame = [[0,15],[345,36]] if BaseScreen.iphone6
    header.frame = [[0,15],[385,36]] if BaseScreen.iphone6plus
    header.backgroundColor = "#ffffff".uicolor
    header.layer.cornerRadius = 3.0

    @textfield = UITextField.new
    @textfield.font = "OpenSans-Bold".uifont(13)
    @textfield.setPlaceholder(hash[:placeholder])
    @textfield.frame = [[10,0],[270,36]] if BaseScreen.iphone4
    @textfield.frame = [[10,0],[270,36]] if BaseScreen.iphone5
    @textfield.frame = [[10,0],[325,36]] if BaseScreen.iphone6
    @textfield.frame = [[10,0],[365,36]] if BaseScreen.iphone6plus

    label = UILabel.new
    label.frame = [[267,3],[30,30]] if BaseScreen.iphone4
    label.frame = [[267,3],[30,30]] if BaseScreen.iphone5
    label.frame = [[317,3],[30,30]] if BaseScreen.iphone6
    label.frame = [[367,3],[30,30]] if BaseScreen.iphone6plus
    label.text = ""
    label.textColor = "#a1acc2".uicolor
    label.font = "FontAwesome".uifont(17)

    header.addSubview(@textfield)
    header.addSubview(label)

    @textfield.delegate = self

    top.addSubview(header)

    top

  end

  def create_table_info_and_search_header (hash = {})

    top = UIView.new
    top.frame = [[0,50],[290,116]] if BaseScreen.iphone4
    top.frame = [[0,50],[290,116]] if BaseScreen.iphone5
    top.frame = [[0,50],[345,116]] if BaseScreen.iphone6
    top.frame = [[0,50],[385,116]] if BaseScreen.iphone6plus

    header = UIView.new
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone4
    header.frame = [[0,15],[290,36]] if BaseScreen.iphone5
    header.frame = [[0,15],[345,36]] if BaseScreen.iphone6
    header.frame = [[0,15],[385,36]] if BaseScreen.iphone6plus
    header.backgroundColor = "#ffffff".uicolor
    header.layer.cornerRadius = 3.0

    @textfield = UITextField.new
    @textfield.font = "OpenSans-Bold".uifont(13)
    @textfield.setPlaceholder(hash[:placeholder])
    @textfield.frame = [[10,0],[270,36]] if BaseScreen.iphone4
    @textfield.frame = [[10,0],[270,36]] if BaseScreen.iphone5
    @textfield.frame = [[10,0],[325,36]] if BaseScreen.iphone6
    @textfield.frame = [[10,0],[365,36]] if BaseScreen.iphone6plus

    label = UILabel.new
    label.frame = [[267,3],[30,30]] if BaseScreen.iphone4
    label.frame = [[267,3],[30,30]] if BaseScreen.iphone5
    label.frame = [[317,3],[30,30]] if BaseScreen.iphone6
    label.frame = [[367,3],[30,30]] if BaseScreen.iphone6plus
    label.text = ""
    label.textColor = "#a1acc2".uicolor
    label.font = "FontAwesome".uifont(17)

    header.addSubview(@textfield)
    header.addSubview(label)

    @textfield.delegate = self

    header_2 = UIView.new
    header_2.frame = [[0,65],[290,36]] if BaseScreen.iphone4
    header_2.frame = [[0,65],[290,36]] if BaseScreen.iphone5
    header_2.frame = [[0,65],[345,36]] if BaseScreen.iphone6
    header_2.frame = [[0,65],[385,36]] if BaseScreen.iphone6plus
    header_2.backgroundColor = "#ffffff".uicolor
    header_2.layer.cornerRadius = 3.0

    label = UILabel.new
    label.frame = [[0,0],[290,36]] if BaseScreen.iphone4
    label.frame = [[0,0],[290,36]] if BaseScreen.iphone5
    label.frame = [[0,0],[345,36]] if BaseScreen.iphone6
    label.frame = [[0,0],[385,36]] if BaseScreen.iphone6plus
    label.text = hash[:text] || I18n.t("workorders.label_single_work_orders")
    label.textColor = "#a1acc2".uicolor
    label.font = "OpenSans-Bold".uifont(13)
    label.textAlignment = UITextAlignmentCenter

    header_2.addSubview(label)

    top.addSubview(header)
    top.addSubview(header_2)

    top

  end

  def create_filter_footer (hash = {})

    footer = UIView.new
    footer.frame = [[0,0],[300,32]]
    footer.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom_wide.png")) if BaseScreen.iphone6
    footer.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom.png")) unless BaseScreen.iphone6
    
    label = UILabel.new
    label.frame = [[10,0],[250,32]]
    label.text = hash[:text]
    label.textColor = "#a1acc2".uicolor
    label.font = "OpenSans-SemiBold".uifont(13)

    footer.addSubview(label)

    footer

  end

  def create_table_header_none (hash = {})

    header = UIView.new
    header.frame = [[0,0],[300,1]]
    header

  end

  def create_nav_button_plain (hash = {})

    button = UIButton.buttonWithType(UIButtonTypeCustom)
    button.frame = [[0, 0], [30,30]]
    button.setTitle(hash[:label], forState: UIControlStateNormal)
    button.setTitleColor(hash[:color] || "#7daee6".to_color, forState:UIControlStateNormal)
    button.font = "FontAwesome".uifont(hash[:size] || 20)
    button.addTarget(self, action: hash[:action] || 'open', forControlEvents: UIControlEventTouchUpInside)

    if (hash[:position] == 'right')

      if Device.ios_version.to_f >= 7.0

        button.setTitleEdgeInsets(UIEdgeInsetsMake(0.0, 0.0, -2.0, hash[:padding_right] || -6.0))

      else

        button.setTitleEdgeInsets(UIEdgeInsetsMake(0.0, 0.0, -5.0, hash[:padding_right] || 6.0))

      end

      button.setContentHorizontalAlignment(UIControlContentHorizontalAlignmentRight)

      self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(button)

    else

      if Device.ios_version.to_f >= 7.0

        button.setTitleEdgeInsets(UIEdgeInsetsMake(0.0, hash[:padding_left] || -8.0, -2.0, 0.0))

      else

        button.setTitleEdgeInsets(UIEdgeInsetsMake(0.0, hash[:padding_left] || 0.0, -5.0, 0.0))

      end

      button.setContentHorizontalAlignment(UIControlContentHorizontalAlignmentLeft)

      self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithCustomView(button)

    end

  end

  def create_refresh (hash = {})

    @table.addPullToRefreshWithActionHandler(
      Proc.new do
        table_data hash[:message] if hash[:message]
        table_data unless hash[:message]
      end
    )

    if hash[:infinite]

      @table.addInfiniteScrollingWithActionHandler(
        Proc.new do
          table_data_append
        end
      )

    end

    @table.pullToRefreshView.arrowColor = "#acb4c6".to_color
    @table.pullToRefreshView.textColor = "#acb4c6".to_color
    @table.pullToRefreshView.setTitle(I18n.t("refresh.pull"), forState: SVPullToRefreshStateStopped)
    @table.pullToRefreshView.setTitle(I18n.t("refresh.release"), forState: SVPullToRefreshStateTriggered)
    @table.pullToRefreshView.setTitle(I18n.t("refresh.fetching"), forState: SVPullToRefreshStateLoading)

  end

  def create_picker (hash = {})

    if hash[:media] == "photo"

      media = UIImagePickerControllerSourceTypeCamera

    else

      media = UIImagePickerControllerSourceTypePhotoLibrary

    end

    @picker = UIImagePickerController.alloc.init
    @picker.sourceType = media
    @picker.mediaTypes = [KUTTypeImage]
    @picker.allowsEditing = true
    @picker.delegate = self

  end

end