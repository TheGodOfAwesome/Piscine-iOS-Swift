import Foundation

class Deck : NSObject {

    static let allHearts = Value.allValues.map { 
        (number) -> Card in
            var card = Card(color: Color.Heart, value: number);
        return card;
    }

    static let allDiamonds = Value.allValues.map { 
        (number) -> Card in
            var card = Card(color: Color.Diamond, value: number);
        return card;
    }

    static let allSpades = Value.allValues.map { 
        (number) -> Card in
            var card = Card(color: Color.Spade, value: number);
        return card;
    }

    static let allClubs = Value.allValues.map { 
        (number) -> Card in
            var card = Card(color: Color.Club, value: number);
        return card;
    }

    static let allCards = allHearts  + allDiamonds + allSpades + allClubs;
}