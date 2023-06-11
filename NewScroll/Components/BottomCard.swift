//
//  BottomCard.swift
//  NewScroll
//
//  Created by Astemir Eleev on 11/06/2023.
//

import SwiftUI

struct BottomCard: View {
    @Binding var card: Card

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.ultraThinMaterial)
            .modifier(OutlineModifier(cornerRadius: 24))
            .shadowUniversal(radius: 5, y: -10)
            .overlay(
                alignment: .bottomTrailing,
                content: bottomTrailingCard
            )
            .overlay(alignment: .top) {
                VStack(spacing: 24) {
                    Text(card.desc)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    controlGrid
                }
                .padding()
            }
            .containerRelativeFrame(
                .vertical,
                count: 18,
                span: 5,
                spacing: 16
            )
            .padding(.horizontal, 32)
    }
    
    // NOTE: Plain sample for demo purposes
    private func bottomTrailingCard() -> some View {
        HStack(spacing: 64) {
            ControlGroup {
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
                Button(action: {}) {
                    Image(systemName: "plus.magnifyingglass")
                }
                Button(action: {}) {
                    Image(systemName: "face.dashed")
                }
            }
            
            Image(systemName: card.symbol)
                .symbolEffect(.variableColor.reversing)
                .symbolRenderingMode(.hierarchical)
                .imageScale(.large)
        }
        .padding()
    }
    
    // NOTE: Plain sample for demo purposes
    private var controlGrid: some View {
        Grid(alignment: .leading) {
            GridRow {
                Group {
                    Text("Size")
                    Text("Type")
                    Text("Date")
                }
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
            }
            
            Divider()
                .gridCellUnsizedAxes(.vertical)
            
            GridRow {
                Group {
                    Text("128x128")
                    Text("Capital")
                    
                    lazy var date: String = {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .none
                        formatter.timeStyle = .short
                        return formatter.string(from: card.date)
                    }()
                    Text("\(date)")
                        .lineLimit(2)
                }
                .font(.caption)
                .fontWeight(.semibold)
            }
        }
    }
}
