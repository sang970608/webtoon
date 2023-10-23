//JSON 모델
class WebtoonModel {
  final String title, thumb, id;
  // name constructor 부여 후
  WebtoonModel.fromJson(Map<String, dynamic> json) :
        title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
  // name constructor 부여 전
  // WebtoonModel({
  //   required this.title,
  //   required this.thumb,
  //   required this.id,
  // });
}