abstract class Converter {
  final String configFile;
  late final String type;

  Converter(this.configFile) {
    type = getTypeFromConfigFile(configFile);
  }

  String getTypeFromConfigFile(String configFile) {
    int dotPos = configFile.length - 5;
    for (int pos = configFile.length - 5; pos > -1; pos--) {
      if (configFile[pos] == '/' || configFile[pos] == '\\') {
        return configFile.substring(pos + 1, dotPos);
      }
    }
    throw ArgumentError('configFile not valid');
  }

  String convert(String text) {
    throw UnimplementedError('convert() has not been implemented.');
  }

  List<String> convertList(List<String> texts) {
    throw UnimplementedError('convertList() has not been implemented.');
  }

  void dispose() {
    // default no operation
  }
}
