//
//  DetailViewController.m
//  MiGene
//
//  Created by 0001 on 15/7/28.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "DetailViewController.h"
#import "UILabel+StringFrame.h"

#define NavigationBarHeight 64

@interface DetailViewController ()<UIScrollViewDelegate>
{
    NSInteger imageCount;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initializeAppearence];
    // Do any additional setup after loading the view.
}

- (void)initializeAppearence
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Return"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    [self addSubView];
}



- (void)addSubView
{
    UIView *mainSubView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, kMainScreenWidth, kMainScreenHeight - NavigationBarHeight)];
    mainSubView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainSubView];
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:mainSubView.bounds];
    [mainSubView addSubview:mainScrollView];
    UIView *subView = [[UIView alloc] initWithFrame:mainSubView.bounds];
    [mainScrollView addSubview:subView];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * kWidthRatio, 10 * kHeightRatio, 50, 50)];
    headerImageView.layer.cornerRadius = 25;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.backgroundColor = [UIColor greenColor];
    [subView addSubview:headerImageView];
    
    CGSize nicknameSize = [@"Miuky Moco" sizeWithAttributes:@{NSFontAttributeName:Chinese_Font_13, NSForegroundColorAttributeName : MiGene_Color_Black}];
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame) + 10 * kWidthRatio, 20 * kHeightRatio, nicknameSize.width, nicknameSize.height)];
    nicknameLabel.font = Chinese_Font_13;
    nicknameLabel.textColor = MiGene_Color_Black;
    nicknameLabel.text = @"Miuky Moco";
    [subView addSubview:nicknameLabel];
    
    CGSize timeLabelSize = [@"2小时前" sizeWithAttributes:@{NSFontAttributeName:Chinese_Font_12, NSForegroundColorAttributeName : MiGene_Color_GrayTime}];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nicknameLabel.frame), CGRectGetMaxY(nicknameLabel.frame) + 5 * kHeightRatio, timeLabelSize.width, timeLabelSize.height)];
    timeLabel.font = Chinese_Font_12;
    timeLabel.textColor = MiGene_Color_GrayTime;
    timeLabel.text = @"2小时前";
    [subView addSubview:timeLabel];
    
    UIButton *playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playbutton setImage:[UIImage imageNamed:@"detail_play"] forState:UIControlStateNormal];
    playbutton.frame = CGRectMake(CGRectGetWidth(subView.frame) - 20 * kWidthRatio - 45, 13 * kHeightRatio, 45, 45);
    [subView addSubview:playbutton];
    
    CGSize timeLengthSize = [@"114\"" sizeWithAttributes:@{NSFontAttributeName:Chinese_Font_11, NSForegroundColorAttributeName : MiGene_Color_GrayTimeLength}];
    UILabel *timeLengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(playbutton.frame) - timeLengthSize.width - 20, CGRectGetMinY(timeLabel.frame), timeLengthSize.width, timeLengthSize.height)];
    timeLengthLabel.font = Chinese_Font_11;
    timeLengthLabel.textColor = MiGene_Color_GrayTimeLength;
    timeLengthLabel.text = @"113\"";
    [subView addSubview:timeLengthLabel];
    
    UIImageView *mapImageView = [[UIImageView alloc] init];
    
    if ([self.playType isEqualToString:@"all"]) {
        UIView *imagesView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(headerImageView.frame) + 10 *kHeightRatio, kMainScreenWidth - 20, kWidthRatio * 214)];
        [subView addSubview:imagesView];
        
        imageCount = 3;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:imagesView.bounds];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(imagesView.frame) * imageCount, CGRectGetHeight(imagesView.frame));
        scrollView.pagingEnabled = YES;
        [imagesView addSubview:scrollView];
        for (NSInteger i = 0; i < imageCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *CGRectGetWidth(imagesView.frame), 0, CGRectGetWidth(imagesView.frame), CGRectGetHeight(imagesView.frame))];
            imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
            imageView.image = [UIImage imageNamed:@"splash_bg.png"];
            imageView.tag = i * 100;
            [scrollView addSubview:imageView];
        }
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.text = @"今年5月，江苏一男子盛某就因开车看股票行情，一不留意竟松了刹车，结果撞上了前车，事故造成前车车大灯受损，车尾局部车漆掉落，据估计，车损要两千多元。";
        textLabel.font = Chinese_Font_14;
        textLabel.textColor = MiGene_Color_Black;
        CGSize textLabelSize = [textLabel boundingRectWithSize:CGSizeMake(kMainScreenWidth - 20 * kWidthRatio, MAXFLOAT)];
        textLabel.frame = (CGRect){{10 * kWidthRatio, CGRectGetMaxY(imagesView.frame) + 17 * kHeightRatio},textLabelSize};
        [subView addSubview:textLabel];
        
        [mapImageView setFrame:CGRectMake(10 * kWidthRatio, CGRectGetMaxY(textLabel.frame) + 17 * kHeightRatio, 35, 35)];
    }else if ([self.playType isEqualToString:@"text"])
    {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.text = @"今年5月，江苏一男子盛某就因开车看股票行情，一不留意竟松了刹车，结果撞上了前车，事故造成前车车大灯受损，车尾局部车漆掉落，据估计，车损要两千多元。";
        textLabel.font = Chinese_Font_14;
        textLabel.textColor = MiGene_Color_Black;
        CGSize textLabelSize = [textLabel boundingRectWithSize:CGSizeMake(kMainScreenWidth - 20 * kWidthRatio, MAXFLOAT)];
        textLabel.frame = (CGRect){{10 * kWidthRatio, CGRectGetMaxY(headerImageView.frame) + 17 * kHeightRatio},textLabelSize};
        [subView addSubview:textLabel];
        
        [mapImageView setFrame:CGRectMake(10 * kWidthRatio, CGRectGetMaxY(textLabel.frame) + 17 * kHeightRatio, 35, 35)];
    }
    else if ([self.playType isEqualToString:@"none"])
    {
        [mapImageView setFrame:CGRectMake(10 * kWidthRatio, CGRectGetMaxY(headerImageView.frame) + 10 * kHeightRatio, 35, 35)];
    }
    
    
    mapImageView.image = [UIImage imageNamed:@"Map"];
    [subView addSubview:mapImageView];
    
    //点赞数量label
    NSString *countText = @"12";
    CGSize timeSize = [countText sizeWithAttributes:@{NSFontAttributeName:Chinese_Font_13, NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    UILabel *praiseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(subView.frame) - 12 - timeSize.width, CGRectGetMinY(mapImageView.frame) + 20, timeSize.width, timeSize.height)];
    praiseCountLabel.font = Chinese_Font_12;
    praiseCountLabel.textColor = MiGene_Color_GrayTimeLength;
    praiseCountLabel.text = countText;
    [subView addSubview:praiseCountLabel];
    
    //点赞的图片
    UIImageView *praiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(praiseCountLabel.frame) - 20, CGRectGetMidY(praiseCountLabel.frame) - 7, 17, 15)];
    praiseImageView.image = [UIImage imageNamed:@"red-heart"];
    [subView addSubview:praiseImageView];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.font = Chinese_Font_12;
    addressLabel.textColor = MiGene_Color_GrayTimeLength;
    addressLabel.text = @"奥克斯广场b座10-10－1023";
    CGSize addressLabelSize = [addressLabel boundingRectWithSize:CGSizeMake(CGRectGetMinX(praiseImageView.frame) - CGRectGetMaxX(mapImageView.frame), 13)];
    addressLabel.frame = (CGRect){{CGRectGetMaxX(mapImageView.frame) + 5 *kWidthRatio, CGRectGetMinY(mapImageView.frame) + 22}, addressLabelSize};
    [subView addSubview:addressLabel];
    
    CGRect rect = subView.frame;
    rect.size.height = CGRectGetMaxY(addressLabel.frame) + 10;
    subView.frame = rect;
    
    mainScrollView.contentSize = CGSizeMake(kMainScreenWidth, CGRectGetHeight(rect) + 10);
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(subView.frame), kMainScreenWidth, 10)];
    grayView.backgroundColor = ColorRGBA(240, 240, 240, 1);
    grayView.layer.borderColor = ColorRGBA(225, 225, 225, 1).CGColor;
    grayView.layer.borderWidth = 0.5;
    [mainScrollView addSubview:grayView];
}



-(void)backAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
