class LoginSetupLocationLayout < MK::Layout

  include GeneralStyles
  
  view :empty

  view :button_activate

  def layout

    background_color "#dadee7".uicolor

    @empty = add UIView, :message do
      frame [[15,0],[290,330]] if BaseScreen.iphone4
      frame [[15,0],[290,420]] if BaseScreen.iphone5
      frame [[15,0],[435,530]] if BaseScreen.iphone6
      frame [[15,0],[435,590]] if BaseScreen.iphone6plus
      add UIView, :message_background do
        frame [[0,15],[290,330]] if BaseScreen.iphone4
        frame [[0,15],[290,420]] if BaseScreen.iphone5
        frame [[0,15],[344,518]] if BaseScreen.iphone6
        frame [[0,15],[384,590]] if BaseScreen.iphone6plus
        add UIImageView, :message_image do
          frame [[70,50],[150,200]] if BaseScreen.iphone4
          frame [[40,50],[200,250]] if BaseScreen.iphone5
          frame [[50,70],[240,300]] if BaseScreen.iphone6
          frame [[80,70],[240,300]] if BaseScreen.iphone6plus
        end
        add UILabel, :message_label do
          top 255 if BaseScreen.iphone4
          top 305 if BaseScreen.iphone5
          top 375 if BaseScreen.iphone6
          top 375 if BaseScreen.iphone6plus
          text I18n.t("login_setup.message_location")
        end
      end
    end

    @buttons = add UIView, :box_buttons do
      frame [[0,360],[320,55]] if BaseScreen.iphone4
      frame [[0,450],[320,55]] if BaseScreen.iphone5
      frame [[0,549],[380,55]] if BaseScreen.iphone6
      frame [[0,620],[420,55]] if BaseScreen.iphone6plus
      @button_activate = add UILabel, :button_green do
        frame [[15,0],[290,40]] if BaseScreen.iphone4
        frame [[15,0],[290,40]] if BaseScreen.iphone5
        frame [[15,0],[345,40]] if BaseScreen.iphone6
        frame [[15,0],[384,40]] if BaseScreen.iphone6plus
        text I18n.t("login_setup.button_activate_location").upcase
      end
    end

  end

end