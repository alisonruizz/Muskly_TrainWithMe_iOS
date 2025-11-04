import SwiftUI

struct TrainStartScreen: View {
    @StateObject private var viewModel = TrainStartViewModel()

    var body: some View {
        ZStack {
            Color(Color.blue.opacity(0.3)).edgesIgnoringSafeArea(.all)

            VStack(spacing: 24) {
                Spacer().frame(height: 20)

                // --- Sección de experiencia XP ---
                VStack(spacing: 12) {
                    Text("Musk XP")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.blue)

                    HStack(alignment: .center) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(Color.blue.opacity(0.7)))
                                .frame(height: 25)
                                .frame(maxWidth: .infinity)
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color(Color.green.opacity(0.7)))
                                .frame(width: UIScreen.main.bounds.width * 0.8 * viewModel.xpProgress,
                                       height: 25)
                            Text("\(viewModel.currentXP)")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.leading,
                                         max(0, UIScreen.main.bounds.width * 0.8 * CGFloat(viewModel.xpProgress) - 35))
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)

                        Text("/ \(viewModel.maxXP) XP")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
                Spacer().frame(height: 40)
                
                // --- Burbuja de mensaje + mascota ---
                VStack(spacing: -10) {
                    TrainingSpeechBubble {
                        Text("I can't wait to start")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer().frame(height: 45)
                    Image("img33")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                }
                
                Spacer().frame(height: 20)
                // --- Botón principal ---
                Button(action: {
                    viewModel.showFirstSetDialog = true
                }) {
                    Text("Start Train")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .background(Color(Color.green.opacity(0.5)))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 50)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)

            // --- Diálogo: Primer set ---
            if viewModel.showFirstSetDialog {
                CustomDialog(
                    title: "First Set Started",
                    message: "Your first set has begun!\nFollow the instructions to complete it.",
                    imageName: "img15",
                    confirmText: "End Set"
                ) {
                    viewModel.finishFirstSet()
                } onDismiss: {
                    viewModel.showFirstSetDialog = false
                }
            }

            // --- Diálogo: Descanso ---
            if viewModel.showRestDialog {
                CustomDialog(
                    title: "Rest",
                    message: "Take a short rest before your next set.",
                    imageName: "img16",
                    confirmText: "Go to the next set"
                ) {
                    viewModel.endRest()
                } onDismiss: {
                    viewModel.showRestDialog = false
                }
            }
        }
    }
}

// MARK: - Componentes Reutilizables

struct CustomDialog: View {
    let title: String
    let message: String
    let imageName: String
    let confirmText: String
    let onConfirm: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)

            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)

            Button(action: onConfirm) {
                Text(confirmText)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.green)
                    .cornerRadius(12)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(16)
        .padding(.horizontal, 24)
        .overlay(
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.green.opacity(0.7))
                    .font(.title2)
            }
            .padding(),
            alignment: .topTrailing
        )
    }
}

// Burbuja tipo “speech bubble”
struct TrainingSpeechBubble<Content: View>: View {
    let content: () -> Content

    var body: some View {
        ZStack(alignment: .bottom) {
            content()
                .background(Color.white)
                .cornerRadius(16)
                .overlay(
                    TrianglePointer()
                        .fill(Color.white)
                        .frame(width: 30, height: 20)
                        .offset(y: 10),
                    alignment: .bottom
                )
        }
    }
}

struct TrianglePointer: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview
#Preview {
    TrainStartScreen()
}
