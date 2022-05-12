import Flutter
import UIKit
import Network

@available(iOS 13.0, *)
public class SwiftNetworkDiscoveryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "network_discovery", binaryMessenger: registrar.messenger())
      let instance = SwiftNetworkDiscoveryPlugin(channel:channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    let _channel:FlutterMethodChannel;
    let params:NWParameters;
    var browser:NWBrowser? = nil;
    
    init(channel:FlutterMethodChannel){
        self._channel = channel;
        self.params = NWParameters();
    };
    
    private func cb(serviceType:String, hostname: String, port: Int?){
        _channel.invokeMethod("browserCallback",
                              arguments: ["serviceType":serviceType,
                                          "hostname": hostname,
                                          "port": port as Any]);
    }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      let args = call.arguments as? Dictionary<String, Any>
    switch call.method {
    case "resolve":
        let r:[String:Any] = [
            "servicename":"test",
            "hostname":"bla",
            "port":1000,
            "ip":"127.0.0.1"]
        result(r);
      case "init":
        let serviceType = args!["serviceType"] as? String
        browser = NWBrowser(for: .bonjour(type: serviceType!, domain: nil), using: params)
        browser?.browseResultsChangedHandler = { results, changes in
            for change in changes {
                switch(change){
                case .added(let browseResult):
                    switch(browseResult.endpoint){
                    case .hostPort(let host, let port):
                        self.cb(serviceType: "bla", hostname: "bla", port: Int(port.rawValue))
                    case .service(let name, let type, _, _):
                        self.cb(serviceType: type, hostname: name, port: nil)
                    default:
                        self.cb(serviceType: "test", hostname: "test", port: nil)
                        print("fail")
                        
                    }
                default:
                    print("megafail")
                    
                }
            }
        }
        browser?.start(queue: DispatchQueue.global())
        cb(serviceType: "1", hostname: "ejkal", port: 1)
      result("");
      case "cancel":
        browser?.cancel();
        browser = nil
      result("");
      case "getPlatformName":
      result("ios!")

    case "getPlatformVersion":
    result("iOS v " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
