class AttachmentsLayout < MK::Layout

  include GeneralStyles
  
  view :table

  view :empty

  def layout

    background_color "#dadee7".uicolor

    @table = add UITableView.alloc.initWithFrame(self.view.bounds), :table

    @empty = add UIView, :empty do
      frame [[0,0],[290,387]] if BaseScreen.iphone4
      frame [[0,0],[290,474]] if BaseScreen.iphone5
      frame [[0,0],[435,550]] if BaseScreen.iphone6
      frame [[0,0],[485,642]] if BaseScreen.iphone6plus
      add UIView, :empty_background do
        frame [[0,15],[290,387]] if BaseScreen.iphone4
        frame [[0,15],[290,474]] if BaseScreen.iphone5
        frame [[0,15],[344,573]] if BaseScreen.iphone6
        frame [[0,15],[384,642]] if BaseScreen.iphone6plus
        add UIImageView, :empty_image do
          frame [[70,50],[150,200]] if BaseScreen.iphone4
          frame [[40,50],[200,250]] if BaseScreen.iphone5
          frame [[50,70],[240,300]] if BaseScreen.iphone6
          frame [[50,70],[240,300]] if BaseScreen.iphone6plus
        end
        add UILabel, :empty_label do
          top 250 if BaseScreen.iphone4
          top 300 if BaseScreen.iphone5
          top 370 if BaseScreen.iphone6
          top 370 if BaseScreen.iphone6plus
          text I18n.t("attachments.message_empty")
        end
      end
    end

  end

  def table_style

    frame [[15,0],[290,415]] if BaseScreen.iphone4
    frame [[15,0],[290,505]] if BaseScreen.iphone5
    frame [[15,0],[345,602]] if BaseScreen.iphone6
    frame [[15,0],[385,674]] if BaseScreen.iphone6plus
    background_color UIColor.clearColor
    separatorStyle UITableViewCellSeparatorStyleNone

  end

end