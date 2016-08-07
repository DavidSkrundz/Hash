//
//  LinuxMain.swift
//  Hash
//

@testable import HashTests
import XCTest

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
