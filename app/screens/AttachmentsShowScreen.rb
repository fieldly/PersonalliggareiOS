class AttachmentsShowScreen < PM::WebScreen

  Notifier = Motion::Blitz
  
  include Elements

  attr_accessor :url, :task

  title I18n.t("attachments.heading_show")

  def content

    NSURL.URLWithString(@url)

  end

  def on_load

    create_nav_button_plain :action => 'close_window', :position => 'left', :label => "", :size => 18

  end

  def load_started

    Notifier.show(I18n.t("loading.fetching"), :gradient)

  end

  def load_finished
    
    Notifier.dismiss

  end

  def load_failed(error)
    
    Notifier.dismiss
    
  end

  def close_window
    
    close do_nothing: true

  end

end