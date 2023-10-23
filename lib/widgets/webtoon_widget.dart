import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                DetailScreen(
                    title: title,
                    thumb: thumb,
                    id: id
                ),
              fullscreenDialog: true,
            )
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10,10),
                    color: Colors.black.withOpacity(0.5)
                  ),
                ],
              ),
              child: Image.network(thumb,
                // user-agent없을 경우 403에러나므로 사용
                headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
                // Builder에는 return 필수
              // 로딩시에는 프로그레스바 사용
                loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? event) {
                  //event 값이 없으면 return
                  if (event == null) {
                    return widget;
                  }
                  return Container(
                    height: 100,
                    width: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        //value : 진척률
                        //value: event?.expectedTotalBytes != null ? event!.cumulativeBytesLoaded / event.expectedTotalBytes! : null,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue[100]!),
                        backgroundColor: Colors.blue[600],
                      ),
                    ),
                  );
                },
                // 에러시에는 empty케이스
                errorBuilder: (context, error, stackTrace) {
                  log("error::$error");
                  return Image.asset('images/empty_image.jpg');
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
