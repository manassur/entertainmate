

import 'package:entertainmate/screens/model/feed_details_model.dart';


class FeedDetailsResponse {
  List<FeedDetailsModel> feedDetailsModel;

  FeedDetailsResponse({this.feedDetailsModel});

  FeedDetailsResponse.fromJson(List<dynamic> json) {
    //page = json['page'];
    if (json != null) {
     feedDetailsModel = new List<FeedDetailsModel>();
      json.forEach((v) {
        feedDetailsModel.add(new FeedDetailsModel.fromJson(v));
      });
    }
  }

  String toJson() {
      String data;
     // data['page'] = this.page;
     if (this.feedDetailsModel != null) {
       data = this.feedDetailsModel.map((v) => v.toJson()).toList().toString();
     }
     return data;
   }
}
