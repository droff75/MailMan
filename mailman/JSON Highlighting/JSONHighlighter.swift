import Foundation
import Highlightr

class JSONHighlighter {
    private static var highlightr: Highlightr? {
        let thing = Highlightr()
        thing?.setTheme(to: "paraiso-dark")
        if let font = UIFont(name: "Menlo", size: 20) {
            thing?.theme.codeFont = font
        }
        return thing
    }
    
    private static func string(forDictionary dictionary: [String:Any]) -> String {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let thing = String(data: data!, encoding: .utf8)!
        return thing
    }
    
    static func format(json: [String:Any]?) -> NSAttributedString? {
        guard let json = json else { return nil }
        
        let jsonString = string(forDictionary: json)
        return highlightr?.highlight(jsonString, as: "json")
    }
}
