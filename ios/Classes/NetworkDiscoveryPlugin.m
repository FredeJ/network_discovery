#import "NetworkDiscoveryPlugin.h"
#if __has_include(<network_discovery/network_discovery-Swift.h>)
#import <network_discovery/network_discovery-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "network_discovery-Swift.h"
#endif

@implementation NetworkDiscoveryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNetworkDiscoveryPlugin registerWithRegistrar:registrar];
}
@end
