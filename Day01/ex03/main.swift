print("Starting Test File...\n");

print("\(Deck.allHearts)\n");
print("\(Deck.allDiamonds)\n");
print("\(Deck.allSpades)\n");
print("\(Deck.allClubs)\n");
print("\(Deck.allCards)\n");

var testHearts = Deck.allHearts; 
testHearts.shuffle();
var test = Deck.allCards;
test.shuffle();
print(testHearts);
print()
print(test);

print("\nFinished Tests");