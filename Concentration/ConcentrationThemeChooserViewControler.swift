//
//  ConcentrationThemeChooserViewControlerViewController.swift
//  Concentration
//
//  Created by Adrian on 2018/02/23.
//  Copyright © 2018 Adrian. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewControler: UIViewController, UISplitViewControllerDelegate {

    let themes = ["Halloween": "🎃👻🐲☃️🦉🦇🐺🕷🦂🐍🦅🦑",
                  "Faces": "😀😆😂🤣☺️😇😍😜😎😡😱😓",
                  "Hands": "👏👐👊👍👎🤟👌🖐🤙✍️🙏💪",
                  "Flags": "🇵🇱🇨🇳🇯🇵🇺🇸🇹🇭🇦🇺🇫🇷🏴󠁧󠁢󠁥󠁮󠁧󠁿🇩🇪🇰🇷🇪🇸🇺🇦",
                  "Vehicles": "🚗🚚🚌🛴🚲🚠🚄✈️🚁⛵️🚀🚢",
                  "Fruits": "🍎🍋🍇🍉🍓🍌🍒🥝🍍🍑🥥🍐"]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let concentrationViewController = secondaryViewController as? ConcentrationViewController {
            if concentrationViewController.theme == nil {
                return true
            }
        }
        return false
    }

    @IBAction func changeTheme(_ sender: UIButton) {
        if let concentrationViewController = splitViewDetailConcentrationController {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                concentrationViewController.theme = theme
            }
        } else if let concentrationViewController = lastSeguedToConcentrationViewController {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                concentrationViewController.theme = theme
            }
            navigationController?.pushViewController(concentrationViewController, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    
    // MARK: - Navigation
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let concentrationViewController = segue.destination as? ConcentrationViewController {
                        concentrationViewController.theme = theme
                        lastSeguedToConcentrationViewController = concentrationViewController
                    }
                }
        }
    }
    

}
