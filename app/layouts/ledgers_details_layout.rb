class LedgersDetailsLayout < MK::Layout

  include GeneralStyles
  
  view :line_1
  view :line_2
  view :line_3
  view :line_4
  
  view :icon_authority
  view :icon_emergency
  view :icon_attachments

  view :date

  view :buttons
  view :button_checkin
  view :button_checkout

  def layout

    background_color "#dadee7".uicolor

    add UIView, :box do
      frame [[0,0],[290,150]] if BaseScreen.iphone4
      frame [[0,0],[290,150]] if BaseScreen.iphone5
      frame [[0,0],[345,150]] if BaseScreen.iphone6
      frame [[0,0],[385,150]] if BaseScreen.iphone6plus
      add UIView, :box_top
      @title = add UIView, :box_double_line do
        frame [[15,20],[290,55]] if BaseScreen.iphone4
        frame [[15,20],[290,55]] if BaseScreen.iphone5
        frame [[15,20],[345,55]] if BaseScreen.iphone6
        frame [[15,20],[385,55]] if BaseScreen.iphone6plus
        @line_1 = add UILabel, :box_line_1_top_label do
          text "Construction Curt Inc"
        end
      end
      @location = add UIView, :box_single_line do
        frame [[15,76],[290,45]] if BaseScreen.iphone4
        frame [[15,76],[290,45]] if BaseScreen.iphone5
        frame [[15,76],[345,45]] if BaseScreen.iphone6
        frame [[15,76],[385,45]] if BaseScreen.iphone6plus
        @line_2 = add UILabel, :box_line_3_label do
          text "Construction Curt Inc"
        end
      end
      @bottom_box = add UIView, :box_bottom do
        frame [[15,120],[290,32]] if BaseScreen.iphone4
        frame [[15,120],[290,32]] if BaseScreen.iphone5
        frame [[15,120],[345,32]] if BaseScreen.iphone6
        frame [[15,120],[385,32]] if BaseScreen.iphone6plus
        add UILabel, :box_bottom_label do
          text I18n.t("ledgers.label_worksite")
        end
      end
    end

    add UIView, :box do
      frame [[0,120],[290,350]] if BaseScreen.iphone4
      frame [[0,120],[290,350]] if BaseScreen.iphone5
      frame [[0,120],[345,350]] if BaseScreen.iphone6
      frame [[0,120],[385,350]] if BaseScreen.iphone6plus
      add UIView, :box_icons_rounded do
        @icon_authority = add UILabel, :box_icon do
          frame [[0,15],[97,40]] if BaseScreen.iphone4
          frame [[0,15],[97,40]] if BaseScreen.iphone5
          frame [[0,15],[115,40]] if BaseScreen.iphone6
          frame [[0,15],[125,40]] if BaseScreen.iphone6plus
          text "🔒"
        end
        @icon_emergency = add UILabel, :box_icon do
          frame [[97,15],[97,40]] if BaseScreen.iphone4
          frame [[97,15],[97,40]] if BaseScreen.iphone5
          frame [[115,15],[115,40]] if BaseScreen.iphone6
          frame [[135,15],[125,40]] if BaseScreen.iphone6plus
          text ""
        end
        @icon_attachments = add UILabel, :box_icon do
          frame [[194,15],[97,40]] if BaseScreen.iphone4
          frame [[194,15],[97,40]] if BaseScreen.iphone5
          frame [[230,15],[115,40]] if BaseScreen.iphone6
          frame [[260,15],[125,40]] if BaseScreen.iphone6plus
          text ""
        end
        @serial_number = add UILabel, :box_icon_label do
          frame [[0,44],[97,40]] if BaseScreen.iphone4
          frame [[0,44],[97,40]] if BaseScreen.iphone5
          frame [[0,44],[115,40]] if BaseScreen.iphone6
          frame [[0,44],[125,40]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_authority")
        end
        add UILabel, :box_icon_label do
          frame [[97,44],[97,40]] if BaseScreen.iphone4
          frame [[97,44],[97,40]] if BaseScreen.iphone5
          frame [[115,44],[115,40]] if BaseScreen.iphone6
          frame [[135,44],[125,40]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_emergency")
        end
        add UILabel, :box_icon_label do
          frame [[194,44],[97,40]] if BaseScreen.iphone4
          frame [[194,44],[97,40]] if BaseScreen.iphone5
          frame [[230,44],[115,40]] if BaseScreen.iphone6
          frame [[260,44],[125,40]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_attachments")
        end
      end
      @bottom_box = add UIView, :box_bottom do
        frame [[15,135],[290,32]] if BaseScreen.iphone4
        frame [[15,135],[290,32]] if BaseScreen.iphone5
        frame [[15,135],[345,32]] if BaseScreen.iphone6
        frame [[15,135],[385,32]] if BaseScreen.iphone6plus
        add UILabel, :box_bottom_label do
          text I18n.t("ledgers.label_actions")
        end
      end
    end

    @buttons = add UIView, :box_buttons do
      frame [[0,302],[320,55]] if BaseScreen.iphone4
      frame [[0,302],[320,55]] if BaseScreen.iphone5
      frame [[0,302],[380,55]] if BaseScreen.iphone6
      frame [[0,302],[380,55]] if BaseScreen.iphone6plus
      @button_checkin = add UILabel, :button_green do
        frame [[15,0],[290,40]] if BaseScreen.iphone4
        frame [[15,0],[290,40]] if BaseScreen.iphone5
        frame [[15,0],[345,40]] if BaseScreen.iphone6
        frame [[15,0],[385,40]] if BaseScreen.iphone6plus
        text I18n.t("ledgers.label_checkin").upcase
        hidden true
      end
      @button_checkout = add UIView, :button_big_red do
        frame [[15,0],[290,50]] if BaseScreen.iphone4
        frame [[15,0],[290,50]] if BaseScreen.iphone5
        frame [[15,0],[345,50]] if BaseScreen.iphone6
        frame [[15,0],[385,50]] if BaseScreen.iphone6plus
        add UILabel, :button_big_heading_red do
          frame [[0,10],[290,15]] if BaseScreen.iphone4
          frame [[0,10],[290,15]] if BaseScreen.iphone5
          frame [[0,10],[345,15]] if BaseScreen.iphone6
          frame [[0,10],[385,15]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_checkout") 
        end
        add UILabel, :button_big_subheading_red do
          frame [[0,25],[290,15]] if BaseScreen.iphone4
          frame [[0,25],[290,15]] if BaseScreen.iphone5
          frame [[0,25],[345,15]] if BaseScreen.iphone6
          frame [[0,25],[385,15]] if BaseScreen.iphone6plus
          @line_4 = text I18n.t("timereports.label_calculating")
        end
        hidden true
      end
    end

  end

end