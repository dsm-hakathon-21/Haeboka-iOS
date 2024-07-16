import UIKit

public extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        assert(hexString.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    static let Blue100 = UIColor(hex: "#D0E1FF")
    static let Blue200 = UIColor(hex: "#A1C4FF")
    static let Blue300 = UIColor(hex: "#729EFF")
    static let Blue400 = UIColor(hex: "#407FFF")
    static let Primary = UIColor(hex: "#0056FF")
    static let Blue600 = UIColor(hex: "#0049E6")
    static let Blue700 = UIColor(hex: "#003BB3")
    static let Blue800 = UIColor(hex: "#002C80")
    static let Blue900 = UIColor(hex: "#001D4D")

    static let Black = UIColor(hex: "#000000")
    static let Gray900 = UIColor(hex: "#1A1A1A")
    static let Gray800 = UIColor(hex: "#333333")
    static let Gray700 = UIColor(hex: "#4D4D4D")
    static let Gray600 = UIColor(hex: "#666666")
    static let Gray500 = UIColor(hex: "#808080")
    static let Gray400 = UIColor(hex: "#999999")
    static let Gray300 = UIColor(hex: "#B3B3B3")
    static let Gray200 = UIColor(hex: "#CCCCCC")
    static let Gray100 = UIColor(hex: "#E6E6E6")
    static let Gray50 = UIColor(hex: "#F2F2F2")
    static let White = UIColor(hex: "#FFFFFF")

    static let Green = UIColor(hex: "#00FF00")
    static let Green100 = UIColor(hex: "#CCFFCC")
    static let MainGreen = UIColor(hex: "#335E54")

    static let Red = UIColor(hex: "#FF0000")
    static let Red100 = UIColor(hex: "#FFCCCC")
}

public extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
