main (){
  final otherDiameters = <double, String>{0.383: 'Mercury', 0.949: 'Venus'};
  for (final item in otherDiameters.entries) {
    print("item:$item");
    // diameters.putIfAbsent(item.key, () => item.value);
  }
}