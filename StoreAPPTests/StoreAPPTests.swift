//
//  StoreAPPTests.swift
//  StoreAPPTests
//
//  Created by Fernando de Lucas da Silva Gomes on 19/11/20.
//

import XCTest
@testable import StoreAPP

class StoreAPPTests: XCTestCase {

	weak var appDelegate: AppDelegate!
	weak var application: UIApplication!

	override func setUp() {
		super.setUp()
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("No App Delegate")
		}
		self.appDelegate = appDelegate
		self.application = UIApplication.shared
	}

	override func tearDown() {
		self.appDelegate = nil
		self.application = nil
		super.tearDown()
	}

	func testDidFinishLaunching_True() {
		//given
		let options: [UIApplication.LaunchOptionsKey: Any]? = nil
		//when
		let sut = appDelegate.application(application, didFinishLaunchingWithOptions: options)
		//then
		XCTAssertTrue(sut)
	}

}
