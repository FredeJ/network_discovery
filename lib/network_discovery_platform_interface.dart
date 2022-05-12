import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_discovery_method_channel.dart';

enum NetworkServiceStatus { unresolved, resolved }

class NetworkService {
  String servicename = "";
  String hostname = "";
  int? port = 0;
  String? ip = "";
  NetworkService(this.servicename, this.hostname, this.port, this.ip);

  NetworkServiceStatus get state {
    if (port != null && ip != null) {
      return NetworkServiceStatus.resolved;
    }
    return NetworkServiceStatus.unresolved;
  }

  @override
  String toString() {
    return "$servicename at $hostname:$port";
  }
}

abstract class NetworkDiscoveryPlatform extends PlatformInterface {
  /// Constructs a NetworkDiscoveryPlatform.
  NetworkDiscoveryPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkDiscoveryPlatform _instance = MethodChannelNetworkDiscovery();

  /// The default instance of [NetworkDiscoveryPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetworkDiscovery].
  static NetworkDiscoveryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkDiscoveryPlatform] when
  /// they register themselves.
  static set instance(NetworkDiscoveryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getPlatformName() {
    throw UnimplementedError("Not implm");
  }

  void init(String serviceType, Function(NetworkService) callback) {
    throw UnimplementedError("init() has not been implemented");
  }

  Future<NetworkService> resolve(NetworkService service) {
    throw UnimplementedError("Resolve not implemented");
  }

  void cancel() {
    throw UnimplementedError("cancel() has not been implemented");
  }
}
