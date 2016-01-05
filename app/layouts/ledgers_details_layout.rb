class LedgersDetailsLayout < MK::Layout

  include GeneralStyles
  
  view :line_1
  view :line_2
  view :line_3
  
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
        @line_1 = add UILabel, :box_line_1_label do
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
      frame [[0,120],[290,340]] if BaseScreen.iphone4
      frame [[0,120],[290,340]] if BaseScreen.iphone5
      frame [[0,120],[345,340]] if BaseScreen.iphone6
      frame [[0,120],[385,340]] if BaseScreen.iphone6plus
      add UIView, :box_icons do
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
          text I18n.t("ledgers.label_authority").upcase
        end
        add UILabel, :box_icon_label do
          frame [[97,44],[97,40]] if BaseScreen.iphone4
          frame [[97,44],[97,40]] if BaseScreen.iphone5
          frame [[115,44],[115,40]] if BaseScreen.iphone6
          frame [[135,44],[125,40]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_emergency").upcase
        end
        add UILabel, :box_icon_label do
          frame [[194,44],[97,40]] if BaseScreen.iphone4
          frame [[194,44],[97,40]] if BaseScreen.iphone5
          frame [[230,44],[115,40]] if BaseScreen.iphone6
          frame [[260,44],[125,40]] if BaseScreen.iphone6plus
          text I18n.t("ledgers.label_attachments").upcase
        end
      end
      @bottom_box = add UIView, :box_bottom do
        frame [[15,130],[290,32]] if BaseScreen.iphone4
        frame [[15,130],[290,32]] if BaseScreen.iphone5
        frame [[15,130],[345,32]] if BaseScreen.iphone6
        frame [[15,130],[385,32]] if BaseScreen.iphone6plus
        add UILabel, :box_bottom_label do
          text I18n.t("ledgers.label_actions")
        end
      end
    end

    @date = add UIView, :box do
      frame [[0,435],[320,95]] if BaseScreen.iphone4
      frame [[0,337],[320,95]] if BaseScreen.iphone5
      frame [[0,435],[380,95]] if BaseScreen.iphone6
      frame [[0,618],[380,95]] if BaseScreen.iphone6plus
      add UIView, :box_top
      add UIView, :box_single_line do
        frame [[15,20],[290,45]] if BaseScreen.iphone4
        frame [[15,20],[290,45]] if BaseScreen.iphone5
        frame [[15,20],[345,45]] if BaseScreen.iphone6
        frame [[15,20],[385,45]] if BaseScreen.iphone6plus
        @line_4 = add UILabel, :box_line_3_label do
          text "Construction Curt Inc"
        end
      end
      @bottom_box = add UIView, :box_bottom do
        frame [[15,65],[290,32]] if BaseScreen.iphone4
        frame [[15,65],[290,32]] if BaseScreen.iphone5
        frame [[15,65],[345,32]] if BaseScreen.iphone6
        frame [[15,65],[385,32]] if BaseScreen.iphone6plus
        add UILabel, :box_bottom_label do
          text I18n.t("ledgers.label_timestamp")
        end
      end
      hidden true
    end

    @buttons = add UIView, :box_buttons do
      frame [[0,360],[320,55]] if BaseScreen.iphone4
      frame [[0,450],[320,55]] if BaseScreen.iphone5
      frame [[0,549],[380,55]] if BaseScreen.iphone6
      frame [[0,618],[380,55]] if BaseScreen.iphone6plus
      @button_checkin = add UILabel, :button_green do
        frame [[15,0],[290,40]] if BaseScreen.iphone4
        frame [[15,0],[290,40]] if BaseScreen.iphone5
        frame [[15,0],[345,40]] if BaseScreen.iphone6
        frame [[15,0],[385,40]] if BaseScreen.iphone6plus
        text I18n.t("ledgers.label_checkin").upcase
      end
      @button_checkout = add UILabel, :button_red do
        frame [[15,0],[290,40]] if BaseScreen.iphone4
        frame [[15,0],[290,40]] if BaseScreen.iphone5
        frame [[15,0],[345,40]] if BaseScreen.iphone6
        frame [[15,0],[385,40]] if BaseScreen.iphone6plus
        text I18n.t("ledgers.label_checkout").upcase
        hidden true
      end
    end

  end

end