
class MealTranslator {
  static const Map<String, String> _arabicNames = {
    'kabse': 'كبسة',
    'kabsa': 'كبسة',
    'chicken burger': 'برجر دجاج',
    'beef burger': 'برجر لحم',
    'burger': 'برجر',
    'pizza': 'بيتزا',
    'pasta': 'مكرونة',
    'spaghetti': 'سباجيتي',
    'chicken soup': 'شوربة دجاج',
    'soup': 'شوربة',
    'salad': 'سلطة',
    'rice': 'أرز',
    'fried rice': 'أرز مقلي',
    'chicken curry': 'دجاج بالكاري',
    'grilled chicken': 'دجاج مشوي',
    'roast chicken': 'دجاج مشوي بالفرن',
    'fish pie': 'فطيرة السمك',
    'fish and chips': 'سمك وبطاطس',
    'chocolate cake': 'كيكة الشوكولاتة',
    'pancakes': 'بان كيك',
    'lasagne': 'لازانيا',
    'lasagna': 'لازانيا',
    'biryani': 'برياني',
    'falafel': 'فلافل',
    'hummus': 'حمص',
    'shakshuka': 'شكشوكة',
    'tacos': 'تاكو',
    'sushi': 'سوشي',
    'steak': 'ستيك',
  };

  static const Map<String, String> _arabicCategories = {
    'beef': 'لحم بقري',
    'chicken': 'دجاج',
    'dessert': 'حلويات',
    'lamb': 'لحم ضأن',
    'miscellaneous': 'متنوعات',
    'pasta': 'مكرونة',
    'pork': 'لحم خنزير',
    'seafood': 'مأكولات بحرية',
    'side': 'أطباق جانبية',
    'starter': 'مقبلات',
    'vegan': 'نباتي',
    'vegetarian': 'نباتي',
    'breakfast': 'إفطار',
    'goat': 'لحم ماعز',
  };

  static String translateName(String name, {required bool isArabic}) {
    if (!isArabic) return name;

    return _arabicNames[name.trim().toLowerCase()] ?? name;
  }

  static String translateCategory(
    String category, {
    required bool isArabic,
  }) {
    if (!isArabic) return category;

    return _arabicCategories[category.trim().toLowerCase()] ??
        category;
  }
}
