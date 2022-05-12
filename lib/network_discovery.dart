import 'network_discovery_platform_interface.dart';

class NetworkDiscovery {
  Future<String?> getPlatformVersion() {
    return NetworkDiscoveryPlatform.instance.getPlatformVersion();
  }

  void init(String serviceType, Function(NetworkService) callback) {
    return NetworkDiscoveryPlatform.instance.init(serviceType, callback);
  }

  Future<NetworkService> resolve(NetworkService service) {
    return NetworkDiscoveryPlatform.instance.resolve(service);
  }

  void cancel() {
    return NetworkDiscoveryPlatform.instance.cancel();
  }

  Future<String?> getPlatformName() {
    return NetworkDiscoveryPlatform.instance.getPlatformName();
  }
}
