import SwiftUI

struct USDRateView: View {
    @StateObject private var viewModel = USDRateViewModel()
    
    @State var rubles = "1"
    
    var body: some View {
        ZStack {
            Image("background")
            VStack {
                VStack {
                    HStack {
                        Text("RUB")
                            .bold()
                            .font(.title)
                            .frame(width: 85, height: 50)
                        Image("ru")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 50)
                    }
                    .background(Color.gray)
                    if viewModel.isLoading {
                        ProgressView("Загрузка...")
                    } else if let number = viewModel.rate {
                        Text("\(viewModel.getUSDRUB(from: rubles, rate: number))")
                            .frame(width: 153, height: 100)
                            .font(.largeTitle)
                            .bold()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Отстутствуют данные: \(errorMessage)")
                            .foregroundColor(.red)
                    }
                }
                .border(Color.gray, width: 2)
                .background(Color.clear)
                .padding()
                Image("arrows")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                VStack {
                    HStack {
                        Text("USD")
                            .bold()
                            .font(.title)
                            .frame(width: 85, height: 50)
                        Image("usa")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 40)
                    }
                    .background(Color.gray)
                    TextField("RUB", text: $rubles)
                        .frame(width: 153, height: 100)
                        .font(.largeTitle)
                        .bold()
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Готово") {
                                    hideKeyboard()
                                }
                            }
                        }
                }
                .border(Color.gray, width: 2)
                .background(Color.clear)
                .padding()
            }
            .onAppear(perform: {
                self.viewModel.updateRate()
            })
        }
    }
}

#Preview {
    USDRateView()
}
