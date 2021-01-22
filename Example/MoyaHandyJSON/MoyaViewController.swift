import UIKit
import Moya
import MoyaHandyJSON

class MoyaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = view.bounds
        view.addSubview(label)
        
        // 初始化MoyaProvider
        let provider = MoyaProvider<WeatherApi>()
        // 获取北京的天气预报
        provider.request(.city("北京")) { (result) in
            switch result {
            case let .success(res):
                // 反序列化为model数组
                if let weathers = try? res.mapArray(WeatherModel.self, designatedPath: "data.forecast") {
                    if let weather = weathers.first {
                        // 显示北京的天气
                        label.text = "\(weather?.date ?? "")\n\(weather?.type ?? "")\n\(weather?.high ?? "高温未知"), \(weather?.low ?? "低温未知")"
                    } else {
                        label.text = "天气获取失败(2)"
                    }
                } else {
                    label.text = "天气获取失败(1)"
                }
            default:
                label.text = "天气获取失败(0)"
                break
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
