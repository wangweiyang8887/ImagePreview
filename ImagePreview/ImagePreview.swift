//
//  ImagePreview.swift
//  ImagePreview
//
//  Created by evan on 2023/5/17.
//

import Combine
import Kingfisher
import SwiftUI
import UIKit

private extension UIScreen {
    static let navigationBarHeight = navigationBar.bounds.height
    static let navigationBar = UINavigationController(rootViewController: .init()).navigationBar
}

public struct ImagePreview: View {
    private let images: [String]
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool
        
    @GestureState private var isDragging = false
    @State private var offset: CGSize = .zero
    @State private var backgroundOpacity: Double = .zero
    @State private var imageOpacity: Double = .zero

    private let animationSpeed = 0.4
    private let dismissThreshold: CGFloat = 200
    private let opacityAtDismissThreshold: Double = 0.8
    private let dismissDistance: CGFloat = 1000
    
    private func onDrag(translation: CGSize) {
        offset = translation
        backgroundOpacity = 1 - Double(offset.magnitude / dismissThreshold) * (1 - opacityAtDismissThreshold)
    }
    
    private func onAppear() {
        offset = .zero
        backgroundOpacity = 1
        imageOpacity = 1
    }
    
    private func onDisappear() {
        backgroundOpacity = .zero
        imageOpacity = .zero
    }
    
    private func onDragEnded(predictedEndTranslation: CGSize) {
        if predictedEndTranslation.magnitude > dismissThreshold {
            withAnimation(Animation.linear(duration: animationSpeed)) {
                offset = .maxx(predictedEndTranslation, predictedEndTranslation.normalized * dismissDistance)
                backgroundOpacity = .zero
            }
            withAnimation(Animation.linear(duration: 0.1).delay(animationSpeed)) {
                isPresented = false
            }
        } else {
            withAnimation(Animation.easeOut) {
                backgroundOpacity = 1
                offset = .zero
            }
        }
    }

    public init(images: [String], currentIndex: Binding<Int>, isPresented: Binding<Bool>) {
        self.images = images
        _currentIndex = currentIndex
        _isPresented = isPresented
    }

    public var body: some View {
        if isPresented {
            ZStack {
                TabView(selection: $currentIndex) {
                    ForEach(Array(zip(images.indices, images)), id: \.0) { index, urlString in
                        ZoomableScrollView {
                            ZStack {
                                KFImage(URL(string: urlString))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .background(.clear)
                                    .opacity(imageOpacity)
                                    .offset(offset)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .onTapGesture {
                            isPresented = false
                        }
                        .gesture(
                            DragGesture(minimumDistance: 30)
                                .onChanged { value in
                                    onDrag(translation: value.translation)
                                }
                                .onEnded { value in
                                    onDragEnded(predictedEndTranslation: value.predictedEndTranslation)
                                }
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                VStack {
                    Spacer()
                        .frame(height: UIScreen.navigationBarHeight)
                    HStack {
                        Spacer()
                            .frame(width: 32)
                        Spacer()
                        Text("\(currentIndex + 1)/\(images.count)")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button {
                            withAnimation {
                                isPresented = false
                            }
                        } label: {
                            Circle()
                                .foregroundColor(Color.black.opacity(0.3))
                                .frame(width: 32, height: 32)
                                .overlay {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .background(.clear)
                                        .frame(width: 16, height: 16)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .statusBar(hidden: true)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(backgroundOpacity)
            )
            .ignoresSafeArea()
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            .onAppear(perform: onAppear)
            .onDisappear(perform: onDisappear)
        }
    }
}

