const greetings = [
  'Good morning!',
  'Good afternoon!',
  'Good evening!',
  'Hello!'
];

String generateGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return greetings[0];
  } else if (hour < 18) {
    return greetings[1];
  } else {
    return greetings[2];
  }
}
