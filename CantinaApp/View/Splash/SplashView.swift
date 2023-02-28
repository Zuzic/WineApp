import CantinaAssets
import SwiftUI

private struct Constants {
    static let aspectRatio: CGSize = .init(width: 54, height: 38)
    static let mainImageRation: CGSize = .init(width: 390, height: 244)
}

struct SplashView: View {
    var body: some View {
        VStack(spacing: 10) {
            Asset.Icons.logoSplash.swiftUIImage
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
                .frame(maxWidth: Constants.aspectRatio.width)
                .padding(.top, 20)
            
            Asset.Icons.Tmp.splashTMP.swiftUIImage
                .resizable()
                .aspectRatio(Constants.mainImageRation, contentMode: .fill)
                .frame(maxHeight: Constants.mainImageRation.height)
                .clipped()
                .padding(.top, 50)
            
            Text(L10n.Splash.title)
                .font(Fonts.header1)
                .foregroundColor(Asset.Colors.textHeader.swiftUIColor)
            
            Text(L10n.Splash.desc)
                .font(Fonts.header2)
                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
                .padding(.horizontal, 8)
                .lineLimit(3)
            
            Spacer()
            
            VStack {
                ProgressView()
                
                Text(L10n.Splash.progress)
                    .font(Fonts.caption)
                    .foregroundColor(Asset.Colors.elementsSecondary.swiftUIColor)
            }
            .padding(.top, 20)
            
            Spacer()
            
            DevelopedByView()
                .padding(.horizontal, 32)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Asset.Colors.surface.swiftUIColor)
    }
}
