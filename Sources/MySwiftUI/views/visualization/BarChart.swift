//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 26.02.22.
//

import SwiftUI
import MyNumbers

/***/
public struct BarChart: View {
    ///
    public let dataPoints: [DataPoint]
    
    public let lines: Int
    
    public var body: some View {
        ZStack {
            VStack {
                ForEach(0..<lines) { _ in
                    Divider()
                    Spacer()
                }
            }
            
            HStack {
                VStack {
                    ForEach(0..<lines, id: \.self) { i in
                        Text(Int(maxValue / 10 * (10-i)).formatted(), font:. caption)
                            .padding(.horizontal)
                            .animation(nil, value: dataPoints)
                        Spacer()
                    }
                }
                
                ForEach(dataPoints) { data in
                    VStack {
                        Rectangle()
                            .fill(data.color)
                            .scaleEffect(x: 1, y: CGFloat(data.value / maxValue), anchor: .bottom)
                        
                        Text(data.title, font: .body.bold())
                    }
                }
            }
        }
    }
    
    public init(
        _ dataPoints: [DataPoint],
        lines: Int = 10
    ) {
        self.dataPoints = dataPoints
        self.maxValue = dataPoints.max()?.value ?? 1
        
        self.lines = lines
    }
    
    ///
    private let maxValue: Double
}

#if DEBUG
//MARK: - Previews
struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BarChart(.examples)
            BarChart(.examples, lines: 5)
        }
    }
}
#endif
