//
//  DecoderExt.swift
//  NALS_Test
//
//  Created by Thien Luong Q. VN.Danang on 18/02/2022.
//

extension Decoder {

    func decode<T: Decodable, K: CodingKey>(_ key: K, as type: T.Type = T.self) -> T? {
        if let container = try? self.container(keyedBy: K.self) {
            return try? container.decode(type, forKey: key)
        } else {
            return nil
        }
    }
}
