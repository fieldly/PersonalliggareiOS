class LoginLayout < MK::Layout

  include GeneralStyles

  view :scroll
  
  view :textfield_email
  view :textfield_password

  view :button_send

  def layout

    background_color "#dadee7".uicolor

    @scroll = add UIScrollView, :scroll_plain do
      frame [[15,0],[320,440]] if BaseScreen.iphone4
      frame [[15,0],[320,440]] if BaseScreen.iphone5
      frame [[15,0],[345,500]] if BaseScreen.iphone6
      frame [[15,0],[384,500]] if BaseScreen.iphone6plus
      contentSize CGSizeMake(320, 455) if BaseScreen.iphone4
      contentSize CGSizeMake(320, 455) if BaseScreen.iphone5
      contentSize CGSizeMake(345, 500) if BaseScreen.iphone6
      contentSize CGSizeMake(384, 500) if BaseScreen.iphone6plus
      scrollEnabled true

      add UIView, :box do
        frame [[0,15],[290,127]] if BaseScreen.iphone4
        frame [[0,15],[290,127]] if BaseScreen.iphone5
        frame [[0,15],[345,127]] if BaseScreen.iphone6
        frame [[0,15],[384,127]] if BaseScreen.iphone6plus
        add UIView, :box_textfield_top do
          add UILabel, :box_title_label do
            text I18n.t("login.label_email")
          end
        end
        add UIView, :box_textfield_middle do
          @textfield_email = add UITextField, :box_textfield do
            keyboardType UIKeyboardTypeEmailAddress   
            autocapitalizationType UITextAutocapitalizationTypeNone         
          end
        end
        add UIView, :box_textfield_bottom do
          add UILabel, :box_bottom_label do
            text I18n.t("login.label_email_info")
          end
        end
      end

      add UIView, :box do
        frame [[0,152],[290,127]] if BaseScreen.iphone4
        frame [[0,152],[290,127]] if BaseScreen.iphone5
        frame [[0,152],[345,127]] if BaseScreen.iphone6
        frame [[0,152],[384,127]] if BaseScreen.iphone6plus
        add UIView, :box_textfield_top do
          add UILabel, :box_title_label do
            text I18n.t("login.label_password")
          end
        end
        add UIView, :box_textfield_middle do
          @textfield_password = add UITextField, :box_textfield do
            secureTextEntry true
          end
        end
        add UIView, :box_textfield_bottom do
          add UILabel, :box_bottom_label do
            text I18n.t("login.label_password_info")
          end
        end
      end

      @button_send = add UILabel, :button_green do
        frame [[0,289],[290,40]] if BaseScreen.iphone4
        frame [[0,289],[290,40]] if BaseScreen.iphone5
        frame [[0,289],[345,40]] if BaseScreen.iphone6
        frame [[0,289],[384,40]] if BaseScreen.iphone6plus
        text I18n.t("login.button_login")
      end

    end

  end
end