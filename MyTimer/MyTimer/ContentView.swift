//
//  ContentView.swift
//  MyTimer
//
//  Created by 飯塚 秀幸 on 2023/12/29.
//

import SwiftUI

struct ContentView: View {
    //タイマーの変数を作成
    @State var timerHandler: Timer?
    //カウント（経過時間）の変数を作成
    @State var count = 0
    //永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    //アラートの表示の有無
    @State var showAlert = false

    var body: some View {
        NavigationStack {
            ZStack{
                //背景画像
                Image(.backgroundTimer)
                //リサイズ
                    .resizable()
                //セーフエリアを超えて画面全体に配置する
                    .ignoresSafeArea()
                //アスペクト比を維持して短編基準に収まるように配置
                    .scaledToFill()
                //垂直にレイアウト、View間の間隔を30にする
                VStack(spacing: 30.0){
                    //テキストを表示
                    Text("残り\(timerValue - count)秒")
                    //文字のサイズ指定
                        .font(.largeTitle)
                    //水平にレイアウト
                    HStack{
                        //スタートボタン
                        Button{
                            //ボタンをタップした時のアクション
                            //タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                        } label: {
                            //テキストを表示する
                            Text("スタート")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.start)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }//スタートボタンここまで
                        //ストップボタン
                        Button{
                            //ボタンをタップした時のアクション
                            //timerHandlerをアンラップ
                            if let timerHandler{
                                //もしタイマーが実行中だったら停止
                                if timerHandler.isValid == true {
                                    //タイマー停止
                                    timerHandler.invalidate()
                                }
                            }
                        } label: {
                            //テキストを表示する
                            Text("ストップ")
                                .font(.title)
                                .foregroundStyle(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color.stop)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }//ストップボタンここまで
                    }
                }//VStackここまで
            }//ZStackここまで
            //画面が表示される時に実行される
            .onAppear{
                //カウント（経過時間）の変数を初期化
                count = 0
            }//.onAppearここまで
            
            //ナビゲーションにボタンを追加
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    //ナビゲーション遷移
                    NavigationLink{
                        SettingView()
                    } label: {
                        //テキストを表示
                        Text("秒数設定")
                    }//NavigationLinkここまで
                }//ToolbarItemここまで
            }//toolbarここまで
            //状態変数showAlertがtrueになった時に実行される
            .alert("終了", isPresented: $showAlert){
                Button("OK"){
                    //OKをタップしたときにここが実行される
                    print("OKがタップされました")
                    }
                } message: {
                    Text("タイマー終了時間です")
                }//.alertここまで
        }//NavigationStackここまで
    }//bodyここまで

    //1秒ごとに実行されてカウントダウンする
    func countDownTimer(){
        //count(経過時間)に＋1指定していく
        count += 1

        //残り時間が０以下の時、タイマーを止める
        if timerValue - count <= 0 {
            //タイマー停止
            timerHandler?.invalidate()

            //アラートを表示
            showAlert = true
        }
    }//countDownTimerここまで

    //タイマーをカウントダウン開始する関数
    func startTimer(){
        //timerHandlerをアンラップ
        if let timerHandler{
            //もしタイマーが実行中ならスタートしない
            if timerHandler.isValid == true {
                //何もしない
                return
            }
        }

        //残り時間が０以下の時、count（経過時間）を０に初期化する
        if timerValue - count <= 0 {
            //count(経過時間)を０に初期化する
            count = 0
        }

        //タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            _ in
            //タイマー実行時に呼び出される
            //1秒ごとに実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }
}//ContentViewここまで

#Preview {
    ContentView()
}
