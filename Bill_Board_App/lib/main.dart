import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force landscape mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BillboardPage(),
  ));
}

class BillboardPage extends StatefulWidget {
  const BillboardPage({Key? key}) : super(key: key);

  @override
  State<BillboardPage> createState() => _BillboardPageState();
}

class _BillboardPageState extends State<BillboardPage>
    with SingleTickerProviderStateMixin {
  IO.Socket? socket;
  String currentMessage = '';
  String? imageUrl;
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    connectToSocket();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(_controller);
  }

  void connectToSocket() {
    socket = IO.io(
      'http://10.0.2.2:3000', // Use 10.0.2.2 if testing on Android emulator
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    socket!.onConnect((_) => print('Connected to server'));
    socket!.on('receive_text', (data) {
      setState(() {
        currentMessage = data['text'];
        imageUrl = null;
      });
    });

    socket!.on('receive_image', (data) {
      setState(() {
        imageUrl = data['url'];
        currentMessage = '';
      });
    });

    socket!.on('clear_display', (_) {
      setState(() {
        currentMessage = '';
        imageUrl = null;
      });
    });

    socket!.onDisconnect((_) => print('Disconnected from server'));
  }

  @override
  void dispose() {
    _controller.dispose();
    socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (imageUrl != null) {
      content = Image.network(imageUrl!);
    } else if (currentMessage.isNotEmpty) {
      content = SlideTransition(
        position: _animation,
        child: Text(
          currentMessage,
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      content = const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: content),
    );
  }
}
