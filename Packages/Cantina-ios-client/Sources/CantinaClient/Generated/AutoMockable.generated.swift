// Generated using Sourcery 2.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Combine
import SwiftUI






















public class CatalogRepositoryMock: CatalogRepository {

    public init() {}


    //MARK: - wines

    public var winesThrowableError: Error?
    public var winesCallsCount = 0
    public var winesCalled: Bool {
        return winesCallsCount > 0
    }
    public var winesReturnValue: [WineOutputModel]!
    public var winesClosure: (() async throws -> [WineOutputModel])?

    public func wines() async throws -> [WineOutputModel] {
        if let error = winesThrowableError {
            throw error
        }
        winesCallsCount += 1
        if let winesClosure = winesClosure {
            return try await winesClosure()
        } else {
            return winesReturnValue
        }
    }

}
public class ContactRepositoryMock: ContactRepository {

    public init() {}


    //MARK: - contactInfo

    public var contactInfoThrowableError: Error?
    public var contactInfoCallsCount = 0
    public var contactInfoCalled: Bool {
        return contactInfoCallsCount > 0
    }
    public var contactInfoReturnValue: ContactOutputModel!
    public var contactInfoClosure: (() async throws -> ContactOutputModel)?

    public func contactInfo() async throws -> ContactOutputModel {
        if let error = contactInfoThrowableError {
            throw error
        }
        contactInfoCallsCount += 1
        if let contactInfoClosure = contactInfoClosure {
            return try await contactInfoClosure()
        } else {
            return contactInfoReturnValue
        }
    }

}
public class HomeRepositoryMock: HomeRepository {

    public init() {}


    //MARK: - homeInfo

    public var homeInfoThrowableError: Error?
    public var homeInfoCallsCount = 0
    public var homeInfoCalled: Bool {
        return homeInfoCallsCount > 0
    }
    public var homeInfoReturnValue: HomeOutputModel!
    public var homeInfoClosure: (() async throws -> HomeOutputModel)?

    public func homeInfo() async throws -> HomeOutputModel {
        if let error = homeInfoThrowableError {
            throw error
        }
        homeInfoCallsCount += 1
        if let homeInfoClosure = homeInfoClosure {
            return try await homeInfoClosure()
        } else {
            return homeInfoReturnValue
        }
    }

}
