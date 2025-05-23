import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCall extends ConsumerStatefulWidget {
  const VideoCall({super.key});

  @override
  ConsumerState createState() => _VideoCallState();
}

class _VideoCallState extends ConsumerState<VideoCall> {
  late RtcEngine _engine;
  int? _remoteUid; // Stores remote user ID
  bool _localUserJoined = false;

  Future<void> _initializeAgoraVideoSDK() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "21af0b7b2ad34093b3afbaff8c7f6e2c",
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  // Set up the Agora RTC engine instance
  Future<void> _initializeAgoraVoiceSDK() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "21af0b7b2ad34093b3afbaff8c7f6e2c",
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  // Join a channel
  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token:
          "007eJxTYDjy9k/RemGfi/1huUpav0/2tIQZ+Ua8X8W/0dNLdPGy/mwFBiPDxDSDJPMko8QUYxMDS+Mk48S0pMS0NItk8zSzVKPk/oZ96Q2BjAx7NfJYGBkgEMTnYAhJLS5xTszJYWAAACc2Ihs=",
      channelId: "Test Channel",
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        // Automatically subscribe to all video streams
        autoSubscribeAudio: true,
        // Automatically subscribe to all audio streams
        publishCameraTrack: true,
        // Publish camera-captured video
        publishMicrophoneTrack: true,
        // Publish microphone-captured audio
        // Use clientRoleBroadcaster to act as a host or clientRoleAudience for audience
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
  }

  // Register an event handler for Agora RTC
  void _setupEventHandlers() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {});
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() => {});
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          setState(() {});
        },
      ),
    );
  }

  Future<void> _setupLocalVideo() async {
    // The video module and preview are disabled by default.
    await _engine.enableVideo();
    await _engine.startPreview();
  }

  // Displays the local user's video view using the Agora engine.
  Widget _localVideo() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine, // Uses the Agora engine instance
        canvas: const VideoCanvas(
          uid: 0, // Specifies the local user
          renderMode:
              RenderModeType.renderModeHidden, // Sets the video rendering mode
        ),
      ),
    );
  }

  // If a remote user has joined, render their video, else display a waiting message
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine, // Uses the Agora engine instance
          canvas: VideoCanvas(uid: _remoteUid), // Binds the remote user's video
          connection: const RtcConnection(
              channelId: "Test Channel"), // Specifies the channel
        ),
      );
    } else {
      return const Text(
        'Waiting for remote user to join...',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  // Leaves the channel and releases resources
  Future<void> _cleanupAgoraEngine() async {
    await _engine.leaveChannel();
    await _engine.release();
  }


  Future<void> _startVideoCalling() async {
    await _requestPermissions();
    await _initializeAgoraVideoSDK();
    await _setupLocalVideo();
    _setupEventHandlers();
    await _joinChannel();
  }

  @override
  void initState() {
    super.initState();
    _startVideoCalling();
  }
  //
  // void initAgora() async {
  //   await client.initialize();
  // }

  @override
  void dispose() {
    _cleanupAgoraEngine();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Center(child: _remoteVideo()),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _localUserJoined
                        ? _localVideo()
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
