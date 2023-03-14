import 'dart:io';
import 'dart:typed_data';

class VideoDetail {
  String name;
  String path;
  int height;
  int width;
  Duration totalDuration;
  Uint8List thumbNail;
  DateTime createDateTime;

  VideoDetail(
      {required this.name,
      required this.path,
      required this.height,
      required this.width,
      required this.totalDuration,
      required this.thumbNail,
      required this.createDateTime});
}
