import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FilePreviewWidget extends StatefulWidget {
  final Uint8List? fileBytes;
  final String? filePath;
  final String? mimeType;

  const FilePreviewWidget({
    super.key,
    this.fileBytes,
    this.filePath,
    this.mimeType,
  });

  @override
  State<FilePreviewWidget> createState() => _FilePreviewWidgetState();
}

class _FilePreviewWidgetState extends State<FilePreviewWidget> {
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoIfNeeded();
  }

  void _initializeVideoIfNeeded() {
    if (widget.mimeType != null &&
        widget.mimeType!.startsWith("video/") &&
        widget.filePath != null) {
      setState(() => _isVideoLoading = true);
      _videoController = VideoPlayerController.file(File(widget.filePath!))
        ..initialize().then((_) {
          setState(() => _isVideoLoading = false);
        }).catchError((e) {
          debugPrint("❌ Video load error: $e");
          setState(() => _isVideoLoading = false);
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mimeType == null) {
      return const SizedBox();
    }

    // 🖼️ Image Preview
    if (widget.mimeType!.startsWith('image/') && widget.fileBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          widget.fileBytes!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    // 🎥 Video Preview
    if (widget.mimeType!.startsWith('video/')) {
      if (_isVideoLoading || _videoController == null || !_videoController!.value.isInitialized) {
        return const Center(child: CircularProgressIndicator());
      }

      return Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                });
              },
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: Icon(
                    _videoController!.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // 📄 PDF Preview
    if (widget.mimeType!.contains('pdf')) {
      return const Center(
        child: Icon(Icons.picture_as_pdf, size: 48, color: Colors.red),
      );
    }

    // 🎵 Audio Preview
    if (widget.mimeType!.contains('audio')) {
      return const Center(
        child: Icon(Icons.audiotrack, size: 48, color: Colors.deepPurple),
      );
    }

    // 🗃️ Default File Icon
    return const Center(
      child: Icon(Icons.insert_drive_file, size: 48, color: Colors.grey),
    );
  }
}
