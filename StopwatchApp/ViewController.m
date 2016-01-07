//
//  ViewController.m
//  StopwatchApp
//
//  Created by Norimichi Takagi on 2016/01/07.
//  Copyright © 2016年 NorimichiTakagi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *backgroundView;
    UILabel *timeLabel;
    NSInteger mNumber,sNumber;
    NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //
    mNumber = 0;
    sNumber = 0;
    [self backgroundView];
    [self startButton];
    [self resetButton];
    [self timerView];
}

- (void)backgroundView {
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,568)];
    backgroundView.image = [UIImage imageNamed:(@"default.png")];
    [self.view addSubview:backgroundView];
}

- (void)timerView {
    // タイマー表示 //
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,480,110)];
    timeLabel.center = CGPointMake(160,284);
    timeLabel.font = [UIFont fontWithName:@"HiraKakuProN-w6" size:70];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:timeLabel];
    
    // タイマー桁表示ロジック //
    if(mNumber < 10 && sNumber < 10){
        timeLabel.text = [NSString stringWithFormat:@"0%ld:0%ld",(long)mNumber,(long)sNumber];}
    else if(mNumber >= 10 && sNumber < 10){
        timeLabel.text = [NSString stringWithFormat:@"%ld:0%ld",(long)mNumber,(long)sNumber];}
    else if(mNumber < 10 && sNumber >= 10){
        timeLabel.text = [NSString stringWithFormat:@"0%ld:%ld",(long)mNumber,(long)sNumber];}
    else if(mNumber >= 10 && sNumber >= 10){
    timeLabel.text = [NSString stringWithFormat:@"%ld:%ld",(long)mNumber,(long)sNumber];}

}
// スタートボタン
- (void)startButton {
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startBtn.frame = CGRectMake(0,0,200,50);
    startBtn.center = CGPointMake(160,400);
    [startBtn setTitle:@"スタート" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-w6" size:40 ];
    startBtn.backgroundColor = [UIColor blueColor];
    [startBtn addTarget:self action:@selector(timerStart:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn addTarget:self action:@selector(startPic:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startBtn];

}
// タイマースタート
- (void)timerStart:(id)sender{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:)
                                           userInfo:nil repeats:YES];
    [self stopButton];
}

// ストップボタン
- (void)stopButton{
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopBtn.frame = CGRectMake(0,0,200,50);
    stopBtn.center = CGPointMake(160,400);
    [stopBtn setTitle:@"ストップ" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stopBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-w6" size:40 ];
    stopBtn.backgroundColor = [UIColor redColor];
    [stopBtn addTarget:self action:@selector(timerStop:) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn addTarget:self action:@selector(stopPic:) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:stopBtn];
}
// タイマーストップ
-(void)timerStop:(id)sender{
    [self startButton];
}

// リセットボタン
- (void)resetButton {
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetBtn.frame = CGRectMake(0,0,150,30);
    resetBtn.center = CGPointMake(160,520);
    [resetBtn setTitle:@"リセット" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-w6" size:20 ];
    resetBtn.backgroundColor = [UIColor grayColor];
    [resetBtn addTarget:self action:@selector(timerReset:) forControlEvents:UIControlEventTouchUpInside];
    [resetBtn addTarget:self action:@selector(resetPic:) forControlEvents:UIControlEventTouchUpInside];
    [resetBtn addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:resetBtn];
}
// タイマーリセット
- (void)timerReset:(id)sender {
    sNumber = 0;
    mNumber = 0;
    [self timerView];
    if (timer != nil){
        [timer invalidate];
        timer = nil;
    }
    [self startButton];
}


-(void)tick:(NSTimer*)timer{
    sNumber++;
    if(sNumber == 60){
        sNumber = 0;
        mNumber++;
    }
    [self timerView];
}

// ボタンタッチフラッシュ
- (void)flash:(id)sender {
    backgroundView.image = [UIImage imageNamed:(@"flash.png")];
}

// スタート背景
- (void)startPic:(id)sender {
    backgroundView.image = [UIImage imageNamed:(@"start.png")];
}

// ストップ背景
- (void)stopPic:(id)sender {
    backgroundView.image = [UIImage imageNamed:(@"stop.png")];
    if (timer != nil){
        [timer invalidate];
        timer = nil;
    }
}

// リセット背景
- (void)resetPic:(id)sender {
    backgroundView.image = [UIImage imageNamed:(@"default.png")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
