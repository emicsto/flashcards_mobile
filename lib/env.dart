const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl': 'http://10.0.2.2:8080/api',
};

const productionConfig = {
  'baseUrl': 'https://app-flashcards.herokuapp.com/api',
};

final environment = isProduction ? productionConfig : testConfig;