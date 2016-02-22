module GeneralStyles

  def box_info_style
    width 345 if BaseScreen.iphone6
    width 290 unless BaseScreen.iphone6
    height 90 if BaseScreen.iphone6
    height 110 unless BaseScreen.iphone6
    background_color "#FFFFFF".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def box_info_label_style
    text "empty"
    text_color "#333333".uicolor
    font "OpenSans-Semibold".uifont(13)
    size_to_fit
    number_of_lines 0
    top 0
    left 10
    width 335 if BaseScreen.iphone6
    width 280 unless BaseScreen.iphone6
    height 90 if BaseScreen.iphone6
    height 110 unless BaseScreen.iphone6
  end

  def box_info_3_lines_label_style
    text "empty"
    text_color "#333333".uicolor
    font "OpenSans-Semibold".uifont(13)
    size_to_fit
    number_of_lines 0
    top 0
    left 10
    width 325 if BaseScreen.iphone6
    width 270 unless BaseScreen.iphone6
    height 75 if BaseScreen.iphone6
    height 95 unless BaseScreen.iphone6
  end

  def box_info_centered_style
    width 345 if BaseScreen.iphone6
    width 320 unless BaseScreen.iphone6
    height 90
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top.png")) unless BaseScreen.iphone6
  end

  def box_info_centered_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(20)
    size_to_fit
    top 30
    width '100%'
  end

  def box_info_normal_style
    width 345 if BaseScreen.iphone6
    width 320 unless BaseScreen.iphone6
    height 90
    background_color "#FFFFFF".uicolor
  end

  def box_top_style
    top 15
    left 15
    width 345 if BaseScreen.iphone6
    width 290 unless BaseScreen.iphone6
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

  def box_line_1_top_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(13)
    size_to_fit
    top 17
    width '100%'
  end

  def box_line_1_label_style
    text "Position"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(12)
    size_to_fit
    top 17
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
    font "OpenSans-Semibold".uifont(12)
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
    font "OpenSans-Semibold".uifont(12)
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

  def box_icons_rounded_style
    top 48
    left 15
    width '100%'
    height 95
    background_color "#FFFFFF".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def box_title_style
    top 15
    left 15
    width '100%'
    height 32
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_top.png")) unless BaseScreen.iphone6
  end

  def box_title_label_style
    text "Position"
    text_color "#333333".uicolor
    font "OpenSans-Bold".uifont(13)
    size_to_fit
    top 7
    left 10
    width 270 if BaseScreen.iphone6
    width 222 unless BaseScreen.iphone6
  end

  def box_placeholder_label_style
    text "ss"
    text_color "#cccccc".uicolor
    text_alignment UITextAlignmentCenter
    font "OpenSans-Bold".uifont(13)
    size_to_fit
    top 17
    left 0
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

  def box_textfield_top_condensed_style
    top 0
    width 345 if BaseScreen.iphone6
    width 290 unless BaseScreen.iphone6
    height 10
    background_color "#FFFFFF".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def box_textfield_no_top_style
    background_color "#ffffff".uicolor
    font "OpenSans-Semibold".uifont(13)
    width 325 if BaseScreen.iphone6
    width 250 unless BaseScreen.iphone6
    top 0
    left 10
    height 35
  end

  def box_textfield_middle_condensed_style
    top 8
    height 40
    width '100%'
    background_color "#ffffff".uicolor
  end

  def box_textfield_bottom_condensed_style
    top 48
    width '100%'
    height 32
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom_wide.png")) if BaseScreen.iphone6
    background_color UIColor.colorWithPatternImage(UIImage.imageNamed("body/background_round_bottom.png")) unless BaseScreen.iphone6
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

  def box_textfield_style
    background_color "#ffffff".uicolor
    font "OpenSans-Semibold".uifont(13)
    width 325 if BaseScreen.iphone6
    width 250 unless BaseScreen.iphone6
    top 10
    left 10
    height 35
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

  def button_big_red_style
    background_color "#E74C42".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def button_big_heading_red_style
    text_color "#ffffff".uicolor
    font "OpenSans-Bold".uifont(13)
    text_alignment UITextAlignmentCenter
  end

  def button_big_subheading_red_style
    text_color "#ffbcb8".uicolor
    font "OpenSans-Bold".uifont(12)
    text_alignment UITextAlignmentCenter
  end

  def scroll_top_style
    background_color "#FFFFFF".uicolor
    scrollEnabled true
    layer do
      corner_radius 3.0
    end
  end

  def scroll_top_label_style
    top 10
    left 10
    right 10
    width 260
    text "Position"
    text_color "#000000".uicolor
    text_alignment UITextAlignmentLeft
    font UIFont.systemFontOfSize(13)
  end

  def scroll_bottom_label_style
    text "Position"
    text_color "#a1acc2".uicolor
    font UIFont.boldSystemFontOfSize(13)
    size_to_fit
    top 8
    left 15
    width 250
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

  def message_style
    hidden false
  end

  def message_background_style
    background_color "#ffffff".uicolor
    layer do
      corner_radius 3.0
    end
  end

  def message_image_style
    image "body/man_thumbs.png".uiimage
  end

  def message_label_style
    text "empty"
    text_color "#333333".uicolor
    text_alignment UITextAlignmentCenter
    font UIFont.boldSystemFontOfSize(14)
    size_to_fit
    number_of_lines 0
    top 310
    width 345 if BaseScreen.iphone6
    width 280 unless BaseScreen.iphone6
  end

end