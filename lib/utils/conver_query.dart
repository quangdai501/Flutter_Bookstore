String convertQuery(var query) {
  // ignore: prefer_collection_literals
  Map<String, String> stringQueryParameters = Map<String, String>();
  query.forEach((key, value) => {
        if (value != null)
          {
            stringQueryParameters[key] =
                value.toString().replaceAll(RegExp(' '), '')
          }
      });
  return Uri(queryParameters: stringQueryParameters).query.toString();
}
