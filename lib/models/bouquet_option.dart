class BouquetOption {
  final String flowerType;
  final String flowerColor;
  final int quantity;
  final String filler;
  final String wrappingColor;

  BouquetOption({
    required this.flowerType,
    required this.flowerColor,
    required this.quantity,
    required this.filler,
    required this.wrappingColor,
  });

  String toPrompt() {
    return '''
Create a realistic bouquet image.
Main flower: $flowerColor $flowerType
Quantity: $quantity
Filler: $filler
Wrapping paper: $wrappingColor
Style: natural, realistic, elegant
Strictly use only the selected flowers and filler.
''';
  }
}