const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl': 'http://192.168.0.192:8080/api',
};

const productionConfig = {
  'baseUrl': 'http://192.168.0.192:8080/api',
};

final environment = isProduction ? productionConfig : testConfig;