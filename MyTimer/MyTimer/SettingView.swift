//
//  SettingView.swift
//  MyTimer
//
//  Created by 飯塚 秀幸 on 2023/12/29.
//

import SwiftUI

struct SettingView: View {
    //永続化する秒数設定
    @AppStorage("timer_value") var timerValue = 10

    var body: some View {
        //奥からレイアウト
        ZStack{
            Color.backgroundSetting
                //セーフエリアを超えて画面全体に配置
                .ignoresSafeArea()
            //垂直にレイアウト
            VStack{
                //スペースを空ける
                Spacer()
                //テキストを表示する
                Text("\(timerValue)秒")
                //文字のサイズを指定
                    .font(.largeTitle)
                //スペースを空ける
                Spacer()
                //Pickerを表示
                Picker(selection: $timerValue){
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                } label: {
                    Text("選択")
                }
                //Pickerホイールを表示
                .pickerStyle(.wheel)
                //スペースを空ける
                Spacer()
            }//VStackここまで
        }//ZStackここまで
    }//bodyここまで
}//SettingViewここまで

#Preview {
    SettingView()
}
