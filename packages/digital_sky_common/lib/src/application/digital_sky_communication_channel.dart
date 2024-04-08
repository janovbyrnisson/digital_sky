import 'dart:convert';

import 'package:digital_sky_common/src/domain/message.dart';
import 'package:localstorage/localstorage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:uuid/uuid.dart';

part 'digital_sky_communication_channel.g.dart';

@Riverpod(keepAlive: true)
DigitalSkyCommunicationChannel communicationChannel(CommunicationChannelRef ref) {
  ref.onDispose(() {
    ref.read(communicationChannelProvider).hubConnection.stop();
  });
  return DigitalSkyCommunicationChannel();
}

class DigitalSkyCommunicationChannel {
  final Map<MessageType, List<void Function(Message)>> _messageListeners = {};

  late final HubConnection hubConnection;
  late final String clientId;
  late final bool isMaster;

  void createConnection() {}

  Future<void> startConnection({bool isMaster = false}) async {
    print('Creating connection for ${isMaster ? 'MASTER' : 'PLAYER'}');

    clientId = localStorage.getItem('digisky.clientId') ?? Uuid().v4();
    localStorage.setItem('digisky.clientId', clientId);

    final serverUrl = "http://localhost:5220/channel";
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).withAutomaticReconnect().build();
    hubConnection.onclose(({error}) => print("Connection Closed"));
    hubConnection.on("ReceiveMessage", _handleMessage);

    hubConnection.onreconnected(
      ({connectionId}) {
        final jsonMessage =
            jsonEncode(Message(id: Uuid().v4(), type: MessageType.ping, clientId: clientId, content: "").toJson());
        hubConnection.invoke("SendMessage", args: <Object>[jsonMessage]);
      },
    );

    await hubConnection.start();
  }

  Future<void> sendMessage(Message message) async {
    print('Sending message');
    final jsonMessage = jsonEncode(message.copyWith(id: Uuid().v4(), clientId: clientId).toJson());

    final result = await hubConnection.invoke("SendMessage", args: <Object>[jsonMessage]);
    print("Result: '$result");
  }

  void addMessageListener(MessageType type, void Function(Message) listener) {
    _messageListeners.putIfAbsent(type, () => []).add(listener);
  }

  void removeMessageListener(MessageType type, void Function(Message) listener) {
    _messageListeners[type]?.remove(listener);
  }

  void _handleMessage(List<Object?>? args) {
    final message = Message.fromJson(jsonDecode(args?[0] as String));
    print('Received message: ${message.type} :: ${message.content}');
    _messageListeners[message.type]?.forEach((listener) => listener(message));
  }
}
