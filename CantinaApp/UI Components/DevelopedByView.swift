import CantinaAssets
import SwiftUI

struct DevelopedByView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 3) {
            Text(L10n.Developed.by)
                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                .font(Fonts.caption)
            
            Text(L10n.Developed.owner)
                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                .font(Fonts.caption)
            
            Text(L10n.Developed.flag)
                .foregroundColor(Asset.Colors.textBodyPrimary.swiftUIColor)
                .font(Fonts.body1)
        }
    }
}
