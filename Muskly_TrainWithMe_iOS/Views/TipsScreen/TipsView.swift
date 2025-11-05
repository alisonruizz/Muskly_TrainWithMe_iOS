
import SwiftUI

struct TipsView: View {
    @StateObject private var viewModel = TipsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // Imagen superior
                    Image("img20")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .padding(.bottom, 8)

                    Text("Tips and advices")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color("OnBackground"))
                        .padding(.bottom, 18)

                    // Listado de categorías y tips
                    ForEach(viewModel.categoriesWithTips, id: \.0) { (categoryName, tips) in
                        VStack(alignment: .leading, spacing: 12) {

                            Text(categoryName)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(Color("OnBackground"))
                                .padding(.horizontal, 16)

                            ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                                let tipIndex = "\(categoryName)-\(index)"

                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(tip.short)
                                            .foregroundColor(Color("Background"))
                                            .font(.system(size: 16))
                                        Spacer()
                                        Button {
                                            viewModel.toggleExpanded(index: tipIndex)
                                        } label: {
                                            Image(systemName: "plus")
                                                .foregroundColor(Color("Primary"))
                                                .padding(8)
                                                .background(Color("PrimaryContainer"))
                                                .clipShape(Circle())
                                        }
                                    }

                                    if viewModel.expandedIndex == tipIndex {
                                        Text(tip.details)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("Background"))
                                            .padding(.top, 4)
                                            .transition(.opacity)
                                    }
                                }
                                .padding(12)
                                .background(Color("Secundary"))
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
                .padding(.vertical, 16)
            }
            .background(Color("SecundaryContainer"))
            .navigationTitle("Tips")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TipsView()
}
