class AppDelegate < PM::Delegate
  
  include CDQ

  status_bar true, animation: :fade

  def on_load(app, options)
    
    cdq.setup

    style_navbar

    UIApplication.sharedApplication.setStatusBarStyle(UIStatusBarStyleLightContent)

    open LedgersScreen.new(nav_bar: true)

  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)

    # No notifications

  end

  def style_navbar

    UINavigationBar.appearance.setBackgroundImage("navbar/background_navbar_7.png".uiimage, forBarMetrics:UIBarMetricsDefault) if Device.ios_version.to_f >= 7.0
    UINavigationBar.appearance.setBackgroundImage("navbar/background_navbar.png".uiimage, forBarMetrics:UIBarMetricsDefault) unless Device.ios_version.to_f >= 7.0
    UINavigationBar.appearance.setTitleTextAttributes({UITextAttributeFont => "OpenSans-Semibold".uifont(18), UITextAttributeTextColor => "#7daee6".uicolor, UITextAttributeTextShadowColor => "#7daee6".uicolor})
    UINavigationBar.appearance.setTitleVerticalPositionAdjustment(-0.5, forBarMetrics:UIBarMetricsDefault)
    UINavigationBar.appearance.setShadowImage(UIImage.alloc.init)

  end
  
end