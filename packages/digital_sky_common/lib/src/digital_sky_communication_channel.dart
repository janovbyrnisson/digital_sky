import 'package:signalr_netcore/signalr_client.dart';

class DigitalSkyCommunicationChannel {
  late HubConnection hubConnection;

  void createConnection() {
    print('Creating connection');
    final serverUrl = "http://localhost:5220/channel";
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose(({error}) => print("Connection Closed"));
    hubConnection.on("ReceiveMessage", _handleMessage);
  }

  Future<void> startConnection() async {
    print('Starting connection');
    await hubConnection.start();
    print('CONNECTED');
  }

  Future<void> sendMessage(String actor, String message) async {
    print('Sending message');
    final result = await hubConnection.invoke("SendMessage", args: <Object>[message]);
    print("Result: '$result");
  }

  void _handleMessage(List<Object?>? args) {
    print('Received message: ${args?[0]}');
  }
}
