import Cocoa
import FlutterMacOS

public class NetworkDiscoveryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "network_discovery", binaryMessenger: registrar.messenger)
    let instance = NetworkDiscoveryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  let browser:NWBrowser = nil

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "init":
      result("")
      case "cancel":
      result("")
      case "getPlatformName":
      result("MacOS!")

    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
