import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubeDefaultWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<YoutubeDefaultWidget>
    implements YouTubePlayerListener {
  double _currentVideoSecond = 0.0;
  String _playerState = "";
  FlutterYoutubeViewController _controller;
  double _volume = 50;
  double _videoDuration = 0.0;

  YoutubeScaleMode _mode = YoutubeScaleMode.none;
  PlaybackRate _playbackRate = PlaybackRate.RATE_1;
  bool _isMuted = false;
  @override
  void onCurrentSecond(double second) {
    print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  void _loadOrCueVideo() {
    _controller.loadOrCueVideo('gcj2RUWQZ60', _currentVideoSecond);
  }

  void _play() {
    _controller.play();
  }

  void _pause() {
    _controller.pause();
  }

  void _seekTo(double time) {
    _controller.seekTo(time);
  }

  void _setVolume(int volumePercent) {
    _controller.setVolume(volumePercent);
  }

  void _changeScaleMode(YoutubeScaleMode mode) {
    setState(() {
      _mode = mode;
      _controller.changeScaleMode(mode);
    });
  }

  void _changeVolumeMode(bool isMuted) {
    setState(() {
      _isMuted = isMuted;
      if (isMuted) {
        _controller.setMute();
      } else {
        _controller.setUnMute();
      }
    });
  }

  void _changePlaybackRate(PlaybackRate playbackRate) {
    setState(() {
      _playbackRate = playbackRate;
      _controller.setPlaybackRate(playbackRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Default UI')),
        body: Stack(
          children: <Widget>[
            Container(
                child: FlutterYoutubeView(
              scaleMode: _mode,
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                videoId: 'gcj2RUWQZ60',
                showUI: true,
                startSeconds: 0,
                autoPlay: false,
              ),
            )),
            Center(
                child: Column(
              children: <Widget>[
                Text(
                  'Current state: $_playerState',
                  style: TextStyle(color: Colors.blue),
                ),
                RaisedButton(
                  onPressed: _loadOrCueVideo,
                  child: Text('Click reload video'),
                ),
              ],
            ))
          ],
        ));
  }
}
