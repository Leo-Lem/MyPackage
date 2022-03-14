//
//  OptionalPicker.swift
//  
//
//  Created by Leopold Lemmermann on 08.03.22.
//

import SwiftUI
import MyOthers

/// <#Description#>
public struct OptionalPicker<T, ToggleView: View, PickerView: View>: View {
    
    @Binding var optional: T?
    let defaultValue: T
    
    let toggle: ToggleClosure,
        picker: PickerClosure
    
    public var body: some View {
        if !pickerFirst { toggle(binding.toggle) }
        
        if optional != nil { picker(binding.picker, defaultValue) }
        
        if pickerFirst { toggle(binding.toggle) }
    }
    
    private let pickerFirst: Bool
    
    private var binding: (toggle: Binding<Bool>, picker: Binding<T>) {
        (
            Binding(get: { optional != nil }, set: { optional = ($0 ? defaultValue : nil) }),
            Binding(get: { optional ?? defaultValue }, set: { optional = $0 })
        )
    }
    
}

public extension OptionalPicker {
    
    typealias ToggleClosure = (Binding<Bool>) -> ToggleView
    typealias PickerClosure = (Binding<T>, _ default: T) -> PickerView
    
    /// Initializes the OptionalPickerWithToggle so as the Toggle is displayed first (on top/on the left etc.).
    /// - Parameters:
    ///   - optional: The optional binding of which the value is picked.
    ///   - defaultValue: A default value for when the picker is turned on. Defaults to .init() when possible.
    ///   - toggle: A closure generating some View and taking in a bool binding (to switch the picker on and off).
    ///   - picker: A closure generating some View and taking in a binding of the unwrapped optional as parameter.
    init(
        _ optional: Binding<T?>,
        default defaultValue: T,
        toggle: @escaping ToggleClosure,
        picker: @escaping PickerClosure
    ) {
        _optional = optional
        self.defaultValue = defaultValue
        
        self.toggle = toggle
        self.picker = picker
        
        pickerFirst = false
    }
    
    
    /// Initializes the OptionalPickerWithToggle so as the Picker is displayed first (on top/on the left etc.).
    /// - Parameters:
    ///   - optional: The optional binding of which the value is picked.
    ///   - defaultValue: A default value for when the picker is turned on. Defaults to .init() when possible.
    ///   - picker: A closure generating some View and taking in a binding of the unwrapped optional as parameter.
    ///   - toggle: A closure generating some View and taking in a bool binding (to switch the picker on and off).
    init(
        _ optional: Binding<T?>,
        default defaultValue: T,
        picker: @escaping PickerClosure,
        toggle: @escaping ToggleClosure
    ) {
        _optional = optional
        self.defaultValue = defaultValue
        
        self.toggle = toggle
        self.picker = picker
        
        pickerFirst = true
    }
    
    /// Initializes the OptionalPickerWithToggle so as the Toggle is displayed first (on top/on the left etc.).
    /// - Parameters:
    ///   - optional: The optional binding of which the value is picked.
    ///   - toggle: A closure generating some View and taking in a bool binding (to switch the picker on and off).
    ///   - picker: A closure generating some View and taking in a binding of the unwrapped optional as parameter.
    init(
        _ optional: Binding<T?>,
        toggle: @escaping ToggleClosure,
        picker: @escaping PickerClosure
    ) where T: Initializable {
        _optional = optional
        defaultValue = .init()
        
        self.toggle = toggle
        self.picker = picker
        
        pickerFirst = false
    }
    
    /// Initializes the OptionalPickerWithToggle so as the Picker is displayed first (on top/on the left etc.).
    /// - Parameters:
    ///   - optional: The optional binding of which the value is picked.
    ///   - picker: A closure generating some View and taking in a binding of the unwrapped optional as parameter.
    ///   - toggle: A closure generating some View and taking in a bool binding (to switch the picker on and off).
    init(
        _ optional: Binding<T?>,
        picker: @escaping PickerClosure,
        toggle: @escaping ToggleClosure
    ) where T: Initializable {
        _optional = optional
        defaultValue = .init()
        
        self.toggle = toggle
        self.picker = picker
        
        pickerFirst = true
    }
    
}

#if DEBUG
// MARK: - (Previews)
struct OptionalPicker_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PreviewBinding(Date.now) {
                OptionalPicker($0.animation()) { Toggle("", isOn: $0) } picker: { binding, def in DatePicker(binding) }
            }
        }
    }
}
#endif
