import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_study_jam/config/themes/app_colors.dart';
import 'package:flutter_study_jam/config/themes/app_text_styles.dart';

class KeywordSearch extends StatelessWidget {
  final String audioUrl;
  const KeywordSearch(
      {Key? key,
      required this.keyWordSearch,
      required this.phonetic,
      required this.audioUrl})
      : super(key: key);
  final String keyWordSearch;
  final String phonetic;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AudioButton(url: audioUrl),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              keyWordSearch,
              style: AppTextStyles.h1,
            ),
            SizedBox(height: 8.h),
            Text(
              phonetic,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryBuleColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AudioButton extends StatefulWidget {
  final String url;
  const AudioButton({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        audioPlayer.play(widget.url, isLocal: false);
      },
      child: Container(
        width: 55.sp,
        height: 55.sp,
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.borderLineColor,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/volume-2.png',
          //height: 45,
        ),
      ),
    );
  }
}
