// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
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

    public var winesCallsCount = 0
    public var winesCalled: Bool {
        return winesCallsCount > 0
    }
    public var winesReturnValue: [WineOutputModel]!
    public var winesClosure: (() async -> [WineOutputModel])?

    public func wines() async -> [WineOutputModel] {
        winesCallsCount += 1
        if let winesClosure = winesClosure {
            return await winesClosure()
        } else {
            return winesReturnValue
        }
    }

    //MARK: - updateWines

    public var updateWinesThrowableError: Error?
    public var updateWinesCallsCount = 0
    public var updateWinesCalled: Bool {
        return updateWinesCallsCount > 0
    }
    public var updateWinesReturnValue: [WineOutputModel]!
    public var updateWinesClosure: (() async throws -> [WineOutputModel])?

    public func updateWines() async throws -> [WineOutputModel] {
        if let error = updateWinesThrowableError {
            throw error
        }
        updateWinesCallsCount += 1
        if let updateWinesClosure = updateWinesClosure {
            return try await updateWinesClosure()
        } else {
            return updateWinesReturnValue
        }
    }

    //MARK: - filter

    public var filterCallsCount = 0
    public var filterCalled: Bool {
        return filterCallsCount > 0
    }
    public var filterReturnValue: WineFilterOutputModel!
    public var filterClosure: (() async -> WineFilterOutputModel)?

    public func filter() async -> WineFilterOutputModel {
        filterCallsCount += 1
        if let filterClosure = filterClosure {
            return await filterClosure()
        } else {
            return filterReturnValue
        }
    }

}
public class ClientModuleDependencyMock: ClientModuleDependency {

    public init() {}

    public var settings: ClientModuleSettings {
        get { return underlyingSettings }
        set(value) { underlyingSettings = value }
    }
    public var underlyingSettings: ClientModuleSettings!

}
public class ClientModuleSettingsMock: ClientModuleSettings {

    public init() {}

    public var isFirstLaunch: Bool {
        get { return underlyingIsFirstLaunch }
        set(value) { underlyingIsFirstLaunch = value }
    }
    public var underlyingIsFirstLaunch: Bool!
    public var restEndpoint: String {
        get { return underlyingRestEndpoint }
        set(value) { underlyingRestEndpoint = value }
    }
    public var underlyingRestEndpoint: String!

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

    //MARK: - refreshContactInfo

    public var refreshContactInfoThrowableError: Error?
    public var refreshContactInfoCallsCount = 0
    public var refreshContactInfoCalled: Bool {
        return refreshContactInfoCallsCount > 0
    }
    public var refreshContactInfoReturnValue: ContactOutputModel!
    public var refreshContactInfoClosure: (() async throws -> ContactOutputModel)?

    public func refreshContactInfo() async throws -> ContactOutputModel {
        if let error = refreshContactInfoThrowableError {
            throw error
        }
        refreshContactInfoCallsCount += 1
        if let refreshContactInfoClosure = refreshContactInfoClosure {
            return try await refreshContactInfoClosure()
        } else {
            return refreshContactInfoReturnValue
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

    //MARK: - refreshHomeInfo

    public var refreshHomeInfoThrowableError: Error?
    public var refreshHomeInfoCallsCount = 0
    public var refreshHomeInfoCalled: Bool {
        return refreshHomeInfoCallsCount > 0
    }
    public var refreshHomeInfoReturnValue: HomeOutputModel!
    public var refreshHomeInfoClosure: (() async throws -> HomeOutputModel)?

    public func refreshHomeInfo() async throws -> HomeOutputModel {
        if let error = refreshHomeInfoThrowableError {
            throw error
        }
        refreshHomeInfoCallsCount += 1
        if let refreshHomeInfoClosure = refreshHomeInfoClosure {
            return try await refreshHomeInfoClosure()
        } else {
            return refreshHomeInfoReturnValue
        }
    }

}
public class InitialRepositoryMock: InitialRepository {

    public init() {}


    //MARK: - loadInitialData

    public var loadInitialDataThrowableError: Error?
    public var loadInitialDataCallsCount = 0
    public var loadInitialDataCalled: Bool {
        return loadInitialDataCallsCount > 0
    }
    public var loadInitialDataClosure: (() async throws -> Void)?

    public func loadInitialData() async throws {
        if let error = loadInitialDataThrowableError {
            throw error
        }
        loadInitialDataCallsCount += 1
        try await loadInitialDataClosure?()
    }

}
public class ShopRepositoryMock: ShopRepository {

    public init() {}


    //MARK: - loadShopAddresses

    public var loadShopAddressesThrowableError: Error?
    public var loadShopAddressesCallsCount = 0
    public var loadShopAddressesCalled: Bool {
        return loadShopAddressesCallsCount > 0
    }
    public var loadShopAddressesReturnValue: [CountryOutputModel]!
    public var loadShopAddressesClosure: (() async throws -> [CountryOutputModel])?

    public func loadShopAddresses() async throws -> [CountryOutputModel] {
        if let error = loadShopAddressesThrowableError {
            throw error
        }
        loadShopAddressesCallsCount += 1
        if let loadShopAddressesClosure = loadShopAddressesClosure {
            return try await loadShopAddressesClosure()
        } else {
            return loadShopAddressesReturnValue
        }
    }

}
public class WineStatusRepositoryMock: WineStatusRepository {

    public init() {}


    //MARK: - statusDescription

    public var statusDescriptionAtStatusStringThrowableError: Error?
    public var statusDescriptionAtStatusStringCallsCount = 0
    public var statusDescriptionAtStatusStringCalled: Bool {
        return statusDescriptionAtStatusStringCallsCount > 0
    }
    public var statusDescriptionAtStatusStringReceivedStatus: String?
    public var statusDescriptionAtStatusStringReceivedInvocations: [String] = []
    public var statusDescriptionAtStatusStringReturnValue: String!
    public var statusDescriptionAtStatusStringClosure: ((String) async throws -> String)?

    public func statusDescription(at status: String) async throws -> String {
        if let error = statusDescriptionAtStatusStringThrowableError {
            throw error
        }
        statusDescriptionAtStatusStringCallsCount += 1
        statusDescriptionAtStatusStringReceivedStatus = status
        statusDescriptionAtStatusStringReceivedInvocations.append(status)
        if let statusDescriptionAtStatusStringClosure = statusDescriptionAtStatusStringClosure {
            return try await statusDescriptionAtStatusStringClosure(status)
        } else {
            return statusDescriptionAtStatusStringReturnValue
        }
    }

}
