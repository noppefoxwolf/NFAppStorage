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

/// A property wrapper type that reflects a value from `UserDefaults` and
/// invalidates a view on a change in value in that user default.
@frozen @propertyWrapper public struct AppStorage<Value> : DynamicProperty {
    let storage: State<Value>
    public var projectedValue: Binding<Value> {
        storage.projectedValue
    }
    public var wrappedValue: Value {
        get { storage.wrappedValue }
        nonmutating set {
            store.setValue(newValue, forKey: key)
            store.synchronize()
            storage.wrappedValue = newValue
        }
    }
    private let store: UserDefaults
    private let key: String
}

extension AppStorage where Value == Bool {
    /// Creates a property that can read and write to a boolean user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a boolean value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value == Int {
    /// Creates a property that can read and write to an integer user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value == Double {
    /// Creates a property that can read and write to a double user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a double value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value == String {
    /// Creates a property that can read and write to a string user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.string(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value == URL {
    /// Creates a property that can read and write to a url user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a url value is not specified for
    ///     the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.url(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value == Data {
    /// Creates a property that can read and write to a user default as data.
    ///
    /// Avoid storing large data blobs in user defaults, such as image data,
    /// as it can negatively affect performance of your app. On tvOS, a
    /// `NSUserDefaultsSizeLimitExceededNotification` notification is posted
    /// if the total user default size reaches 512kB.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a data value is not specified for
    ///    the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.data(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value : RawRepresentable, Value.RawValue == Int {
    /// Creates a property that can read and write to an integer user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: Int {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @AppStorage("MyEnumValue") private var value = MyEnum.a
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}

extension AppStorage where Value : RawRepresentable, Value.RawValue == String {
    /// Creates a property that can read and write to a string user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: String {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @AppStorage("MyEnumValue") private var value = MyEnum.a
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: wrappedValue)
        }
    }
}



extension AppStorage where Value == Bool? {
    /// Creates a property that can read and write an Optional boolean user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}

extension AppStorage where Value == Int? {
    /// Creates a property that can read and write an Optional integer user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}

extension AppStorage where Value == Double? {
    /// Creates a property that can read and write an Optional double user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.object(forKey: key) as? Value {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}

extension AppStorage where Value == String? {
    /// Creates a property that can read and write an Optional string user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.string(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}

extension AppStorage where Value == URL? {
    /// Creates a property that can read and write an Optional URL user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.url(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}

extension AppStorage where Value == Data? {
    /// Creates a property that can read and write an Optional data user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) {
        self.store = store ?? UserDefaults.standard
        self.key = key
        if let value = self.store.data(forKey: key) {
            self.storage = .init(wrappedValue: value)
        } else {
            self.storage = .init(wrappedValue: nil)
        }
    }
}
