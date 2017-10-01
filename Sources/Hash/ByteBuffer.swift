//
//  ByteBuffer.swift
//  Hash
//

internal struct ByteBuffer {
	private var bytes = [Byte]()
	private var totalLength: UInt64 = 0
	
	/// The number of bytes currently in the buffer
	internal var count: Int {
		return self.bytes.count
	}
	
	/// The total number of bytes that were added to the buffer
	///
	/// - Note: Can overflow without error
	internal var length: UInt64 {
		return self.totalLength
	}
	
	/// Append bytes to the end of the buffer
	internal mutating func append(_ bytes: [Byte], shouldCount: Bool = true) {
		self.bytes += bytes
		if shouldCount {
			self.totalLength = self.totalLength &+ UInt64(bytes.count)
		}
	}
	
	/// Removes the specified number of bytes from the beginning of the buffer.
	///
	/// - Returns: The bytes that were removed
	internal mutating func processBytes(_ count: Int) -> [Byte] {
		defer { self.bytes.removeFirst(count) }
		return Array(self.bytes.prefix(count))
	}
}
