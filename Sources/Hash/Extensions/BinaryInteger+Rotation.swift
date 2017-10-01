//
//  BinaryInteger+Rotation.swift
//  Hash
//

infix operator <<< : BitwiseShiftPrecedence
infix operator >>> : BitwiseShiftPrecedence

internal func >>> <LHS: BinaryInteger, RHS: BinaryInteger>(lhs: LHS,
                                                           rhs: RHS) -> LHS {
	return (lhs >> rhs) | (lhs << (RHS(MemoryLayout<LHS>.size * 8) - rhs))
}

internal func <<< <LHS: BinaryInteger, RHS: BinaryInteger>(lhs: LHS,
                                                           rhs: RHS) -> LHS {
	return (lhs << rhs) | (lhs >> (RHS(MemoryLayout<LHS>.size * 8) - rhs))
}
