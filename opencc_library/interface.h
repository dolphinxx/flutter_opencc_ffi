void opencc_init_converter(const char* type, const char* configFile);

char* opencc_convert(const char* text, const char* type);

char** opencc_convert_list(char** list, int size, const char* type);

void opencc_free_string(char *str);

void opencc_free_string_array(char **array, int size);

int opencc_dummy_method_to_enforce_bundling();