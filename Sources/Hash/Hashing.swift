//
//  Hashing.swift
//  Hash
//

public protocol Hashing {
	init()
	
	/// - Precondition: `finalize()` was never called
	mutating func hashData(_ data: [UInt8])
	
	/// - Precondition: `finalize()` was only called once
	mutating func finalize() -> Hash
}

extension Hashing {
	public static func hash(_ data: [UInt8]) -> Hash {
		var _self = Self()
		_self.hashData(data)
		return _self.finalize()
	}
}
