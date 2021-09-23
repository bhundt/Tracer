//
//  Object.swift
//  Tracer
//
//  Created by Bastian Hundt on 22.09.21.
//

import Foundation

protocol IdentifiableObject {
    var uniqueId: UUID { get }
}
