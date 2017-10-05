//
//  LinuxMain.swift
//  Hash
//

import XCTest
@testable import HashTests

XCTMain([
	testCase(MD2Tests.allTests),
	testCase(MD4Tests.allTests),
	testCase(MD5Tests.allTests),
	testCase(SHA1Tests.allTests),
	testCase(SHA2_224Tests.allTests),
	testCase(SHA2_256Tests.allTests),
	testCase(SHA2_384Tests.allTests),
	testCase(SHA2_512Tests.allTests),
	testCase(SHA3_224Tests.allTests),
	testCase(SHA3_256Tests.allTests),
	testCase(SHA3_384Tests.allTests),
	testCase(SHA3_512Tests.allTests),
])
