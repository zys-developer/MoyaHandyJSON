import Foundation
import Moya

enum HttpBinApi {
    case json, anything
}

extension HttpBinApi: TargetType {
    
    var baseURL: URL {
        URL(string: "http://www.httpbin.org/")!
    }
    
    var path: String {
        switch self {
        case .json:
            return "json"
        default:
            return "anything"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
