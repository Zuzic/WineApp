import CantinaAssets
import CantinaClient
import SwiftUI

private enum Constants {
    static let cellAspectRation: CGSize = .init(width: 358, height: 235)
    static let checkboxAspectRation: CGSize = .init(width: 20, height: 20)
}

struct CatalogView: View {
    @ObservedObject private var viewModel: CatalogViewModel
    @State private var canShowFilter: Bool = false
    @State private var filterHeight: CGFloat = 100

    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.allFilterItems.isEmpty {
                    FilterTagView(tags: viewModel.allFilterItems) { item in
                        viewModel.removeFilter(item: item)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }

                List {
                    ForEach(viewModel.catalog, id: \.id) { item in
                        VStack {
                            CatalogCell(wine: item)
                                .padding(.horizontal)

                            Divider()
                        }
                        .background(NavigationLink("", destination: WineDetailsView(viewModel: viewModel.preparedWineDetailsViewModel(at: item))).opacity(0))
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Asset.Colors.surface.swiftUIColor)
                    }
                }
                .listStyle(.plain)
                .overlay(
                    Group {
                        if viewModel.catalog.isEmpty,
                           !viewModel.rootCatalog.isEmpty
                        {
                            Text(L10n.Catalog.placeholder)
                                .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                                .font(Fonts.body1)
                                .multilineTextAlignment(.center)
                        }
                    }
                )
                .background(Asset.Colors.surface.swiftUIColor)
            }
            .background(Asset.Colors.surface.swiftUIColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Asset.Icons.logo.swiftUIImage
                }

                ToolbarItem(placement: .principal) {
                    Text(L10n.Tab.catalog)
                        .font(Fonts.header3)
                        .foregroundStyle(Asset.Colors.textHeader.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    filterNavbarIcon
                }
            }
            .adoptNavigationBar()
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                viewModel.onRefresh()
            }
        }
        .background(Asset.Colors.surface.swiftUIColor)
        .onAppear {
            viewModel.onAppear()
        }
        .popover(isPresented: $canShowFilter) {
            if let filter = viewModel.filter {
                VStack {
                    HStack {
                        Text(L10n.Filter.Header.title)
                            .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                            .font(Fonts.body1)

                        Spacer()

                        if viewModel.allFilterItems.count > 0 {
                            Button {
                                viewModel.resetFilter()
                            } label: {
                                Text(L10n.Filter.Header.clear)
                                    .foregroundStyle(Asset.Colors.accents.swiftUIColor)
                                    .font(Fonts.body1)
                            }
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 8)

                    ScrollView {
                        VStack {
                            ForEach(filter.sections, id: \.title) { item in

                                Divider()

                                Text(item.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(Asset.Colors.textHeader.swiftUIColor)
                                    .font(Fonts.header3)

                                ForEach(item.items) { filterItem in
                                    HStack {
                                        if viewModel.allFilterItems.contains(where: { $0.title.lowercased() == filterItem.title.lowercased() }) {
                                            Asset.Icons.Checkbox.checkboxOn.swiftUIImage
                                                .aspectRatio(Constants.checkboxAspectRation, contentMode: .fit)
                                                .frame(maxWidth: Constants.checkboxAspectRation.width)
                                        } else {
                                            Asset.Icons.Checkbox.checkboxOff.swiftUIImage
                                                .aspectRatio(Constants.checkboxAspectRation, contentMode: .fit)
                                                .frame(maxWidth: Constants.checkboxAspectRation.width)
                                        }

                                        Text(filterItem.title.capitalized)
                                            .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                                            .font(Fonts.body1)

                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .onTapGesture {
                                        switch item {
                                        case .type: viewModel.filter(item: filterItem, type: .type([]))
                                        case .brand: viewModel.filter(item: filterItem, type: .brand([]))
                                        case .grape: viewModel.filter(item: filterItem, type: .grape([]))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        .background {
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    self.filterHeight = proxy.size.height + 70
                                }
                            }
                        }
                    }
                }
                .presentationDetents([.height(self.filterHeight)])
                .presentationDragIndicator(.visible)
            }
        }
    }

    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }

    private var filterNavbarIcon: some View {
        HStack(spacing: 2) {
            Asset.Icons.filter.swiftUIImage

            if viewModel.allFilterItems.count > 0 {
                Text("\(viewModel.allFilterItems.count)")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Asset.Colors.surface.swiftUIColor)
                    .font(Fonts.body1)
                    .background(Circle().fill(.black))
            }
        }
        .onTapGesture {
            canShowFilter.toggle()
        }
    }
}

// MARK: -

extension WineOutputModel: Equatable, Hashable {
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
