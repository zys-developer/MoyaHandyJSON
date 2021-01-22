import UIKit
import MoyaHandyJSON
import RxSwift
import RxCocoa
import Moya

class ViewController: UIViewController {
    
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
        let provider = MoyaProvider<HttpBinApi>()
        // 请求数据并反序列化
        let items = provider.rx
            .request(.json)
            // designatedPath是要展开的节点,可以展开多个节点,用.隔开
            .mapArray(SlideModel.self, designatedPath: "slideshow.slides")
            // 捕获错误, 否则遇到断网等情况时会崩溃
            .catchError({ (_) -> PrimitiveSequence<SingleTrait, [SlideModel?]> in
                // 这里可以做一些处理, 比如错误提示
                // ...
                // 给一个默认的数据
                .just([])
            })
            .asObservable()
        // 将数据绑定到单元格上
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element?.title
            return cell
        }
        .disposed(by: disposeBag)
        
        // 点击单元格
        tableView.rx.itemSelected
            .subscribe(onNext: { _ in
                // 请求.anything接口
                provider.request(.anything) { (result) in
                    switch result {
                    case let .success(res):
                        // 反序列化为model
                        if let model = try? res.mapObject(UrlModel.self) {
                            // 打印url
                            print(model.url ?? "null")
                        }
                    default:
                        break
                    }
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

