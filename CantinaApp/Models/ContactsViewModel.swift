import CantinaClient
import Foundation

// sourcery: builder
protocol ContactsViewModelInjection {
    // sourcery: module = client
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
        return URL(string: "tel:\(phone)")
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
}
