// ignore: import_of_legacy_library_into_null_safe

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected => Future.value(true);
}
