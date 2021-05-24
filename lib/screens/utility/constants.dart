import 'package:flutter/material.dart';
//import 'package:timeago/timeago.dart' as timeago;

// https://punchng.com/wp-json/wp/v2/posts?per_page=30
// https://punchng.com/wp-json/wp/v2/posts?categories=13&per_page=10
// https://punchng.com/wp-json/wp/v2/search?s=boko

const String BASE_URL="https://punchng.com/wp-json/wp/v2/";
const String SINGLE_NEWS ="posts?slug=";

const String LATEST_NEWS ="posts?per_page=20&page=1";
const String MORE_LATEST_NEWS ="posts?per_page=20&page=";

const String NEWS_BY_CATEGORY ="posts?per_page=20&page=1&categories=";
// const String MORE_NEWS_BY_CATEGORY ="posts?per_page=20&categories=&page=";
const String MORE_NEWS_BY_CATEGORY ="posts?per_page=20&page=";
// const String MORE_NEWS_BY_CATEGORY ="posts?per_page=20&page=&categories=&";

//https://punchng.com/wp-json/wp/v2/posts?tags=370,2160
const String NEWS_TAG ="posts?tags=";

const String SEARCH_RESULT ="search?per_page=20&search=";
const String MORE_SEARCH_RESULT ="search?per_page=20&search=&page=";

// https://punchng.com/wp-json/wp/v2/pages/778714
const String PRIVACY_POLICY ="pages/778714";
const String ABOUT_US ="pages/164902";

// https://punchng.com/category-payload/
const String CATEGORY_LIST ="https://punchng.com/category-payload/";

const String FEATURED_NEWS ="posts?categories=";
// const String CATEGORY_LIST ="categories";
// const String NEWS_BY_CATEGORY ="posts?categories=";
// const String SEARCH_NEWS ="search?search=";
// const String LATEST_NEWS ="posts?per_page=30";

// newly added
const String netCoreUrl ="https://api.netcoresmartech.com/apiv2?type=contact&activity=add&apikey=28b46bfdfd06f61d3a5b1d266e0b30d8";

class Constants {
//  static String readTimestamp(String timestamp) {
//    final DateTime date = DateTime.parse(timestamp);
//    var time = timeago.timeAgo(date);
//    // print('time : '+time);
//    return time;
//  }

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
    cursorColor: lightAccent,
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
    cursorColor: darkAccent,
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