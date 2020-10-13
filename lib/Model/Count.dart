

class Count{
  int ID;
  int count;
  Count.fromJson(Map<String,dynamic> json)
  {
    ID=json['ID'];
    count=json['count'];
  }
}