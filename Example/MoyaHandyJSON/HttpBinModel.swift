import Foundation
import HandyJSON

struct SlideModel: HandyJSON {
    var title: String?
    var type: String?
    var items: [String?]?
}

struct UrlModel: HandyJSON {
    var url: String?
}
