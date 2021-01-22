import Foundation
import HandyJSON
import Moya


public extension Response {
    
    /// 反序列化为模型对象
    /// - Parameters:
    ///   - type: 目标类型
    ///   - designatedPath: 指定路径, 即将该路径下的内容反序列化为模型
    /// - Throws: MoyaError.jsonMapping
    /// - Returns: 模型实例
    func mapObject<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) throws -> T {
        guard let json = try mapJSON() as? [String: Any],
              let object = T.deserialize(from: json, designatedPath: designatedPath)
        else { throw MoyaError.jsonMapping(self) }
        return object
    }
    
    /// 反序列化为模型数组
    /// - Parameters:
    ///   - type: 目标类型
    ///   - designatedPath: 指定路径, 即将该路径下的内容反序列化为模型数组
    /// - Throws: MoyaError.jsonMapping
    /// - Returns: 模型数组
    func mapArray<T: HandyJSON>(_ type: T.Type, designatedPath: String? = nil) throws -> [T?] {
        guard let dataString = String(data: self.data, encoding: .utf8),
              let object = [T].deserialize(from: dataString, designatedPath: designatedPath)
        else { throw MoyaError.jsonMapping(self) }
        return object
    }
    
}
