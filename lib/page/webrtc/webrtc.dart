import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class Webrtc extends StatefulWidget {
  const Webrtc({super.key});

  @override
  State<Webrtc> createState() => _WebrtcState();
}

class _WebrtcState extends State<Webrtc> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  final sdpController = TextEditingController();
  bool _offer = false;

  void initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void getUserMedia() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'video': {
        'facingMode': 'user',
      },
      'audio': true,
    });
    _localRenderer.srcObject = _localStream;
  }

  void _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };
    Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };
    _peerConnection = await createPeerConnection(configuration, offerSdpConstraints);
    _peerConnection!.addStream(_localStream!);

    _peerConnection!.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({'candidate': e.candidate, 'sdpMid': e.sdpMid, 'sdpMlineIndex': e.sdpMLineIndex}));
      }
    };

    _peerConnection!.onIceConnectionState = (e) {
      print(e);
    };

    _peerConnection!.onAddStream = (stream) {
      print('addStream: ${stream.id}');
      _remoteRenderer.srcObject = stream;
    };
  }

  void _createOffer() async {
    RTCSessionDescription description = await _peerConnection!.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    print(json.encode(session));
    _offer = true;
    _peerConnection!.setLocalDescription(description);
  }

  void _createAnswer() async {
    RTCSessionDescription description = await _peerConnection!.createAnswer({'offerToReceiveVideo': 1});
    _peerConnection!.setLocalDescription(description);
  }

  void _setRemoteDescription() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode(jsonString);
    String sdp = write(session, null);

    RTCSessionDescription description = RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());

    await _peerConnection!.setRemoteDescription(description);
  }

  void _addCandidate() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode(jsonString);
    print(session['candidate']);

    dynamic candidate = RTCIceCandidate(session['candidate'], session['sdpMid'], session['sdpMlineIndex']);

    await _peerConnection!.addCandidate(candidate);
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    getUserMedia();
    _createPeerConnection();
  }

  @override
  void dispose() async {
    super.dispose();
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();
    sdpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter WebRTC", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(19, 34, 87, 1.0),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Flexible(flex: 2, child: RTCVideoView(_remoteRenderer)),
                Flexible(
                    flex: 1,
                    child: RTCVideoView(
                      _localRenderer,
                      mirror: true,
                    ))
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: sdpController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    maxLength: TextField.noMaxLength,
                  ),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _createOffer,
                      child: const Text("Offer"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _createAnswer,
                      child: const Text("Answer"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _setRemoteDescription,
                      child: const Text("Set Remote Description"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _addCandidate,
                      child: const Text("Set Candidate"),
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
