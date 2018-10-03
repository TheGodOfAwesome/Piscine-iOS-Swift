import Foundation

class Card : NSObject {
    var cardColor: Color;
    var cardValue: Value;

    init(color: Color, value: Value) {
        self.cardColor = color;
        self.cardValue = value;
        super.init();
    }

    convenience override init() {
        self.init(color: Color.Spade, value: Value.Two);
    }  

    override var description: String {
        return "\(cardValue.rawValue), \(cardColor)"
    }

    override func isEqual(_ object: Any?) -> Bool{
        if let object = object as? Card {
            return ((cardValue == object.cardValue) && (cardColor == object.cardColor));
        }
        return false;
    }

}