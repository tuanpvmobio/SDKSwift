//
//  TrackingParamParser.swift
//  MobioSDKSwift
//
//  Created by Sun on 30/03/2022.
//

import Foundation

struct TrackingParamParser {
    
    private static func createValue() -> Value {
        let id = "123"
        let inputFields = [
            InputField(key: "key1", value: "value1"),
            InputField(key: "key2", value: "value2")
        ]
        let button = Button(type: "close", name: "button close", id: "button123")
        let journey = Journey(id: "ID123", nodeId: "nodeId123")
        return Value(id: id, inputFields: inputFields, button: button, journey: journey)
    }
    
    private static func createBase(data: Any) -> Base? {
        if let value = try? JSON(data) {
            let base = Base(object: "button", value: value)
            return base
        } else {
            return nil
        }
    }
    
    private static func createEventData() -> EventDataTracking {
        return EventDataTracking()
    }
    
    private static func createDynamicDict(eventPopup: EventPopup) -> MobioSDK.Dictionary {
        let enventData = createEventData()
        let dynamic = Dynamic(eventKey: eventPopup.eventKey, enventData: enventData, includedReport: eventPopup.includedReport)
        if let dynamicDict = try? dynamic.asDictionary() {
            return dynamicDict
        } else {
            return Dictionary()
        }
    }
    
    private static func createDynamicDictArray(properties: [MobioSDK.Dictionary]) -> [EventTracking] {
        var eventArray = [EventTracking]()
        properties.forEach { (dict) in
            print("\n\n\n------ debug ----- dict custom = ")
            DictionaryPrinter.printBeauty(with: dict)
            if let result = JSONManager.decode(EventPopup.self, from: dict) {
                print("----- debug ----- EventPopup = ", result)
                let dynamicEvent = EventTracking(type: "dynamic", eventPopup: result)
                eventArray.append(dynamicEvent)
            }
        }
        return eventArray
    }
    
    private static func createEventDictionaryArray(properties: [MobioSDK.Dictionary]) -> [EventTracking] {
        var eventArray = [EventTracking]()
        let dictionary: [String : Any] = [
            "name": "cuong",
            "age": 123
        ]
        let base = createBase(data: dictionary)
        let eventOne = EventTracking(type: "click", base: base)
        eventArray.append(eventOne)
        let dynamicDictArray = createDynamicDictArray(properties: properties)
        eventArray.append(contentsOf: dynamicDictArray)
        return eventArray
    }
    
    static func createParam(event: String, properties: [MobioSDK.Dictionary]) -> MobioSDK.Dictionary {
        let eventDictionary = createEventDictionaryArray(properties: properties)
        let track = Track(events: eventDictionary)
        if let encodeResult = try? track.asDictionary() {
            return ["track": encodeResult]
        } else {
            return Dictionary()
        }
    }
}
