import Foundation
import RxSwift
import Moya
import HandyJSON
import Metal

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapObject<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Single<T> {
        flatMap { Single.just(try $0.mapObject(type, designatedPath: designatedPath)) }
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) -> Single<[T]> {
        flatMap { Single.just(try $0.mapArray(type, designatedPath: designatedPath)) }
    }
    
}
