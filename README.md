# **ImagePreview for SwiftUI**

A component that supports network image preview and zooming in and out of images using only SwiftUI.

[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS-blue?style=flat-square)](https://developer.apple.com/macOS)
[![iOS](https://img.shields.io/badge/iOS-13.0-blue.svg)](https://developer.apple.com/iOS)
[![macOS](https://img.shields.io/badge/macOS-11.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)  

## Screenshot
![Simulator Screenshot - iPhone 14 Pro - 2023-05-17 at 16 23 42](https://github.com/wangweiyang8887/ImagePreview/assets/11688908/bed6da18-5b50-4441-a771-578138f14885)

## Example Usages
1. ImagePreview
    ```swift
        ZStack {
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .onTapGesture {
                    withAnimation {
                        isPresented = true
                    }
                }
        }
        .overlay {
            ImagePreview(images: [ url ], currentIndex: .constant(0), isPresented: $isPresented)
        }
    ```

## Contact
email : [98708887@qq.com](98708887@qq.com)

## License
ImagePreview is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
