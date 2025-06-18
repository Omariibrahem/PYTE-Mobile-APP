import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/foundation.dart';

enum MqttCurrentConnectionState { //enumerations,class in Dart used to represent a fixed number of constant values
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING,
}

enum MqttSubscriptionState {
  IDLE,
  SUBSCRIBED,
}

class MqttService with ChangeNotifier {
  static final MqttService _instance = MqttService._internal();
  factory MqttService() => _instance;

  MqttService._internal() {
    prepareMqttClient();
  }

  String broker = 'broker.hivemq.com';
  int port = 1883;
  String clientIdentifier = 'your_client_identifier';
  MqttServerClient? client;
  String currentTopic = 'MovTest';
  String username = '';
  String password = '';

  Function(String)? onStatusChanged;
  Function(String)? onMessageReceived;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
    // Subscribe only after connection is established
    if (connectionState == MqttCurrentConnectionState.CONNECTED) {
      _subscribeToTopic(currentTopic);
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(broker, clientIdentifier, port);
    client!.secure = false;
    client!.keepAlivePeriod = 20; // Consider adjusting this
    client!.onDisconnected = onDisconnected;
    client!.onConnected = onConnected;
    client!.onSubscribed = onSubscribed;
  }

  Future<void> _connectClient() async {
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('Already connected.');
      return; // No need to connect if already connected
    }

    try {
      print('Client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      notifyListeners();

      await client!.connect(username, password);
    } catch (e) {
      print('Client connection exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('Client connected');
      notifyListeners();
    } else {
      print('ERROR client connection failed - status is ${client!.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client!.disconnect();
    }
  }

  void onConnected() {
    print('OnConnected client callback - Client connection was successful');
    connectionState = MqttCurrentConnectionState.CONNECTED;
    onStatusChanged?.call('Connected');
    notifyListeners();

    // Re-subscribe to the topic to ensure receiving messages
    _subscribeToTopic(currentTopic);
  }

  void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
    onStatusChanged?.call('Disconnected');
    notifyListeners();

    // Attempt to reconnect
    _reconnect();
  }

  void _reconnect() {
    int delay = 5; // initial delay
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: delay));
      try {
        print('Attempting to reconnect...');
        await _connectClient();
        return false; // Stop trying if connected
      } catch (e) {
        print('Reconnection attempt failed: $e');
        delay = (delay < 60) ? delay * 2 : 60; // limit to 60 seconds
        return true; // Continue trying
      }
    });
  }

  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
    notifyListeners();
  }

  void _subscribeToTopic(String topic) {
    if (connectionState != MqttCurrentConnectionState.CONNECTED) {
      print('Cannot subscribe, client not connected');
      return;
    }

    print('Subscribing to the $topic topic');
    client!.subscribe(topic, MqttQos.atMostOnce);

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      print('Message received: ${c.length}');
      for (var message in c) {
        final MqttPublishMessage recMess = message.payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print('YOU GOT A NEW MESSAGE: $payload');

        if (onMessageReceived != null) {
          onMessageReceived!(payload);
        }
      }
    }, onError: (error) {
      print('Error receiving messages: $error'); // Handle errors
    });
  }

  void controlCar(String direction) {
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      _publishMessage(direction);
    } else {
      print('Cannot send message, MQTT client is not connected.');
    }
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('Publishing message "$message" to topic $currentTopic');
    client!.publishMessage(currentTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  void updateBroker(String newBroker) {
    broker = newBroker;
    disconnect();
    prepareMqttClient(); // Ensure new settings are applied
  }

  void updateTopic(String newTopic) {
    currentTopic = newTopic;
    _subscribeToTopic(newTopic);
  }

  void updateCredentials(String newUsername, String newPassword) {
    username = newUsername;
    password = newPassword;
    disconnect();
    prepareMqttClient(); // Ensure new settings are applied
  }

  void disconnect() {
    client!.disconnect();
    onDisconnected();
  }
}
