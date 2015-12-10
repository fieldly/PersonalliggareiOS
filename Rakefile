# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'Personalliggare'
  app.version = "1.0.0"
  app.short_version = "1.0.0"
  app.deployment_target = '7.0'
  app.device_family = [:iphone]
  app.icons = Dir.glob("resources/Icon*.png").map{|icon| icon.split("/").last}
  app.prerendered_icon = true
  app.interface_orientations = [:portrait]
  app.libs += ['/usr/lib/libz.dylib', '/usr/lib/libsqlite3.dylib', '/usr/lib/libiconv.dylib']
  app.fonts = ["fonts/fontawesome-webfont.ttf", "fonts/ss-pika.ttf", "fonts/ss-symbolicons-line.ttf", "fonts/OpenSans-Regular.ttf", "fonts/OpenSans-Semibold.ttf", "fonts/OpenSans-Bold.ttf"]

  app.development do

    app.entitlements['get-task-allow'] = true
    app.identifier = 'com.fieldly.app'
    app.provisioning_profile = '/Users/danielkrusenstrahle/Documents/certs/fieldly/development/FieldlyDeveloper.mobileprovision'
    app.codesign_certificate = 'iPhone Developer: Daniel Krusenstraehle (97E74V8P2W)'
    app.entitlements['aps-environment'] = 'development'
    app.info_plist['CFBundleURLTypes'] = [{'CFBundleURLName' => 'com.fieldly.app', 'CFBundleURLSchemes' => ['fieldly'] }]

  end

  app.release do

    app.entitlements['get-task-allow'] = false
    app.identifier = 'com.fieldly.prod'
    app.provisioning_profile = '/Users/danielkrusenstrahle/Documents/certs/fieldly/production/FieldlyProduction.mobileprovision'
    app.codesign_certificate = 'iPhone Distribution: Daniel Krusenstraehle (N2TXAFJTQC)'
    app.entitlements['aps-environment'] = 'production'
    app.info_plist['CFBundleURLTypes'] = [{'CFBundleURLName' => 'com.fieldly.prod', 'CFBundleURLSchemes' => ['fieldly'] }]

  end
  app.info_plist['UIStatusBarStyle'] = "UIStatusBarStyleLightContent"
  app.info_plist['UIViewControllerBasedStatusBarAppearance'] = false
  app.info_plist['NSLocationAlwaysUsageDescription'] = 'To save location information'
  app.info_plist['NSLocationWhenInUseUsageDescription'] = 'To save location information'
  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }

  app.frameworks += [
    'AVFoundation',
    'CoreMedia',
    'CoreVideo',
    'Security', 
    'CFNetwork', 
    'MobileCoreServices', 
    'SystemConfiguration', 
    'CoreTelephony', 
    'StoreKit', 
    'CoreLocation', 
    'AudioToolbox', 
    'MapKit',
    'QuartzCore',
    'MessageUI'
  ]

  app.pods do
    pod 'SVPullToRefresh'
    pod 'Reachability'
    pod 'NSData+MD5Digest'
    pod 'JMImageCache'
  end
end

task :"build:simulator" => :"schema:build"

desc "Build to phone"
task :device do
    exec 'bundle exec rake device'
end

desc "Run simulator on iPhone"
task :iphone4 do
    exec 'bundle exec rake device_name="iPhone 4s"'
end

desc "Run simulator on iPhone"
task :iphone5 do
    exec 'bundle exec rake device_name="iPhone 5"'
end

desc "Run simulator on iPhone"
task :iphone6 do
    exec 'bundle exec rake device_name="iPhone 6"'
end

desc "Run simulator on iPhonePlus"
task :iphone6plus do
    exec 'bundle exec rake device_name="iPhone 6 Plus"'
end

desc "Run simulator in iPad Retina" 
task :retina do
    exec 'bundle exec rake device_name="iPad Retina"'
end

desc "Run simulator on iPad Air" 
task :ipad do
    exec 'bundle exec rake device_name="iPad Air"'
end