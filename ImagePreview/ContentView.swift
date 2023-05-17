//
//  ContentView.swift
//  ImagePreview
//
//  Created by evan on 2023/5/17.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    let url = "https://d37oornn0327yg.cloudfront.net/data/upload/20230428/c426cb9a-def8-4f5d-a128-bdf2e42690cb"
    @State private var isPresented: Bool = false
    
    var body: some View {
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
        .ignoresSafeArea()
        .overlay {
            ImagePreview(images: [ url ], currentIndex: .constant(0), isPresented: $isPresented)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
