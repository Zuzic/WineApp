import CantinaClient
import Foundation

// sourcery: builder
protocol HomeViewModelInjection {
    // sourcery: module = client
    var homeRepository: HomeRepository { get }
}

final class HomeViewModel: ObservableObject {
    @Published var homeInfo: HomeOutputModel?
    
    private let injection: HomeViewModelInjection
    
    init(injection: HomeViewModelInjection) {
        self.injection = injection
    }
    
    func onAppear() {
        Task {
            do {
                let result = try await injection.homeRepository.homeInfo()
                
                await MainActor.run {
                    self.homeInfo = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}
