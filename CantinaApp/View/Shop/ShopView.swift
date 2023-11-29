import CantinaAssets
import SwiftUI

struct ShopView: View {
    @ObservedObject private var viewModel: ShopViewModel
    @State private var canShowFilter: Bool = false
    @State private var filterHeight: CGFloat = 100

    init(viewModel: ShopViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("shops count \(viewModel.addresses.count)")
            }
            .background(Asset.Colors.surface.swiftUIColor)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Asset.Icons.logo.swiftUIImage
                }

                ToolbarItem(placement: .principal) {
                    Text(L10n.Tab.shop)
                        .font(Fonts.header3)
                        .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    filterNavbarIcon
                }
            }
            .adoptNavigationBar()
            .refreshable {
                viewModel.onRefresh()
            }
            .popover(isPresented: $canShowFilter) {
                VStack {
                    Text("Filter is shown")
                }
                .presentationDetents([.height(self.filterHeight)])
                .presentationDragIndicator(.visible)
            }
        }
        .background(Asset.Colors.surface.swiftUIColor)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

private extension ShopView {
    private var filterNavbarIcon: some View {
        HStack(spacing: 2) {
            Asset.Icons.filter.swiftUIImage

//            if viewModel.allFilterItems.count > 0 {
//                Text("\(viewModel.allFilterItems.count)")
//                    .frame(width: 20, height: 20)
//                    .foregroundColor(Asset.Colors.surface.swiftUIColor)
//                    .font(Fonts.body1)
//                    .background(Circle().fill(.black))
//            }
        }
        .onTapGesture {
            canShowFilter.toggle()
        }
    }
}
