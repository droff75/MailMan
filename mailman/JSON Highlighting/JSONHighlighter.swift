import Foundation
import Highlightr

class JSONHighlighter {
    private static var highlightr: Highlightr? {
        let highlighter = Highlightr()
        highlighter?.setTheme(to: "xcode")
        if let font = UIFont(name: "Menlo", size: 20) {
            highlighter?.theme.codeFont = font
        }
        return highlighter
    }
    
    private static func string(forDictionary dictionary: [String:Any]) -> String {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let stringData = String(data: data!, encoding: .utf8)!
        return stringData
    }
    
    static func format(json: [String:Any]?) -> NSAttributedString? {
        guard let json = json else { return nil }
        
        let jsonString = string(forDictionary: json)
        return highlightr?.highlight(jsonString, as: "json")
    }
}
