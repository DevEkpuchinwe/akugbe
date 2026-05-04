import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostMediaWidget extends StatefulWidget {
  final int postId;

  const PostMediaWidget({required this.postId, super.key});

  @override
  _PostMediaWidgetState createState() => _PostMediaWidgetState();
}

class _PostMediaWidgetState extends State<PostMediaWidget> {
  bool _imageFailed = false;
  VideoPlayerController? _videoController;
  bool _isPlaying = false;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  void _initVideo() {
    final url = buildSupabaseImageUrl(widget.postId);

    _videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _isPlaying = true;
          _videoController?.play();
          _videoController?.setLooping(true);
        });
      }).catchError((error) {
        debugPrint("Video load failed: $error");
      });
  }

  void _togglePlayPause() {
    if (_videoController == null) return;
    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
        _isPlaying = false;
      } else {
        _videoController!.play();
        _isPlaying = true;
      }
    });
  }

  void _seekForward() {
    if (_videoController == null) return;
    final current = _videoController!.value.position;
    final duration = _videoController!.value.duration;
    final target = current + const Duration(seconds: 10);
    if (target < duration) {
      _videoController!.seekTo(target);
    } else {
      _videoController!.seekTo(duration);
    }
  }

  void _seekBackward() {
    if (_videoController == null) return;
    final current = _videoController!.value.position;
    final target = current - const Duration(seconds: 10);
    _videoController!.seekTo(target > Duration.zero ? target : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    final mediaUrl = buildSupabaseImageUrl(widget.postId);

    if (!_imageFailed) {
      return CachedNetworkImage(
        width: double.infinity,
        fit: BoxFit.fitWidth,
        imageUrl: mediaUrl,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _imageFailed = true;
              });
              _initVideo();
            }
          });
          return const Center(child: CupertinoActivityIndicator(radius: 20));
        },
      );
    } else {
      if (_videoController == null || !_videoController!.value.isInitialized) {
        return const Center(child: CupertinoActivityIndicator(radius: 20));
      }

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          _ControlsOverlay(
            isPlaying: _isPlaying,
            onPlayPause: _togglePlayPause,
            onForward: _seekForward,
            onRewind: _seekBackward,
          ),
        ],
      );
    }
  }
}

class _ControlsOverlay extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onForward;
  final VoidCallback onRewind;

  const _ControlsOverlay({
    required this.isPlaying,
    required this.onPlayPause,
    required this.onForward,
    required this.onRewind,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 36,
              color: Colors.white,
              icon: const Icon(Icons.replay_10),
              onPressed: onRewind,
            ),
            IconButton(
              iconSize: 48,
              color: Colors.white,
              icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
              onPressed: onPlayPause,
            ),
            IconButton(
              iconSize: 36,
              color: Colors.white,
              icon: const Icon(Icons.forward_10),
              onPressed: onForward,
            ),
          ],
        ),
      ),
    );
  }
}

String buildSupabaseImageUrl(int postId) {
  return "https://raapnfbewyiflaoaxgmi.supabase.co/storage/v1/object/public/posts//$postId";
}



