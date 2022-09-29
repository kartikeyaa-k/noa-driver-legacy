/// Server config to create object for api client
class ServerConfig {
  /// Server config to create object for api client
  /// [isHttps] is the ssl or tsl enabled
  /// [baseUrl] is the base url
  const ServerConfig({
    required this.isHttps,
    required this.baseUrl,
  });

  /// is the server ssl or tsl enabled
  /// if true then link will use https else http
  final bool isHttps;

  /// The base url used for all requests
  /// eg: https://meeteo.com without the end slash
  final String baseUrl;

  /// The auth microservice end point
  // final String service;

  @override
  String toString() => 'isHttps: $isHttps, base url: $baseUrl';
}
