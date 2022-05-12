import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'network_discovery_platform_interface.dart';

/// An implementation of [NetworkDiscoveryPlatform] that uses method channels.
class MethodChannelNetworkDiscovery extends NetworkDiscoveryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('network_discovery');
  Function(NetworkService)? _cb;

  Future<void> _handle(MethodCall call) async {
    final args = call.arguments;
    switch (call.method) {
      case "browserCallback":
        _cb?.call(NetworkService(
            args["serviceType"], args["hostname"], args["port"], null));
        break;
      default:
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void init(String serviceType, Function(NetworkService) callback) {
    _cb = callback;
    methodChannel.setMethodCallHandler(_handle);
    methodChannel.invokeMethod("init", <String, Object>{
      "serviceType": serviceType,
    });
  }

  @override
  Future<NetworkService> resolve(NetworkService service) async {
    final info = await methodChannel
        .invokeMethod("resolve", <String, Object>{"service": service});
    print(info);

    return NetworkService(
        info["servicename"], info["hostname"], info["port"], info["ip"]);
  }

  @override
  void cancel() {
    methodChannel.invokeMethod("cancel");
  }

  @override
  Future<String?> getPlatformName() async {
    final name = await methodChannel.invokeMethod<String>('getPlatformName');
    return name;
  }
}
