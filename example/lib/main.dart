import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:network_discovery/network_discovery.dart';
import 'package:network_discovery/network_discovery_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _platformName = '';
  final _networkDiscoveryPlugin = NetworkDiscovery();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void ResolvePrint(NetworkService serv) async {
    final s = await _networkDiscoveryPlugin.resolve(serv);
    print(s.toString());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _networkDiscoveryPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      _platformName =
          await _networkDiscoveryPlugin.getPlatformName() ?? 'unknown';
    } on PlatformException {
      _platformName = "fail";
    }

    _networkDiscoveryPlugin.init("_http._tcp", (p0) => ResolvePrint(p0));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on this: $_platformName $_platformVersion\n'),
        ),
      ),
    );
  }
}
