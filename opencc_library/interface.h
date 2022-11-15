int opencc_init_converter(const char* configFile);

void opencc_delete_converter(int id);

char* opencc_convert(const char* text, int id);

char** opencc_convert_list(char** list, int size, int id);

void opencc_free_string(char *str);

void opencc_free_string_array(char **array, int size);

int opencc_dummy_method_to_enforce_bundling();