part of '../services.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  ServerStatus _serverStatus = ServerStatus.Connecting;

  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  ServerStatus get serverStatus => _serverStatus;
  // SocketService() {
  //   this._initConfig();
  // }

  void connect() async {
    /* final token = await AuthService.getToken(); */
    // Dart client
    _socket = IO.io(
        Environment.serverHttpUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // disable auto-connection
            .enableForceNew()
            .setExtraHeaders({
              'foo': 'bar',
              'Authorization': 'Bearer ${await _storage.read(key: 'token')}',
              /* 'x-token': token, */
            }) // optional
            .build());

    _socket.on('connect', (_) {
      print('connected socket success');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.on('disconnect', (_) {
      print('offline sockets');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /* socket.on('msgToClient', (payload) {
      print('msgToClient :$payload');
    }); */
  }

  void disconnect() {
    _socket.disconnect();
  }
}
