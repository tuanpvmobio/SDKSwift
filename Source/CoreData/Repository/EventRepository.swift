//
//  EventRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 21/01/2022.
//

import Foundation

protocol EventRepositoryType {
    func save(_ dataEvent: Event)
}

final class EventRepository {
    
    typealias T = Event
    
    internal var manager: DBManagerType!
    
    init(manager: DBManagerType) {
        self.manager = manager
    }
}

extension EventRepository: CoreDataBaseRepositoryType {
    
    func getList() -> [T] {
        let dataEventRequest = EventRequest()
        return getArrayData(input: dataEventRequest)
    }
}

extension EventRepository: EventRepositoryType {
    
    func save(_ dataEvent: T) {
        manager.save()
    }
}
