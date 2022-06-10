// for ffigen
const char* convert(const char* text, const char* configFile);

char** convertList(char** list, int size, const char* configFile);

void free_string(char *str);

void free_string_array(char **array, int size);