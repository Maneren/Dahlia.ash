import "./lib.ash";

switch $1 {
  case "--help|help" {
	  echo('Dahlia — a simple text formatting package, inspired by the game Minecraft.');
	  echo('');
	  echo('Usage:');
	  echo('  dahlia.sh [--] TEXT');
	  echo('  dahlia.sh clean|clean_ansi TEXT');
	  echo('  dahlia.sh test');
	  echo('');
	  echo('Configuration:');
	  echo('  DAHLIA_MARKER - specify what marker to use (default is &)');
	  echo('  DAHLIA_DEPTH - color depth - TTY, LOW, MEDIUM, HIGH (default is HIGH)');
	  echo('  DAHLIA_NORESET - if truthy don\'\\'\'t reset after print (default is false)');
	  echo('  DAHLIA_NO_COLOR - if truthy remove convert works like clean (default is the value of $NO_COLOR)');
  }
  case "--" { dahlia("${@:2}"); }
  case "test" { dahlia_test(); }
  case "clean" { dahlia_clean("${@:2}"); }
  case "clean_ansi" { dahlia_clean_ansi("${@:2}"); }
  case "*" { dahlia(@); }
}
