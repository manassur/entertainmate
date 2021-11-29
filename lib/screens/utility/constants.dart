import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:timeago/timeago.dart' as timeago;


// http client constants
var headers = <String, String>{
  "Accept": "application/x-www-form-urlencoded",
  'Content-Type': 'application/x-www-form-urlencoded',
  'Authorization' : '342b86b7248d791b858b878e57c9aef3hjkkkhhuuu'
};



const String BASE_URL="https://apprant.com/entertainmate/api/index.php/";
const String IMAGE_BASE_URL="https://apprant.com/entertainmate/api/";

const String CHECK_USER_EXIST =BASE_URL+"user/check/phone/";
const String CHECK_HAS_REFERER =BASE_URL+"user/check/referstatus/";

const String CHECK_USERNAME_AVAILABLE =BASE_URL+"user/check/username/";
const String CHECK_EMAIL_AVAILABLE =BASE_URL+"user/check/email";

const String CREATE_USER =BASE_URL+"user/create/";
const String CHECK_SAVE_PROFILE =BASE_URL+"user/profile/update";
const String SEND_SMS_INVITE =BASE_URL+"user/sms/invite";
const String SEND_EMAIL_INVITE =BASE_URL+"user/email/invite";
const String UPDATE_USER_DETAILS =BASE_URL+"user/profile/edit";
const String SEND_EMAIL_OTP =BASE_URL+"user/email/sendOtp";
const String FETCH_HOME_FEED =BASE_URL+"user/feed";
const String FETCH_FEED_DETAILS =BASE_URL+"feed/details/";
const String FETCH_USER_COMMENTS=BASE_URL+"feed/comments/";
const String SAVE_INTEREST=BASE_URL+"post/like?action=0&type=1&postId=1";
const String POST_COMMENT=BASE_URL+"feed/comment";

const String REGISTER_BUSINESS=BASE_URL+"user/create_business";

const String CREATE_EVENT=BASE_URL+"user/add_event";
const String CREATE_POST_IMAGE=BASE_URL+"event/add_photo";

const String FETCH_USER_FOLLOWING=BASE_URL+"user/followings";
const String FETCH_INTERESTED_USER=BASE_URL+"user/info/";
const String FETCH_USER_PROFILE=BASE_URL+"user/info/";
const String FOLLOW_USER=BASE_URL+"user/follow";
const String UNFOLLOW_USER=BASE_URL+"user/unfollow";

// secure storage keys
const String CHECK_LOGIN_STATUS = "loginstatus";
const String SESSION_ID = "session_id";
const String SESSION_TOKEN = "session_token";
const String LOGGED_IN_USER = "user";


class Constants {
 static String formattedTime(String dateTime) {
  final DateTime timeDate = DateTime.parse(dateTime.toString());
  var time =
  // DateFormat().add_jm().format(timeDate);
  // DateFormat.yMEd().add_jms().format(DateTime.now());
  DateFormat.yMMMMd().add_jm().format(timeDate);

  return time;
  }

  static String latestNewsCacheKey ="latest";
  static String featuredNewsCacheKey ="featured";

  static String appName = "Punch News";
  static String appPackage = "com.punch_news";

  static String appAbout =
  // "<h3>You can reach out to us .</h3>"
      "<h2>PUNCH NIGERIA LIMITED </h2>"
      "<p>Phone: 08053533002</p>"
      "<p>Email: punchng@gmail.com</p>"
      "<p>Address: Punch Place,kilometer 14, Lagos-Ibadan express way </p>";

  static String appPrivacy = "<h3>Privacy Policy</h3>"
      "Most people wouldn’t even consider getting a physical morning newspaper anymore, "
      "so we depend on digital sources for our news. Finding an app that helps you get the news you want in a timely manner is essential."
      "<p>Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.</p>"
      '<p>Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.</p>'
      "<p>Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.</p>"
      "<p>Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.</p>";


  static String newsDetails = "<h3></h3>"
      "THE Minister of Women Affairs, Pauline Tallen, on Wednesday, led a high-powered delegation of women, to the National Secretariat of the All Progressives Congress, to demand for a 50 per cent representation of women in leadership positions."
      "  Tallen, who led the delegation to submit a memorandum to the APC Constitution Review Committee, noted that it was time the Nigerian the female gender was given its pride of place in the scheme of things both within the party and in government."

      "  She said, “We demand affirmative action. You will agree with me that women toil and give the highest votes in all the elections. The absence of women in the party structure is what bothers women. We are here to demand for the amendment."

      "  “We were aware last week; the party inaugurated the Committee for the amendment of its constitution. Immediately we heard about the constitution of the Committee, we swung into action. We happened to be the first because we agree that we are the most marginalized. And that is unacceptable for national development. We are here to demand affirmative action."

      "  “We need more women in the party structure and for all elections. We are demanding that no gender, women or men, should occupy more than 60 per cent as against the other. We are demanding gender equality. We are demanding full participation and representation of women in the party structure and all elective seats in our dear country, Nigeria.”"

      "  According to her, women were tired of tokenism, noting that they were ready to be treated fairly, if not equally with men in the political space."

      "  The minister, however, commended the President, Major General Muhammadu Buhari (retd.), for his pro-women disposition to governance."

      "  Members of the delegation included the United Nations Country Representative, Comfort Lamptey; Chairman, House Committee on Electoral Matters, Aisha Duku, a representative of the 100 Women Lobby Group and other Civil Society Organisations."

      "  Chairman of the APC Constitution Review Committee, Prof. Tahir Mamman, SAN, received the document on behalf of the party. ";


  //THEME
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xFFBB0004);
  static Color darkAccent = Color(0xFFBB0004);
  static Color lightBG = Color(0xFFFAFAFA);
  static Color darkBG = Color(0xFF2C2C2C);

  static ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: "Poppins",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400 ), // news title
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontFamily: "Poppins",
          color: lightBG,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400), // news title
    ),

  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }


}
