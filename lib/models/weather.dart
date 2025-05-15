class Weather {
  final String description;
  final String icon;
  final double temp;

  Weather({required this.description, required this.icon, required this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
    );
  }
}
