class AuthorityLayout < MK::Layout

  include GeneralStyles

  view :scroll
  
  view :textfield
  view :textfield_email

  view :info

  view :code
  view :code_container

  view :button_fetch

  def layout

    background_color "#dadee7".uicolor

    @scroll = add UIScrollView, :scroll_plain do
      frame [[15,0],[320,440]] if BaseScreen.iphone4
      frame [[15,0],[320,440]] if BaseScreen.iphone5
      frame [[15,0],[345,500]] if BaseScreen.iphone6
      frame [[15,0],[384,500]] if BaseScreen.iphone6plus
      contentSize CGSizeMake(320, 440) if BaseScreen.iphone4
      contentSize CGSizeMake(320, 440) if BaseScreen.iphone5
      contentSize CGSizeMake(345, 500) if BaseScreen.iphone6
      contentSize CGSizeMake(384, 500) if BaseScreen.iphone6plus
      scrollEnabled true

      add UIView, :box do
        frame [[0,15],[290,90]] if BaseScreen.iphone4
        frame [[0,15],[290,90]] if BaseScreen.iphone5
        frame [[0,15],[345,90]] if BaseScreen.iphone6
        frame [[0,15],[384,90]] if BaseScreen.iphone6plus
        add UIView, :box_textfield_top_condensed
        add UIView, :box_textfield_middle_condensed do
          @textfield_email = add UITextField, :box_textfield_no_top do
            keyboardType UIKeyboardTypeEmailAddress   
            autocapitalizationType UITextAutocapitalizationTypeNone         
          end
        end
        add UIView, :box_textfield_bottom_condensed do
          add UILabel, :box_bottom_label do
            text I18n.t("ledgers.label_email")
          end
        end
      end

      add UIView, :box do
        frame [[0,111],[290,90]] if BaseScreen.iphone4
        frame [[0,111],[290,90]] if BaseScreen.iphone5
        frame [[0,111],[345,90]] if BaseScreen.iphone6
        frame [[0,111],[384,90]] if BaseScreen.iphone6plus
        add UIView, :box_textfield_top_condensed
        add UIView, :box_textfield_middle_condensed do
          @textfield = add UITextField, :box_textfield_no_top do
            keyboardType UIKeyboardTypeEmailAddress   
            autocapitalizationType UITextAutocapitalizationTypeNone         
          end
        end
        add UIView, :box_textfield_bottom_condensed do
          add UILabel, :box_bottom_label do
            text I18n.t("ledgers.label_site_number")
          end
        end
      end

      @info = add UIView, :box do
        frame [[0,207],[290,90]] if BaseScreen.iphone4
        frame [[0,207],[290,90]] if BaseScreen.iphone5
        frame [[0,207],[345,90]] if BaseScreen.iphone6
        frame [[0,207],[384,90]] if BaseScreen.iphone6plus
        add UIView, :box_info do
          add UILabel, :box_info_label do
            text I18n.t("ledgers.label_info")
          end
        end
      end

      @code_container = add UIView, :box do
        frame [[0,207],[290,70]] if BaseScreen.iphone4
        frame [[0,207],[290,70]] if BaseScreen.iphone5
        frame [[0,207],[345,70]] if BaseScreen.iphone6
        frame [[0,207],[384,70]] if BaseScreen.iphone6plus
        add UIView, :box_info_centered do
          frame [[0,0],[290,70]] if BaseScreen.iphone4
          frame [[0,0],[290,70]] if BaseScreen.iphone5
          frame [[0,0],[345,70]] if BaseScreen.iphone6
          frame [[0,0],[384,70]] if BaseScreen.iphone6plus
          @code = add UILabel, :box_info_centered_label do
            text "0"
          end
        end
        add UIView, :box_info_normal do
          frame [[0,71],[290,105]] if BaseScreen.iphone4
          frame [[0,71],[290,105]] if BaseScreen.iphone5
          frame [[0,71],[345,90]] if BaseScreen.iphone6
          frame [[0,71],[384,90]] if BaseScreen.iphone6plus
          add UILabel, :box_info_3_lines_label do
            text I18n.t("ledgers.label_code_info")
          end
        end
        add UIView, :box_bottom do
          frame [[0,176],[290,32]] if BaseScreen.iphone4
          frame [[0,176],[290,32]] if BaseScreen.iphone5
          frame [[0,161],[345,32]] if BaseScreen.iphone6
          frame [[0,161],[485,32]] if BaseScreen.iphone6plus
          add UILabel, :box_bottom_label do
            text I18n.t("ledgers.label_code")
          end
        end
        hidden true
      end

      @button_fetch = add UILabel, :button_green do
        frame [[0,333],[290,40]] if BaseScreen.iphone4
        frame [[0,333],[290,40]] if BaseScreen.iphone5
        frame [[0,313],[345,40]] if BaseScreen.iphone6
        frame [[0,313],[384,40]] if BaseScreen.iphone6plus
        text I18n.t("ledgers.button_fetch")
      end

    end

  end
end