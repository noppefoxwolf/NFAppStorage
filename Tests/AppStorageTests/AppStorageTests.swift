import XCTest
import SwiftUI
@testable import AppStorage

final class UserDefaultsTests: XCTestCase {
    let store: UserDefaults = UserDefaults.standard
    let key = "key"
    
    override func setUp() {
        super.setUp()
        let name = Bundle.main.bundleIdentifier!
        store.removePersistentDomain(forName: name)
    }
    
    func testString() {
        XCTAssertNil(store.object(forKey: key))
        store.set("default", forKey: key)
        XCTAssertEqual(store.object(forKey: key) as! String, "default")
    }
    
    func testInt() {
        XCTAssertNil(store.object(forKey: key))
        store.set(123, forKey: key)
        XCTAssertEqual(store.object(forKey: key) as! Int, 123)
    }
    
    func testDouble() {
        XCTAssertNil(store.object(forKey: key))
        store.set(123.4, forKey: key)
        XCTAssertEqual(store.object(forKey: key) as! Double, 123.4)
    }
    
    func testData() {
        XCTAssertNil(store.object(forKey: key))
        store.set(Data(capacity: 1234), forKey: key)
        XCTAssertEqual(store.object(forKey: key) as! Data, Data(capacity: 1234))
    }
    
    func testURL() {
        XCTAssertNil(store.object(forKey: key))
        store.set(URL(string: "http://a.bc")!, forKey: key)
        let url = store.url(forKey: key)
        XCTAssertEqual(url, URL(string: "http://a.bc")!)
    }
    
    static var allTests = [
        ("testString", testString),
    ]
}
