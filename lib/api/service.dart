import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Service {

  postMethod() async {}

  static const CHANNEL_ID = 'UCMF1IZjfEUY2ybMaFQ1eKiA-FTbjWN1A';
  static const _baseUrl = 'www.googleapis.com';
  static getChannelInfo() async {
    Map<String, String> parameters = {
      // 'part': 'snippet,contentDetails,statistics',
      'id': CHANNEL_ID,
      'key': "AIzaSyDgt6T7NR2GcTIWRxgTARLV2H_PljbWSrM",
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Response response = (await http.get(uri, headers: headers));
    print(response.body);
    // ChannelInfo channelInfo = channelInfoFromJson(response.body);
    // return channelInfo;
  }
}
