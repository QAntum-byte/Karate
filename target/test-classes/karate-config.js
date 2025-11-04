function fn() {
  var config = {};

  // Grocery API base URL
  config.groceryURL = "https://simple-grocery-store-api.click";

  // Common headers
  config.headers = {
    "Content-Type": "application/json",
    Accept: "application/json",
  };

  karate.configure("logPrettyRequest", true);
  karate.configure("logPrettyResponse", true);
  karate.configure("printEnabled", true);

  return config;
}
