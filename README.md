# **ImagePreview for SwiftUI**

A component that supports network image preview and zooming in and out of images using only SwiftUI.
Also support drag and tap to dismiss.

[![](https://img.shields.io/badge/language-SwiftUI-orange)](https://developer.apple.com/iOS)
[![](https://img.shields.io/badge/language-Swift-orange)](https://developer.apple.com/iOS)

## Screenshot
<img src="https://github.com/wangweiyang8887/ImagePreview/assets/11688908/bed6da18-5b50-4441-a771-578138f14885" width="200px">

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

## License
ImagePreview is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
