import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'utility/constants.dart' as Constants;

import 'model/feed_details_model.dart';

class PhotoStoryScreen extends StatefulWidget {
 final List<Images> images;
  const PhotoStoryScreen({Key key,this.images}) : super(key: key);

  @override
  _PhotoStoryScreenState createState() => _PhotoStoryScreenState();
}


class _PhotoStoryScreenState extends State<PhotoStoryScreen> {
  final mycontroller = StoryController();
   List<StoryItem> storyItems = [];
  @override
  void initState(){
    super.initState();
     storyItems = [
    for(Images img in widget.images)
       StoryItem.pageImage(
        imageFit: BoxFit.contain,
        url: Constants.IMAGE_BASE_URL+ img.image,
        controller: mycontroller,
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
        controller: mycontroller,
        storyItems: storyItems,
        inline: false,
        onComplete: () {
      Navigator.pop(context);
    },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        } //
    );
  }
}
