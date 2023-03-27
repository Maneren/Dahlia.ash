export __DH_CODE_REGEXES = [
  '~?[0-9a-gl-or]',
  '~?\\[#[0-9a-fA-F]{6}\\]'
];

export __DH_ANSI_REGEXES = [
	"\\x1b\\[[0-9]+m",
	"\\x1b\\[(3|4)8;5;[0-9]+m",
	"\\x1b\\[(3|4)8;2;[0-9]+;[0-9]+;[0-9]+m"
];

export __DH_DEPTHS = {
  HIGH: "24",
  MEDIUM: "8",
  LOW: "4",
  TTY: "3"
};

export __DH_FORMATTERS = {
  l: "1",
  m: "9",
  n: "4",
  o: "3",
  r: "0",
};

export __DH_COLORS_3BIT = {
  "0": "30",
  "1": "34",
  "2": "32",
  "3": "36",
  "4": "31",
  "5": "35",
  "6": "33",
  "7": "37",
  "8": "30",
  "9": "34",
  a: "32",
  b: "34",
  c: "31",
  d: "35",
  e: "33",
  f: "37",
  g: "33",
};

export __DH_COLORS_4BIT = {
  "0": "30",
  "1": "34",
  "2": "32",
  "3": "36",
  "4": "31",
  "5": "35",
  "6": "33",
  "7": "37",
  "8": "90",
  "9": "94",
  a: "92",
  b: "96",
  c: "91",
  d: "95",
  e: "93",
  f: "97",
};

export __DH_COLORS_8BIT = {
  "0": "0",
  "1": "19",
  "2": "34",
  "3": "37",
  "4": "124",
  "5": "127",
  "6": "214",
  "7": "248",
  "8": "240",
  "9": "147",
  a: "83",
  b: "87",
  c: "203",
  d: "207",
  e: "227",
  f: "15",
  g: "184",
};

export __DH_COLORS_24BIT = {
  "0": "0 0 0",
  "1": "0 0 170",
  "2": "0 170 0",
  "3": "0 170 170",
  "4": "170 0 0",
  "5": "170 0 170",
  "6": "255 170 0",
  "7": "170 170 170",
  "8": "85 85 85",
  "9": "85 85 255",
  a: "85 255 85",
  b: "85 255 255",
  c: "255 85 85",
  d: "255 85 255",
  e: "255 255 85",
  f: "255 255 255",
  g: "221 214 5",
};

export __DH_TEMPLATES = {
  "3": "\\x1b[%dm",
  "4": "\\x1b[%dm",
  "8": "\\x1b[38;5;%dm",
  "24": "\\x1b[38;2;%d;%d;%dm",
};

export __DH_BG_TEMPLATES = {
  "3": "\\x1b[%dm",
  "4": "\\x1b[%dm",
  "8": "\\x1b[48;5;%dm",
  "24": "\\x1b[48;2;%d;%d;%dm",
};
