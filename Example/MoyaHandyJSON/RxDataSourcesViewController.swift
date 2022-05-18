import UIKit
import Moya
import RxCocoa
import RxSwift
import MoyaHandyJSON
import RxDataSources

class RxDataSourcesViewController: UIViewController {
    
    var tableView:UITableView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 创建表格视图
        tableView = UITableView(frame: view.bounds, style:.plain)
        // 注册单元格
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // 添加到视图上
        view.addSubview(tableView)
        
        // 初始化MoyaProvider
        let provider = MoyaProvider<WeatherApi>()
        // 请求数据并反序列化
        let items = provider.rx
            .request(.city("北京"))
            // designatedPath是要展开的节点,可以展开多个节点,用.隔开
            .mapArray(WeatherModel.self, designatedPath: "data.forecast")
            // 捕获错误, 否则遇到断网等情况时会崩溃
            .catchAndReturn([])
            .asObservable()
            .map({ (weathers) -> [SectionModel<String, WeatherModel>] in
                [SectionModel(model: "", items: weathers)]
            })
        // 数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, WeatherModel>> { (dataSource, tableView, indexPath, element) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(element.date ?? ""), \(element.type ?? ""), \(element.high ?? "高温未知"), \(element.low ?? "低温未知")"
            return cell
        }
        // 绑定数据源
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
