import Foundation
import RxSwift
import Moya
import HandyJSON
import RxDataSources

public extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
//    typealias HandyJSONSectionModel = SectionModel where Trait == HandyJSON
    
//    func mapItems<T: HandyJSONSectionModelType>(_ type: T.Type, designatedPath: String? = nil) -> /*Single<T>*/Void {
//        flatMap { Single.just(try $0.mapObject(type, designatedPath: designatedPath)) }
//        _ = flatMap { (response) -> Single<[T.Item?]> in
//            Single.just(try response.mapArray(type.Item, designatedPath: designatedPath))
//        }
//    }
    
//    func mapItems<Value>(_ type: Value.Type, designatedPath: String? = nil) -> Void where Value: HandyJSONSectionModelType {
//        flatMap { (response) -> Single<[Value.Item?]> in
//            .just(try response.mapArray(Value.Item, designatedPath: designatedPath))
//        }
//    }
    
    func mapItems<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Single<[SectionModel<String, T?>]> {
        flatMap { Single.just(try $0.mapArray(type, designatedPath: designatedPath)) }
            .map { (array) -> [SectionModel<String, T?>] in
                [SectionModel(model: "", items: array)]
            }
    }
    
//    func mapArray<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Single<[T?]> {
//        flatMap { Single.just(try $0.mapArray(type, designatedPath: designatedPath)) }
//    }
    
}

public protocol HandyJSONSectionModelType: SectionModelType where Item == HandyJSON {
    
}
