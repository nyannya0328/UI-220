//
//  Home.swift
//  UI-220
//
//  Created by にゃんにゃん丸 on 2021/06/03.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var model = MapViewModel()
    
    @State var locationManger = CLLocationManager()
    var body: some View {
        ZStack{
            
            MapView()
                .ignoresSafeArea()
                .environmentObject(model)
            
            
            VStack{
                
                
                VStack(spacing:0){
                    
                    HStack{
                        
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                        
                        TextField("Search World", text: $model.searchText)
                            .foregroundColor(.white)
                        
                    }
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(BlurView(style: .dark))
                    .colorScheme(.dark)
                    .cornerRadius(10)
                    
                    
                    if !model.places.isEmpty && model.searchText != ""{
                        
                        
                        ScrollView{
                            
                            VStack(spacing:10){
                                
                                
                                ForEach(model.places){place in
                                    
                                    
                                    Text(place.placeMark.name ?? "")
                                        .foregroundColor(.gray)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .onTapGesture {
                                            
                                            
                                            model.selectPlace(place: place)
                                            
                                        }
                                    
                                    
                                    Divider()
                                        .background(Color.red)
                                    
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                        .background(Color.white)
                        
                        
                    }
                    
                    
                }
                
                Spacer()
                
                VStack(spacing:20){
                    
                    Button(action: model.foucusRegion, label: {
                        Image(systemName: "location.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                    Button(action: model.updateMapView, label: {
                        Image(systemName:model.mapType == .standard ? "network" : "map")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .bottomTrailing)
                
                
            }
            .padding()
            
        
            
            
            
        }
        .onAppear(perform: {
            
            locationManger.delegate = model
            locationManger.requestWhenInUseAuthorization()
            
        })
        .alert(isPresented: $model.perimissionDeneied, content: {
            Alert(title: Text("Perimission Deneide"), message: Text("Pleace Enable Permisson In App Settings"), dismissButton: .default(Text("Go To Settings"),action: {
                
                
          
                
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                
                
            }))
        })
        .onChange(of: model.searchText, perform: { value in
            
            
            
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                
                
                if value == model.searchText{
                    
                    
                    self.model.searhQuery()
                    
                    
                }
                
                
                
                
            }
            
            
        })
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct BlurView : UIViewRepresentable {
    
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
            return view
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
