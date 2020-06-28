# NFAppStorage

Backport of @AppStorage to earlier iOS 13.
[AppStorage](https://developer.apple.com/documentation/swiftui/appstorage) is UserDefaults binder available in iOS14.

# Usage

```
struct ContentView: View {
    @AppStorage("username") var username: String = "Anonymous"

    var body: some View {
        VStack {
            Text("Welcome, \(username)!")

            Button("Log in") {
                self.username = "@twostraws"
            }
        }
    }
}
```

# Requirements
- Swift 5.0+
- iOS 13.0+

# Installation

## Xcode SwiftPM

Add the following to your Xcode:

![](https://github.com/noppefoxwolf/NFAppStorage/blob/master/.github/xcode.png)

# Author

[noppefoxwolf](https://twitter.com/noppefoxwolf)

# License

The project is available under [MIT Licence](https://github.com/noppefoxwolf/NFAppStorage/blob/master/LICENSE)
