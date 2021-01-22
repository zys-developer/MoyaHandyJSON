import Foundation
import Moya

enum WeatherApi {
    case city(String)
}

extension WeatherApi: TargetType {
    var baseURL: URL {
        URL(string: "http://wthrcdn.etouch.cn/")!
    }
    
    var path: String {
        "weather_mini"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .city(let city):
            return .requestParameters(parameters: ["city": city], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
