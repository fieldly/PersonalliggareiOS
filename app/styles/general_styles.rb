module GeneralStyles

  def box_top_style
    top 15
    left 15
    width '100%'
    height 20
    background_color "#FFFFFF".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def box_middle_style
    top 15
    left 15
    width '100%'
    height 100
    background_color "#FFFFFF".uicolor
  end

  def box_bottom_style
    top 77
    left 15
    width '100%'
    height 32
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom.png")) unless BaseScreen.iphone6
  end
  
  def box_single_line_style
    left 15
    width '100%'
    height 32
    background_color "#ffffff".uicolor
  end

  def box_double_line_style
    left 15
    width '100%'
    height 55
    background_color "#ffffff".uicolor
  end

  def box_line_1_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(12)
    size_to_fit
    top 8
    width '100%'
  end

  def box_line_2_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Semibold".uifont(12)
    size_to_fit
    top 25
    width '100%'
  end

  def box_line_3_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(12)
    size_to_fit
    top 14
    width '100%'
  end

  def box_icons_style
    top 48
    left 15
    width '100%'
    height 85
    background_color "#FFFFFF".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def box_icon_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "SSSymboliconsLine".uifont(30)
    size_to_fit
  end

  def box_icon_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Semibold".uifont(10)
    size_to_fit
  end

  def box_bottom_label_style
    text "Position"
    text_color "#a1acc2".uicolor
    font "OpenSans-Semibold".uifont(13)
    size_to_fit
    top 7
    left 10
    width '100%'
  end

  def box_textfield_top_style
    top 0
    left 0
    width '100%'
    height 32
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top.png")) unless BaseScreen.iphone6
  end

  def box_textfield_middle_style
    top 33
    height 55
    width '100%'
    background_color "#ffffff".uicolor
  end

  def box_textfield_bottom_style
    top 87
    width '100%'
    height 32
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom.png")) unless BaseScreen.iphone6
  end

  def box_buttons_style
    top 15
    left 15
    height 130
    width '100%'
    background_color "#dadee7".uicolor
  end

  def button_grey_style
    text_color "#ffffff".uicolor
    font "OpenSans-Bold".uifont(13)
    background_color "#666666".uicolor
    text_alignment UITextAlignmentCenter
    clipsToBounds true
    layer do
      corner_radius 3.0
    end
  end

  def button_green_style
    text_color "#ffffff".uicolor
    font "OpenSans-Bold".uifont(13)
    background_color "#7db744".uicolor
    text_alignment UITextAlignmentCenter
    clipsToBounds true
    layer do
      corner_radius 3.0
    end
  end

  def button_red_style
    text_color "#ffffff".uicolor
    font "OpenSans-Bold".uifont(13)
    background_color "#E74C42".uicolor
    text_alignment UITextAlignmentCenter
    clipsToBounds true
    layer do
      corner_radius 3.0
    end
  end

  def empty_style
    hidden true
  end

  def empty_background_style
    background_color "#ffffff".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def empty_image_style
    image "body/man_show.png".uiimage
  end

  def empty_label_style
    text "empty"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Semibold".uifont(15)
    size_to_fit
    number_of_lines 0
    top 300
    width "100%"
    height 50
  end

end