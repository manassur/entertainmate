

import '../mate_home_model.dart';

class MateHomeResponse {
  // int page;
  List<MateHomeModel> mateHomeModel;

  MateHomeResponse({
    // this.page,
    this.mateHomeModel
  });

  MateHomeResponse.fromJson(List<dynamic> json) {
    //page = json['page'];
    if (json != null) {
     mateHomeModel = new List<MateHomeModel>();
      json.forEach((v) {
        mateHomeModel.add(new MateHomeModel.fromJson(v));
      });
    }
  }

  String toJson() {
      String data;
     // data['page'] = this.page;
     if (this.mateHomeModel != null) {
       data = this.mateHomeModel.map((v) => v.toJson()).toList().toString();
     }
     return data;
   }
}
