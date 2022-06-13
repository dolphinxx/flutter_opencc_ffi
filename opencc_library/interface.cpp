#include <malloc.h>
#include <cstring>
#include "OpenCC/src/Converter.hpp"
#include "OpenCC/src/Config.hpp"

extern "C"
{
  const char* opencc_convert(const char* text, const char* configFile) {
    opencc::Config config;
    opencc::ConverterPtr converter = config.NewFromFile(configFile);

    std::string s = converter->Convert(text);

    char* r = strcpy(new char[s.length()], s.c_str());

    return r;
  }

  char** opencc_convert_list(char** list, int size, const char* configFile) {
    opencc::Config config;
    opencc::ConverterPtr converter = config.NewFromFile(configFile);
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