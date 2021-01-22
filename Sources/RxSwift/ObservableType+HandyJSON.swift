import Foundation
import RxSwift
import Moya
import HandyJSON

public extension ObservableType where E == Response {
    
    func mapObject<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Observable<T> {
        flatMap { Observable.just(try $0.mapObject(type, designatedPath: designatedPath)) }
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Observable<[T?]> {
        flatMap { Observable.just(try $0.mapArray(type, designatedPath: designatedPath)) }
    }
    
}
