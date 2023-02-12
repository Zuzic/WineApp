import CantinaAssets
import CantinaClient
import SwiftUI

private struct Constants {
    static let cellAspectRation: CGSize = .init(width: 358, height: 235)
}

struct CatalogView: View {
    @ObservedObject private var viewModel: CatalogViewModel
    @Environment(\.isNavigationVisible) var isNavigationVisible
    
    var body: some View {
        List {
            ForEach(viewModel.catalog, id: \.id) { item in
                VStack {
                    CatalogCell(wine: item)
                        .padding(.horizontal)
                    
                    Divider()
                }
                .background(NavigationLink("", destination: Text("")).opacity(0) )
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
                .listRowBackground(Asset.Colors.surface.swiftUIColor)
            }
        }

        .listStyle(.plain)
        .navigationDestination(for: WineOutputModel.self) { _ in
            WineDetailsView()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Asset.Icons.logo.swiftUIImage
            }
            
            ToolbarItem(placement: .principal) {
                Text(L10n.Tab.catalog)
                    .font(Fonts.header3)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Asset.Icons.filter.swiftUIImage
                
            }
        }
        .background(Asset.Colors.surface.swiftUIColor)
        .searchable(text: $viewModel.queryString, placement: .navigationBarDrawer(displayMode: .always))
    }
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }
}

extension WineOutputModel: Equatable, Hashable{
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: WineOutputModel, rhs: WineOutputModel) -> Bool {
        lhs.id == rhs.id
    }
}
