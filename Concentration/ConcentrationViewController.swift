//
//  ViewController.swift
//  Concentration
//
//  Created by Adrian on 2017/11/28.
//  Copyright © 2017 Adrian. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }
    
    private let attributes: [NSAttributedStringKey: Any] = [
        .strokeWidth: 5.0,
        .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    ]
    
    private func updateFlipCountLabel() {
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreLabel() {
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: attributes)
        scoreLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
        chooseRandomTheme()
        updateViewFromModel()
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            updateFlipCountLabel()
            updateScoreLabel()
            view.backgroundColor = backgroundColor
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
        
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    let backgroundColors = [#colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)]
    
    private(set) var backgroundColor: UIColor!
    private var emojiChoices = "🎃👻🐲☃️🦉🦇🐺🕷🦂🐍🦅🦑"
    private var emoji = [Card: String]()
    
    func chooseRandomTheme() {
        let randomThemeNumber = backgroundColors.count.arc4random
//        emojiChoices = themes[randomThemeNumber]
        backgroundColor = backgroundColors[randomThemeNumber]
//        emoji = [:]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseRandomTheme()
        view.backgroundColor = backgroundColor
    }

    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}












