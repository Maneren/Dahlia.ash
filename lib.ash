external NO_COLOR, DAHLIA_NO_COLOR, DAHLIA_NO_RESET, DAHLIA_MARKER, DAHLIA_DEPTH;

import "./constants.ash";

// set default values if not set already
if !DAHLIA_MARKER {
  export DAHLIA_MARKER = "&";
}
if !DAHLIA_NO_RESET {
  export DAHLIA_NO_RESET = 0;
}
if !DAHLIA_DEPTH {
  export DAHLIA_DEPTH = "HIGH";
}
if !DAHLIA_NO_COLOR {
  export DAHLIA_NO_COLOR = "0";
}

fn dahlia_clean() {
  let msg = "$*";

  if ! msg || msg == "-" {
		for line in "${(@f)\"$(</dev/stdin)\"}" {
			msg += line;
		}
	}

  for regex in __DH_CODE_REGEXES {
    regex = "${DAHLIA_MARKER}${regex}";

    let patterns = "$msg" | grep(-ohE, "$regex") | sort() | uniq();

    if !patterns { continue; }

    for code in "${(f)patterns}" {
      msg = "${msg//\"$code\"/}";
    }
  }

  echo(msg);
}

fn dahlia_clean_ansi() {
  let msg = "$*";

  if ! msg || msg == "-" {
		for line in "${(@f)\"$(</dev/stdin)\"}" {
			msg += line;
		}
	}

  for regex in __DH_ANSI_REGEXES {
    let patterns = "$msg" | grep(-ohE, printf(regex)) | sort() | uniq();

    if !patterns { continue; }

    for code in "${(f)patterns}" {
      msg = "${msg//\"$code\"/}";
    }
  }

  echo(msg);
}

fn __dh_get_ansi(code, depth) {
	let bg = 0;
	let color = "${code/$DAHLIA_MARKER/}";
  let formats = "__DH_TEMPLATES";

	if code == "*~*" {
		formats = "__DH_BG_TEMPLATES";
		color = "${code/$DAHLIA_MARKER~/}";
		bg = 1;
	}

  if "${#color}" == 9 {
    printf("${${(P)formats}[24]}", "0x${color:2:2}", "0x${color:4:2}", "0x${color:6:2}");
    return 0;
  }

  if __DH_FORMATTERS[color] {
    printf("${${(P)formats}[3]}", __DH_FORMATTERS[color]);
    return 0;
  }

  let template = "${${(P)formats}[$depth]}";

  let color_map_name = "__DH_COLORS_${depth}BIT";
  let value = "${${(P)color_map_name}[$color]}";

  if ! value {
    return 1;
  }

  if depth == __DH_DEPTHS["HIGH"] {
		printf(template, "${=value}");
		return 0;
	}

	if bg == "1" && depth <= __DH_DEPTHS["LOW"] {
	  value = $(value + 10);
	}

	printf(template, value);
}

fn dahlia_test() {
	let marker = DAHLIA_MARKER;
	let str = "";

	let colors = "0123456789abcdefg";

	let i = 1;
	while i <= "${#colors}" {
	  let ch = colors[i];
    str += "${marker}${ch}${ch}";

    $(i += 1);
	}

  let formats = "lmno";

	i = 1;
	while i <= "${#formats}" {
	  let ch = formats[i];
    str += "${marker}${ch}${ch}${marker}r";

    $(i += 1);
	}

	dahlia(str);
}

fn dahlia() {
  fn is_truthy(value) {
    return value == "1" || value == "true" ? 0 : 1;
  } 
  fn is_falsy(value) {
    return value == "0" || value == "false" ? 0 : 1;
  }
  fn error() {
		echo("DahliaError: $*");
	}

	let msg = "$*";

  if is_truthy(NO_COLOR) || is_truthy(DAHLIA_NO_COLOR) {
    dahlia_clean(msg);
    return 0;
  }

	if !DAHLIA_MARKER {
	  error("Empty marker");
	  return 1;
	}

	let	depth = "${(U)DAHLIA_DEPTH}";
	if !__DH_DEPTHS[depth] {
		error("Invalid depth: '$DAHLIA_DEPTH'");
		return 1;
	}
	depth = __DH_DEPTHS[depth];

  let reset = "${DAHLIA_MARKER}r";

  if ! msg ~ "${reset}$" && is_falsy(DAHLIA_NO_RESET)  {
    msg += reset;
  }

  for regex in __DH_CODE_REGEXES {
    regex = "${DAHLIA_MARKER}${regex}";

    let patterns = msg | grep(-ohE, regex) | sort() | uniq();

    if !patterns { continue; }

    for code in "${(f)patterns}" {
      if let ansi = __dh_get_ansi(code, depth) {
        msg = "${msg//\"$code\"/\"$ansi\"}";
      } else {
        echo("Invalid code: '$code'");
        return 1;
      }
    }
  }

  echo(msg);
}
