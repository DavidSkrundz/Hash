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
	testCase(SHA224Tests.allTests),
	testCase(SHA256Tests.allTests),
	testCase(SHA384Tests.allTests),
	testCase(SHA512Tests.allTests),
])
