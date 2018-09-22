//
//  LinuxMain.swift
//  Hash
//

import XCTest
@testable import HashTests

XCTMain([
	testCase(MD2Tests.allTests.shuffled()),
	testCase(MD4Tests.allTests.shuffled()),
	testCase(MD5Tests.allTests.shuffled()),
	testCase(SHA0Tests.allTests.shuffled()),
	testCase(SHA1Tests.allTests.shuffled()),
	testCase(SHA2_224Tests.allTests.shuffled()),
	testCase(SHA2_256Tests.allTests.shuffled()),
	testCase(SHA2_384Tests.allTests.shuffled()),
	testCase(SHA2_512Tests.allTests.shuffled()),
	testCase(SHA3_224Tests.allTests.shuffled()),
	testCase(SHA3_256Tests.allTests.shuffled()),
	testCase(SHA3_384Tests.allTests.shuffled()),
	testCase(SHA3_512Tests.allTests.shuffled()),
])
