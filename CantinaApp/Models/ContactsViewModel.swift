import CantinaClient
import Foundation

// sourcery: builder
protocol ContactsViewModelInjection {
    var contactRepository: ContactRepository { get }
}

final class ContactsViewModel: ObservableObject {
    @Published var contactsInfo: ContactOutputModel?
    
    var mailURL: URL? {
        guard let email = contactsInfo?.email else { return nil }
        return URL(string: "mailto:\(email)")
    }
    
    var callURL: URL? {
        guard let phone = contactsInfo?.phone else { return nil }
        return URL(string: "tel://\(phone.onlyDigits())")
    }
    
    private let injection: ContactsViewModelInjection
    
    init(injection: ContactsViewModelInjection) {
        self.injection = injection
    }
    
    func onAppear() {
        Task {
            do {
                let result = try await injection.contactRepository.contactInfo()
                
                await MainActor.run {
                    self.contactsInfo = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
    
    func onRefresh() {
        Task {
            do {
                let result = try await injection.contactRepository.refreshContactInfo()
                
                await MainActor.run {
                    self.contactsInfo = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}

// MARK: -
private extension String {
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
}
