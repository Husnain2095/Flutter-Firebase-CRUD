import 'package:http/http.dart' as http;
class ApiServices{

 static Future getApiData()async{
  var request = http.Request('GET', Uri.parse('https://www.episodate.com/api/most-popular?page=1'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
  var res = await response.stream.bytesToString();
  return res;
  }
  else {
   print(response.reasonPhrase);
  }

 }


 static Future getDataDesc(movieID)async{
  var request = http.Request('GET', Uri.parse('https://www.episodate.com/api/show-details?q=$movieID'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
   var res = await response.stream.bytesToString();
   return res;
  }
  else {
   print(response.reasonPhrase);
  }

 }

}