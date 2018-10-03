print("Starting Test File...\n");

let c1 = Card(color: Color.Heart, value: Value.Ace);
let c2 = Card(color: Color.Spade, value: Value.King);
//let c2 = Card(color: Color.Heart, value: Value.Ace);

print("Card 1 color \(c1.cardColor) and value \(c1.cardValue)");
print("Card 2 color \(c2.cardColor) and value \(c2.cardValue)");
print(c1);
print(c2);
print(c1 == c2);

print("\nFinished Tests");