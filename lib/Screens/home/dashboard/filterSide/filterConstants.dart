List<String> majorCategories = [
  'Stationary',
  'Electronics & Accessories',
  'Clothing',
  'Furniture',
  'Automobile',
  'Books',
  'Sport Items'
];
Map<String, List<String>> subCategories = {
  'Stationary': ['Notebooks', 'Pens', 'Markers'],
  'Electronics & Accessories': ['Mobile Phones', 'Laptops', 'Tablets'],
  'Clothing': ['T-Shirts', 'Jeans', 'Dresses'],
  'Furniture': ['Sofas', 'Tables', 'Chairs'],
  'Books': ['Fiction', 'Non-fiction', 'Science Fiction'],
  'Sport Items': ['Football', 'Basketball', 'Tennis'],
  'Automobile': ['Cars', 'Motorcycles', 'Bicycles'],
};

Map<String, bool> isExpanded = {
  'Stationary': false,
  'Electronics': false,
  'Clothing': false,
  'Furniture': false,
  'Automobile': false,
  'Books': false,
  'Sport Items': false
};
