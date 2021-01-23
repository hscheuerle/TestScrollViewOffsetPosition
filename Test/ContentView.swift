//
//  ContentView.swift
//  Test
//
//  Created by harry scheuerle on 1/22/21.
//

import SwiftUI

struct ReaderView: View {
    @Binding var binding: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear {
                    self.binding = geo.frame(in: .global).minY
                }
                .onChange(of: geo.frame(in: .global).minY) {
                    self.binding = $0
                }
        }
    }
}

struct ContentView: View {
    @State var a: CGFloat = 0
    @State var b: CGFloat = 0
    var offset: CGFloat { max(b - a, 0) }
    
    var body: some View {
        VStack {
            Text(String(format: "%.2f", b - a))
            ScrollView(.vertical) {
                HStack(alignment: .top) {

                    VStack {
                        ForEach(0..<20) { _ in
                            Text("H")
                        }
                        Text("H")
                            .offset(x: 0, y: offset)
                            .background(ReaderView(binding: $a))
                    }

                    VStack {
                        ForEach(0..<200) { _ in
                            Text("A")
                        }
                    }

                }
            }
            .background(ReaderView(binding: $b))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
