//
//  misc.swift
//  
//
//  Created by Leopold Lemmermann on 24.02.22.
//

import SwiftUI
import CoreHaptics
import MyData

// MARK: - (Arithmetic)
public extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
}

public extension CGSize {
    
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: rhs.width + rhs.height)
    }
    
}

// MARK: - (relative Angles)
public extension Angle {
    

    /// <#Description#>
    /// - Parameter relative: <#relative description#>
    init(relative: Double) {
        self.init(radians: .twoPi * relative)
    }
    

    /// <#Description#>
    /// - Parameter relative: <#relative description#>
    /// - Returns: <#description#>
    static func relative(_ relative: Double) -> Angle {
        self.radians(.twoPi * relative)
    }
    

    /// <#Description#>
    var relative: Double {
        self.radians / .twoPi
    }
    
}

// MARK: - (Bindings)
public extension Binding {

    /// Attaches an action to each change of the Binding.
    /// - Parameter handler: The action to be executed after a change.
    /// - Returns: The modified Binding.
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }

}


/// <#Description#>
public struct PreviewBinding<Value, Content: View>: View {

    @State var value: Value
    var content: (Binding<Value>) -> Content

    public var body: some View { content($value) }

    public init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }
}

#if canImport(UIKit)
// MARK: - (New Colors)
public extension Color {

    static let systemGroupedBackground = Color(.systemGroupedBackground),
               secondarySystemGroupedBackground = Color(.secondarySystemGroupedBackground),
               tertiarySystemGroupedBackground = Color(.tertiarySystemGroupedBackground)

}
#endif

// MARK: - (Haptics)
public extension CHHapticPattern {
    
    /// <#Description#>
    /// - Returns: <#description#>
    static func taDa() throws -> CHHapticPattern {
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0),
            intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
            start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1),
            end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)
        
        let parameter = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [start, end],
            relativeTime: 0
        )
       
        let event1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )
        
        // create a continuous haptic event starting immediately and lasting one second
        let event2 = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [sharpness, intensity],
            relativeTime: 0.125,
            duration: 1
        )
        
        return try CHHapticPattern(events: [event1, event2], parameterCurves: [parameter])
    }
    
}



// MARK: - (Document property wrapper)

/// <#Description#>
@propertyWrapper struct Document: DynamicProperty {
    
    @State private var value = ""
    private let url: URL
    
    /// <#Description#>
    var wrappedValue: String {
        get { value }
        nonmutating set {
            do {
                try newValue.write(to: url, atomically: true, encoding: .utf8)
                value = newValue
            } catch { print("Failed to write output: \(error).") }
        }
    }
    
    var projectedValue: Binding<String> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    /// <#Description#>
    /// - Parameter filename: <#filename description#>
    init(_ filename: String) {
        url = FileManager.documentsDirectory.appendingPathComponent(filename)
        let text = (try? String(contentsOf: url)) ?? ""
        _value = State(initialValue: text)
    }
    
}
