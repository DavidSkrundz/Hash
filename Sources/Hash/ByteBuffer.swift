//
//  ByteBuffer.swift
//  Hash
//

internal struct ByteBuffer {
	internal var bytes = [Byte]()
	internal var totalLength: Long = 0
	
	internal var count: Int {
		return self.bytes.count
	}
	
	internal mutating func add(_ bytes: [Byte]) {
		self.bytes += bytes
		self.totalLength = self.totalLength &+ Long(bytes.count)
	}
}

internal func +=(lhs: inout ByteBuffer, rhs: [Byte]) {
	lhs.bytes += rhs
}
