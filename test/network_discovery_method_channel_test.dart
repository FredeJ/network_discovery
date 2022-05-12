import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_discovery/network_discovery_method_channel.dart';

void main() {
  MethodChannelNetworkDiscovery platform = MethodChannelNetworkDiscovery();
  const MethodChannel channel = MethodChannel('network_discovery');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
