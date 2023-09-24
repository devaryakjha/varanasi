String generateGreeting() {
  var hour = DateTime.now().hour;
  var greetings = [
    'Good morning!',
    'Good afternoon!',
    'Good evening!',
    'Hello!'
  ];
  if (hour < 12) {
    return '${greetings[0]} Ready for some music?';
  } else if (hour < 18) {
    return '${greetings[1]} How about some tunes?';
  } else {
    return '${greetings[2]} Time for some music?';
  }
}
