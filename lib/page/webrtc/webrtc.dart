import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Webrtc extends StatefulWidget {
  const Webrtc({super.key});

  @override
  State<Webrtc> createState() => _WebrtcState();
}

class _WebrtcState extends State<Webrtc> {
  final _localRenderer = RTCVideoRenderer();

  void initRenderers() async {
    await _localRenderer.initialize();
  }

  void getUserMedia() async {
    MediaStream localStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'user',
      },
      'audio': true,
    });
    _localRenderer.srcObject = localStream;
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    getUserMedia();
  }

  @override
  void dispose() async {
    await _localRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Flutter WebRTC", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: RTCVideoView(_localRenderer, mirror: true),
          )
        ],
      ),
    );
  }
}
