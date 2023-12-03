import CantinaAssets
import SwiftUI

struct DevelopedByView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text(L10n.Developed.flag)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.body1)

                Text(L10n.Developed.campaing)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.caption2)
            }

            HStack(alignment: .lastTextBaseline, spacing: 3) {
                Text(L10n.Developed.by)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.caption2)

                Text(L10n.Developed.owner)
                    .foregroundStyle(Asset.Colors.textBodyPrimary.swiftUIColor)
                    .font(Fonts.caption2)
            }
        }
    }
}
