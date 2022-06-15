#include <cstring>
#include <map>
#include <cstdlib>
#include "OpenCC/src/Converter.hpp"
#include "OpenCC/src/Config.hpp"

struct cmpByString {
  bool operator()(const char* a, const char* b) const {
    return strcmp(a, b) < 0;
  }
};

static std::map<const char*, opencc::ConverterPtr, cmpByString> converters;

extern "C"
{
  void opencc_init_converter(const char* type, const char* configFile) {
    opencc::Config config;
    opencc::ConverterPtr converter = config.NewFromFile(configFile);
    char* t = strcpy(new char[strlen(type)], type);
    converters[t] = converter;
  }

  char* opencc_convert(const char* text, const char* type) {
    opencc::ConverterPtr converter = converters[type];
    if(converter == nullptr) {
      return nullptr;
    }

    std::string s = converter->Convert(text);

    char* r = strcpy(new char[s.length()], s.c_str());

    return r;
  }

  char** opencc_convert_list(char** list, int size, const char* type) {
    opencc::ConverterPtr converter = converters[type];
    if(converter == nullptr) {
      return nullptr;
    }
    char** result = (char**)malloc(size * sizeof(char*));
    for(int i = 0;i < size;i++) {
      std::string s = converter->Convert((char*)list[i]);
      result[i] = (char*) malloc(s.length());
      strcpy(result[i], s.c_str());
    }
    return result;
  }

  void opencc_free_string(char *str) {
      free(str);
  }

  void opencc_free_string_array(char **array, int size) {
      for(int i = 0;i < size;i++) {
          free(array[i]);
      }
      free(array);
  }

  int opencc_dummy_method_to_enforce_bundling() {
    return 1;
  }
}