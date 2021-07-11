class VideoModel {
  String name;
  String videolink;

  VideoModel.fromMap(Map<String, dynamic> data, String id) {
    name = data['doctor'];
    videolink = data['link'];
  }
  Map<String, dynamic> toMap() {
    return {
      'doctor': name,
      'link': videolink,
    };
  }
}
