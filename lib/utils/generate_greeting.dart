String generateGreeting() {
  var hour = DateTime.now().hour;
  var greetings = [
    'Good morning!',
    'Good afternoon!',
    'Good evening!',
    'Hello!'
  ];
  if (hour < 12) {
    return greetings[0];
  } else if (hour < 18) {
    return greetings[1];
  } else {
    return greetings[2];
  }
}
