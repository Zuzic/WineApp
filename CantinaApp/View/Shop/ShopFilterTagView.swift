import CantinaAssets
import CantinaClient
import SFSafeSymbols
import SwiftUI

struct ShopFilterTagView: View {
    @ObservedObject private var viewModel: ShopFilterViewModel

    @State private var totalHeight = CGFloat.infinity

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(maxHeight: totalHeight)
    }

    init(viewModel: ShopFilterViewModel) {
        self.viewModel = viewModel
    }

    private func generateContent(in _: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
//            ForEach(self.tags, id: \.id) { tag in
//                self.itemView(for: tag)
//                    .padding([.horizontal, .vertical], 4)
//                    .alignmentGuide(.leading, computeValue: { d in
//                        if abs(width - d.width) > g.size.width {
//                            width = 0
//                            height -= d.height
//                        }
//                        let result = width
//                        if tag.id == self.tags.last!.id {
//                            width = 0
//                        } else {
//                            width -= d.width
//                        }
//                        return result
//                    })
//                    .alignmentGuide(.top, computeValue: { _ in
//                        let result = height
//                        if tag.id == self.tags.last!.id {
//                            height = 0
//                        }
//                        return result
//                    })
//            }
        }.background(viewHeightReader($totalHeight))
    }

    private func itemView(for item: WineFilterItemOutputModel) -> some View {
        Group {
            HStack(spacing: 4) {
                Text(item.title.capitalized)

                Image(systemSymbol: .xmark)
            }
            .font(Fonts.caption1)
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Asset.Colors.accents.swiftUIColor)
        )
        .onTapGesture {
//            action(item)
        }
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
