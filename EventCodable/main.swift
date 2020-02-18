//
//  main.swift
//  EventCodable
//
//  Created by Robert Walker on 2/18/20.
//  Copyright © 2020 Robert Walker. All rights reserved.
//

import Foundation

// MARK: JSON Encoder and Decoder

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
encoder.outputFormatting = .prettyPrinted

// MARK: JSON Test Fixtures

let jsonInput = #"""
{
    "eventId": "82dda4c7-92e6-4041-9ad0-11a2ff47a5e8",
    "accountId": "78d81f36-843a-42d8-b246-d8880992a5e8",
    "actionHistoryTimestamp": "2020-02-10T13:45:34Z",
    "userId": "0a149e05-fdc3-4d3c-a6e6-f43cf2288189",
    "metadata": {
        "correlationId": "14a2acd6-b710-40e9-89c0-fa685f3e97bb",
        "triggeredBy": {
            "type": "System",
            "source": "org.sans.animal.a2m",
            "accountId": "06d91956-7314-4ef1-9272-44b56a5dccdd",
            "userId": "7e859a0c-8f04-443e-b088-b62c0c2215fa",
        },
        "version": 1,
        "deprecated": true
    }
}
"""#

let invalidJsonInput = #"""
{
    "eventId": "82dda4c7-92e6-4041-9ad0-11a2ff47a5e",
    "accountId": "78d81f36-843a-42d8-b246-d8880992a5e8",
    "actionHistoryTimestamp": "2020-02-10T13:45:34Z",
    "userId": "0a149e05-fdc3-4d3c-a6e6-f43cf2288189",
    "metadata": {
        "correlationId": "14a2acd6-b710-40e9-89c0-fa685f3e97bb",
        "triggeredBy": {
            "type": "System",
            "source": "org.sans.animal.a2m",
            "accountId": "06d91956-7314-4ef1-9272-44b56a5dccdd",
            "userId": "7e859a0c-8f04-443e-b088-b62c0c2215fa",
        },
        "version": 2,
        "deprecated": false
    }
}
"""#

// MARK: Create some instances

// Automatic Codable
let triggeredBy = EventTrigger(type: .api, source: "org.sans.animal.a2m", accountId: UUID(), userId: UUID())
let metadata = EventMetadata(correlationId: UUID(), triggeredBy: triggeredBy, version: 0, deprecated: false)
let event = UserPasswordChanged(
    eventId: UUID(), accountId: UUID(), actionHistoryTimestamp: Date(), userId: UUID(), metadata: nil
)
let eventWithMeta = UserPasswordChanged(
    eventId: UUID(), accountId: UUID(), actionHistoryTimestamp: Date(), userId: UUID(), metadata: metadata
)

// Manual Codable
let triggeredBy2 = EventTrigger2(type: .api, source: "org.sans.animal.a2m", accountId: UUID(), userId: UUID())
let metadata2 = EventMetadata2(correlationId: UUID(), triggeredBy: triggeredBy2, version: 0, deprecated: false)
let event2 = UserPasswordChanged2(
    eventId: UUID(), accountId: UUID(), actionHistoryTimestamp: Date(), userId: UUID(), metadata: nil
)
let eventWithMeta2 = UserPasswordChanged2(
    eventId: UUID(), accountId: UUID(), actionHistoryTimestamp: Date(), userId: UUID(), metadata: metadata2
)

// MARK: Decode event from JSON

let data = jsonInput.data(using: .utf8)!
do {
    print("===== Try to Decode from Correct JSON =====")
    let decodedEvent = try decoder.decode(UserPasswordChanged.self, from: data)
    dump(decodedEvent)
} catch {
    print("Unexpected error: \(error).")
}

// MARK: Attempt to decode from invalid JSON Input

let invalidData = invalidJsonInput.data(using: .utf8)!
do {
    print("===== Try to Decode from Bad JSON =====")
    _ = try decoder.decode(UserPasswordChanged.self, from: invalidData)
    print("!!!==== Oops We Should Have Failed This ====!!!")
} catch {
    print("Unexpected error: \(error).")
}

// MARK: Encode to JSON

let encodedData = try encoder.encode(eventWithMeta)
if let jsonOutput = String(data: encodedData, encoding: .utf8) {
    print("===== Successful Encode to JSON =====")
    print(jsonOutput)
} else {
    print("===== Failed to encode event =====")
}
