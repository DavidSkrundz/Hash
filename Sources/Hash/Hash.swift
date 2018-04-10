//
//  Hash.swift
//  Hash
//

public struct Hash: Equatable {
	public let bytes: [UInt8]
	
	internal init(bytes: [UInt8]) {
		self.bytes = bytes
	}
}

extension Hash: CustomStringConvertible {
	public var description: String {
		return self.bytes.hexString
	}
}
