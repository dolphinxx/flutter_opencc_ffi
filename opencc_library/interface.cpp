#include <cstring>
#include <map>
#include "OpenCC/src/Converter.hpp"
#include "OpenCC/src/Config.hpp"

static std::map<int, opencc::ConverterPtr> converters;
static int idIncrement = 0;

extern "C"
{
  int opencc_init_converter(const char* configFile) {
    opencc::Config config;
    opencc::ConverterPtr converter = config.NewFromFile(configFile);
    int id = idIncrement++;
    converters[id] = converter;
    return id;
  }

  void opencc_delete_converter(int id) { 
    std::map<int, opencc::ConverterPtr>::iterator it = converters.find(id);
    if (it != converters.end())
      converters.erase(it);
  }

  char* opencc_convert(const char* text, int id) {
    opencc::ConverterPtr converter = converters[id];
    if(converter == nullptr) {
      return nullptr;
    }

    std::string s = converter->Convert(text);

    char* r = strcpy(new char[s.length() + 1], s.c_str());

    return r;
  }

  char** opencc_convert_list(char** list, int size, int id) {
    opencc::ConverterPtr converter = converters[id];
    if(converter == nullptr) {
      return nullptr;
    }
    char** result = (char**)malloc(size * sizeof(char*));
    for(int i = 0;i < size;i++) {
      std::string s = converter->Convert((char*)list[i]);
      result[i] = new char[s.length() + 1];
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