import CantinaClient
import Foundation

// sourcery: builder
protocol WineDetailsViewModelInjection {
    var wineStatusRepository: WineStatusRepository { get }
}

final class WineDetailsViewModel: ObservableObject {
    @Published var statusDescription: String?
    @Published var wine: WineOutputModel

    private let injection: WineDetailsViewModelInjection

    init(injection: WineDetailsViewModelInjection, wine: WineOutputModel) {
        self.injection = injection
        self.wine = wine
    }

    func onAppear() {
        Task {
            do {
                let result = try await injection.wineStatusRepository.statusDescription(at: wine.status)

                await MainActor.run {
                    self.statusDescription = result
                }
            } catch {
                debugPrint("Error \(error)")
            }
        }
    }
}
