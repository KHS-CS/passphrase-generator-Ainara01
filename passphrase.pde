// Core functionality:
// We have list of number to word mappings
// Generate a word:
//   Roll Five Dice (d6)
//   Combine the dice roll results into a 5-digit number
//   Use that number to look up the word
//   Record the word
// Keep generating words

// Side quests:
//   Add as many words as we like
//   Displaying words (keeping things on the screen)
//   Alter the words 
//     capitalize
//     all caps
//     substitutions (zero for the letter 'o', etc.)
//     add numbers or special characters 
//   Delete words
//   copy-paste?
//   More efficient data structure to hold the words
//   Base 6 encoding

HashMap<Integer,String> wordsDictionary = new HashMap<>();
String word = "";

void setup() { 
  size(1000,800);
  String[] lines = loadStrings("eff_large_wordlist.txt");
  for (int i = 0 ; i < lines.length; i++) {
    String[] results = lines[i].split("\t");
    String number = results[0];
    String word = results[1];
    //number = substractOneFromEachDigit(number);
    wordsDictionary.put(fromSixToTen(number), word);
  }
  textSize(48);
  noLoop();
}

void keyPressed() {
  String lookupString = "";
  for( int i = 0; i < 5; i++ ) {
    lookupString += int(random(0,6)) + 1;
  }
  int lookupInt = fromSixToTen(lookupString);
  word += wordsDictionary.get(lookupInt);
  redraw();
}

void draw() {
  showText(word);
}
void showText(String text) {
  background(240);
  fill(120);
  float w = textWidth(text);
  text(text,width/2-w/2,height/2);
}

String substractOneFromEachDigit(String number) {
  String result = "";
  for (int i = 0; i < number.length(); i++) {
    int modified = Character.getNumericValue(number.charAt(i)) - 1;
    result += modified;
  }
  return result;
}
int fromSixToTen(String number) {
  int result = 0;
  for (int i = 0; i < number.length(); i++) {
    int multiplier = (int) pow(6, number.length() - 1 - i);
    int numAtPos = Character.getNumericValue(number.charAt(i));
    result += numAtPos * multiplier;
  }
  return result;
}
int fromSixToTen(int number) {
  return fromSixToTen(Integer.toString(number));
}
