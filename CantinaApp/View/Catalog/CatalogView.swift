import CantinaAssets
import CantinaClient
import SwiftUI

private struct Constants {
    static let cellAspectRation: CGSize = .init(width: 358, height: 235)
    static let checkboxAspectRation: CGSize = .init(width: 20, height: 20)
}

struct CatalogView: View {
    @ObservedObject private var viewModel: CatalogViewModel
    @Environment(\.isNavigationVisible) var isNavigationVisible
    @State private var canShowFilter: Bool = false
    @State private var filterHeight: CGFloat = 100
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.catalog, id: \.id) { item in
                    VStack {
                        CatalogCell(wine: item)
                            .padding(.horizontal)
                        
                        Divider()
                    }
                    .background(NavigationLink("", destination: WineDetailsView(wine: item)).opacity(0) )
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Asset.Colors.surface.swiftUIColor)
                }
            }
            .padding(.top, 0)
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
        .background(Asset.Colors.surface.swiftUIColor)
        .adoptNavigationBar()
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
                    .onTapGesture {
                        canShowFilter.toggle()
                    }
            }
        }
        .refreshable {
            viewModel.onRefresh()
        }
        .sheet(isPresented: $canShowFilter) {
            if let filter = viewModel.filter {
                ScrollView{
                    
                    let filterItemsTotal: [WineFilterItemOutputModel] = viewModel.filterQuery.sections.reduce([], { partialResult, section in
                        var result = partialResult
                        switch section {
                        case .type(let items): result.append(contentsOf: items)
                        case .brand(let items): result.append(contentsOf: items)
                        case .grape(let items): result.append(contentsOf: items)
                        }
                        
                        return result
                    })
                    
                    VStack {
                        ForEach(filter.sections, id: \.title) { item in
                            
                            Divider()
                            
                            Text(item.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                                .font(Fonts.header3)
                            
                            ForEach(item.items) { filterItem in
                                HStack {
                                    if filterItemsTotal.contains(where: { $0.title.lowercased() == filterItem.title.lowercased() }) {
                                        Asset.Icons.Checkbox.checkboxOn.swiftUIImage
                                            .aspectRatio(Constants.checkboxAspectRation, contentMode: .fit)
                                            .frame(maxWidth: Constants.checkboxAspectRation.width)
                                    } else {
                                        Asset.Icons.Checkbox.checkboxOff.swiftUIImage
                                            .aspectRatio(Constants.checkboxAspectRation, contentMode: .fit)
                                            .frame(maxWidth: Constants.checkboxAspectRation.width)
                                    }
                                    
                                    Text(filterItem.title.capitalized)
                                        .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                                        .font(Fonts.body1)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onTapGesture {
                                    switch item {
                                    case .type: viewModel.filterByType(item: filterItem)
                                    case .brand: viewModel.filterByBrand(item: filterItem)
                                    case .grape: viewModel.filterByGrape(item: filterItem)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                    .background(GeometryReader { proxy in
                        Color.clear.onAppear {
                            self.filterHeight = proxy.size.height
                        }
                    })
                    .padding(.horizontal, 32)
                }
                .presentationDetents([.height(self.filterHeight)])
                .presentationDragIndicator(.visible)
            }
        }
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

private extension WineFilterSectionOutputModel {
    var title: String {
        switch self {
        case .type: return L10n.Filter.Section.type
        case .brand: return L10n.Filter.Section.brand
        case .grape: return L10n.Filter.Section.grape
        }
    }
    
    var items: [WineFilterItemOutputModel] {
        switch self {
        case .type(let array): return array
        case .brand(let array): return array
        case .grape(let array): return array
        }
    }
}
