
class Clima{
  String city;
  String date;
  String condition;
  int temp;
  int humidity;

  factory Clima.fromJson(Map<String, dynamic> jsonMaP){
    return Clima(
      city: jsonMaP['results']['city'],
      date: jsonMaP['results']['forecast'][0]['date'],
      condition: jsonMaP['results']['forecast'][0]['description'],
      temp: jsonMaP['results']['temp'],
      humidity: jsonMaP['results']['humidity']
    );
  }

  Clima({this.city, this.date, this.condition, this.humidity, this.temp});
}