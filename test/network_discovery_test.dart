import 'package:flutter_test/flutter_test.dart';
import 'package:network_discovery/network_discovery.dart';
import 'package:network_discovery/network_discovery_platform_interface.dart';
import 'package:network_discovery/network_discovery_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNetworkDiscoveryPlatform 
    with MockPlatformInterfaceMixin
    implements NetworkDiscoveryPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NetworkDiscoveryPlatform initialPlatform = NetworkDiscoveryPlatform.instance;

  test('$MethodChannelNetworkDiscovery is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNetworkDiscovery>());
  });

  test('getPlatformVersion', () async {
    NetworkDiscovery networkDiscoveryPlugin = NetworkDiscovery();
    MockNetworkDiscoveryPlatform fakePlatform = MockNetworkDiscoveryPlatform();
    NetworkDiscoveryPlatform.instance = fakePlatform;
  
    expect(await networkDiscoveryPlugin.getPlatformVersion(), '42');
  });
}
