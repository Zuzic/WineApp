import CantinaAssets
import SwiftUI

private struct Constants {
    static let aspectRation: CGSize = .init(width: 390, height: 264)
}

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Asset.Icons.Tmp.homeTMP.swiftUIImage
                    .resizable()
                    .aspectRatio(Constants.aspectRation, contentMode: .fit)
                
                Text(viewModel.homeInfo?.title ?? "")
                    .font(Fonts.header3)
                    .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.vertical)
                
                Text(viewModel.homeInfo?.desc ?? "")
                    .font(Fonts.body1)
                    .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Asset.Colors.surface.swiftUIColor)
        .refreshable {
            viewModel.onRefresh()
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}
