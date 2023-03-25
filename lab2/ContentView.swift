import SwiftUI


struct ContentView: View {
    
    @State private var a = "";
    @State private var b = "";
    @State private var c = "";
    @State private var result = "";
    @State private var isShowingResult = false;
   
    func roundAccuracy3(num: Double)-> Double{
        return Double(round(1000 * num) / 1000);
    }
    
    func clearCoefficientsValues(){
        a = ""; b = ""; c = "";
    }
    
    func hideKeyboard() {
         let resign = #selector(UIResponder.resignFirstResponder)
         UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
     }
    
    func findRoots()-> Void {
        
        if Double(a) == nil || Double(b) == nil || Double(c) == nil{
            result = "Some of the given values are invalid. Try again."
            return;
        }
        let a = Double(a)!
        let b = Double(b)!
        let c = Double(c)!
        
        // not an equasion
        if a == 0 && b == 0{
            result = "Values of 'a' and 'b' coefficients equal zero. It's not an equasion."
            return
        }
        
        // a linear equasion
        if a == 0{
            let x = roundAccuracy3(num:(-c / b))
            result = "Value of 'a' coefficient is zero. It's a linear equasion with only one root: \nx = \(x)"
            return
        }
        
        // a quadratic equasion
        let D = b * b - 4 * a * c
        if D < 0{
            result = "A discriminant is less than zero. \nThere're no roots."
        }
        else if D == 0{
            let x = roundAccuracy3(num:(-b / (2 * a)));
            result = "A discriminant is equal to zero. \nThere's one root. \nx = \(x)"
        }
        else{
            let DSqrt = sqrt(D)
            let x1 = roundAccuracy3(num:(-b + DSqrt) / (2 * a))
            let x2 = roundAccuracy3(num:(-b - DSqrt) / (2 * a))
            
            result = "A discriminant is greater than zero. \nThere're two roots: \nx₁ = \(x1) \nx₂ = \(x2)"
        }
        
    }
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea(.all)
            VStack {
                Text("ax² ± bx ± c = 0")
                    .font(.system(size: 50))
                VStack{
                    Divider()
                    TextField("a", text: $a)
                    TextField("b", text: $b)
                    TextField("c", text: $c)
                    Divider()
                }
                .padding(.horizontal, 20)
                .keyboardType(.numbersAndPunctuation)
                .font(.system(size: 32))
        
                Text("")
                
                Button("Calculate"){
                    findRoots()
                    hideKeyboard()
                    isShowingResult = true;
                    clearCoefficientsValues()
                }
                    .font(.system(size: 24))
                    .padding(.all, 10)
                    .border(.blue, width: 2)
                    .cornerRadius(4)
                    .alert(result, isPresented: $isShowingResult){
                        Button("Got it!", role: .cancel){ }
                };
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
