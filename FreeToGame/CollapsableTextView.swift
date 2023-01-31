//
//  CollapsableTextView.swift
//  FreeToGame
//
//  Created by Abdallah on 30/01/2023.
//

import SwiftUI

struct CollapsableTextView: View {
    let lineLimit: Int
    
    @State private var expanded: Bool = false
    @State private var showViewButton: Bool = false
    private var text: String
    
    init(_ text: String, lineLimit: Int) {
        self.text = text
        self.lineLimit = lineLimit
        
    }
    
    private var moreLessText: String {
        if showViewButton {
            return expanded ? "View Less" : "View More"
            
        } else {
            return ""
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Text(text)
                    .font(.body)
                    .lineLimit(expanded ? nil : lineLimit)
                
                ScrollView(.vertical) {
                    Text(text)
                        .font(.body)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        showViewButton = proxy.size.height > CGFloat(22 * lineLimit)
                                    }
                                    .onChange(of: text) { _ in
                                        showViewButton = proxy.size.height > CGFloat(22 * lineLimit)
                                    }
                            }
                        )
                    
                }
                .opacity(0.0)
                .disabled(true)
                .frame(height: 0.0)
            }
            
            Button(action: {
                withAnimation {
                    expanded.toggle()
                }
            }, label: {
                Text(moreLessText)
                    .font(.body)
                    .foregroundColor(.blue)
            })
            .opacity(showViewButton ? 1.0 : 0.0)
            .disabled(!showViewButton)
            .frame(height: showViewButton ? nil : 0.0)
            
        }
    }
}
