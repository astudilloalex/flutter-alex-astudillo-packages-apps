import Flutter
import UIKit
import Foundation

public class TimeConfigCheckerIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "time_config_checker_ios", binaryMessenger: registrar.messenger())
    let instance = TimeConfigCheckerIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getTimeConfig":
      result(getTimeConfig())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getTimeConfig() -> [String: Bool] {
    let isAutomaticTime = isTimeAutomatic()
    let isAutomaticTimeZone = isTimeZoneAutomatic()
    
    return [
        "isAutomaticTime": isAutomaticTime,
        "isAutomaticTimeZone": isAutomaticTimeZone
    ]
  }

  // There is no direct API, but we can infer the configuration.
  private func isTimeAutomatic() -> Bool {
    // We check if the device has auto-update restriction disabled.
    if let autoTimeEnabled = UserDefaults.standard.object(forKey: "time_auto_setting") as? Bool {
        return autoTimeEnabled
    }
    // We can't get this setting directly, so we assume true.
    return true
  }
  
  private func isTimeZoneAutomatic() -> Bool {
    let timeZoneSettings = CFPreferencesCopyAppValue("TimeZone" as CFString, "com.apple.preferences.datetime" as CFString)
    if let settings = timeZoneSettings as? [String: Any],
       let automaticTimeZone = settings["AutomaticTimeZone"] as? Bool {
        return automaticTimeZone
    }
    return true
  }
}
