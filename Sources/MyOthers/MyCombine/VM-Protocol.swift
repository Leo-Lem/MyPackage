//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import Combine

public protocol ViewModelProtocol: AnyObject {
    associatedtype State
    associatedtype Event
    
    var state: State { get set }
    var bag: Set<AnyCancellable> { get set }
    var input: PassthroughSubject<Event, Never> { get set }
    
    static func reduce(_ state: State, _ event: Event) -> State
}

extension ViewModelProtocol {
    public func send(event: Event) { input.send(event) }
    public static func feedbackUserInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> { Feedback { _ in input } }
}
