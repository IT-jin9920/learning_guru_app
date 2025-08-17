import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class VideoPreviewWidget extends StatefulWidget {
  @override
  _VideoPreviewWidgetState createState() => _VideoPreviewWidgetState();
}

class _VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isLoading = false;
  bool _isPlaying = false;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    )..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();

      if (connectivity == ConnectivityResult.none) {
        _showErrorSnack("❌ No internet connection.");
        if (_controller.value.isPlaying) {
          _controller.pause();
          setState(() => _isPlaying = false);
        }
        return;
      }

      if (!_isInitialized) {
        setState(() => _isLoading = true);

        await _controller.initialize();
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });

        _controller.play();
        setState(() => _isPlaying = true);
      } else {
        if (_controller.value.isPlaying) {
          _controller.pause();
          setState(() => _isPlaying = false);
        } else {
          _controller.play();
          setState(() => _isPlaying = true);
        }
      }
    } catch (e) {
      _showNoInternetSnack();
      _showErrorSnack("⚠️ Something went wrong. Please try again.");
      setState(() => _isLoading = false);
      _showNoInternetSnack();
    }
  }


  void _showNoInternetSnack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("📡 No internet connection"),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.black12,
              child: _isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Image.asset(
                'assets/images/thm.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Loading Spinner
          if (_isLoading)
            const CircularProgressIndicator(color: Colors.white),

          // Play Icon
          if (!_isLoading && (!_isPlaying || !_isInitialized))
            _buildPlayIcon(),

          // Pause Icon (Optional)
          if (!_isLoading && _isPlaying)
            _buildPauseIcon(),
        ],
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: const Icon(Icons.play_arrow, size: 40, color: Colors.blue),
    );
  }

  Widget _buildPauseIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white70,
      ),
      child: const Icon(Icons.pause, size: 40, color: Colors.red),
    );
  }
}
