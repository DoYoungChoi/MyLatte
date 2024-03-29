//
//  ContentView.swift
//  MyLatte
//
//  Created by 최도영 on 3/29/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel = .init()
    private let width = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            Image("latte\(viewModel.count)")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .ignoresSafeArea()
            
            Image("latte\(viewModel.count)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
        }
    }
}

final class ContentViewModel: ObservableObject {
    @Published var count: Int
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.count = (1...12).randomElement() ?? 1
        self.cancellables = []
        changeImage()
    }
    
    func changeImage() {
        Timer.publish(every: 20, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.count += 1
                if self?.count ?? 13 > 12 {
                    self?.count = 1
                }
            }
            .store(in: &cancellables)
    }
}


#Preview {
    ContentView()
}
