import CantinaClient
import Foundation

// sourcery: builder
protocol HomeViewModelInjection {
    var homeRepository: HomeRepository { get }
    var shopRepository: ShopRepository { get }
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

    func onRefresh() {
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
