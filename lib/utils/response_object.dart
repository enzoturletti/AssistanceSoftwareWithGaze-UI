import 'dart:convert';

class ResponseObject
{
  String state;
  var data;

  ResponseObject(this.state,this.data);

  Map convertToJsonObject() => {
    'status': state,
    'data': data,
  };

  String getJsonString()
  {
    return jsonEncode(convertToJsonObject());

  }
}