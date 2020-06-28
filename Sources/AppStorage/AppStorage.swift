//
//  AppStorage.swift
//  NFAppStorage
//
//  Created by noppefoxwolf on 2020/06/28.
//  Copyright © 2020 noppefoxwolf. All rights reserved.
//


import Foundation
import Combine
import SwiftUI

@frozen
@propertyWrapper
public struct AppStorage<Value>: DynamicProperty {
    let storage: State<Value>
    public var projectedValue: Binding<Value> {
        storage.projectedValue
    }
    public var wrappedValue: Value {
        get { storage.wrappedValue }
        nonmutating set { storage.wrappedValue = newValue }
    }
    private let store: UserDefaults
    private let key: String
}

/// String

public extension AppStorage where Value == String {
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        self.storage = .init(wrappedValue: wrappedValue)
    }
    
    func update() {
        store.setValue(wrappedValue, forKey: key)
        store.synchronize()
    }
}
//
//public extension AppStorage where Value == Optional<String> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.string(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
///// Int
//
//public extension AppStorage where Value == Int {
//    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.integer(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
//public extension AppStorage where Value == Optional<Int> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.integer(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
///// Double
//
//public extension AppStorage where Value == Double {
//    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.double(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
//public extension AppStorage where Value == Optional<Double> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.double(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
///// Data
//
//public extension AppStorage where Value == Data {
//    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.data(forKey: key) ?? Data()
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
//public extension AppStorage where Value == Optional<Data> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.data(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
///// Bool
//
//public extension AppStorage where Value == Bool {
//    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.bool(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
//public extension AppStorage where Value == Optional<Bool> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.bool(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
///// URL
//
//public extension AppStorage where Value == URL {
//    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.url(forKey: key) ?? URL(fileURLWithPath: "")
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
//
//public extension AppStorage where Value == Optional<URL> {
//    init(_ key: String, store: UserDefaults? = nil) {
//        let store = store ?? UserDefaults.standard
//        self._projectedValue = Binding(get: {
//            store.url(forKey: key)
//        }, set: { (newValue) in
//            store.set(newValue, forKey: key)
//        })
//        self.store = store
//    }
//}
