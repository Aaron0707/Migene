//
//  VoiceListViewController.m
//  MiGene
//
//  Created by Aaron on 15/7/28.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "VoiceListViewController.h"
#import "MiGeneTableViewCell.h"
#import "MiGene.h"

static NSString *const identefier = @"MiGeneTableViewCel";
@interface VoiceListViewController ()

@property (nonatomic, strong) NSArray *dats;
@end

@implementation VoiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"MiGeneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identefier];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.dats = @[
                  @{
                      @"migeneId" : @(4),
                      @"lat" : @(30.5738850000),
                      @"lng" : @(30.5738850000),
                      @"level" : @(15),
                      @"createTime" : @"2015-07-25T18:04:20.000+0800",
                      @"user" : @{
                              @"userId" : @(1),
                              @"nickname" : @"秋叶",
                              @"avatar" : @"http://imgq.duitang.com/uploads/item/201403/05/20140305105955_5mhet.jpeg",
                              @"sex" : @"F",
                              @"signature" : @"dddd"
                              },
                      @"content" : @[ @{
                                          @"type" : @"voice",
                                          @"value" : @"http://gather-hz.oss-cn-hangzhou.aliyuncs.com/0B1D5730-37FD-4904-A7B3-7D8D3EF512F9.mp4",
                                          @"size" : @"30"
                                          }, @{
                                          @"type" : @"text",
                                          @"value" : @"文本内容",
                                          @"size" : @""
                                          }],
                      @"visible" : @"PRIVATE",
                      @"likeCount" : @(0),
                      @"commentCount" : @(0),
                      @"viewCount" : @(0),
                      @"currentUserIsLike" : @(1)
                      },
                  @{
                      @"migeneId" : @(4),
                      @"lat" : @(30.5738850000),
                      @"lng" : @(30.5738850000),
                      @"level" : @(15),
                      @"createTime" : @"2015-07-25T18:04:20.000+0800",
                      @"user" : @{
                              @"userId" : @(1),
                              @"nickname" : @"秋叶",
                              @"avatar" : @"http://imgq.duitang.com/uploads/item/201403/05/20140305105955_5mhet.jpeg",
                              @"sex" : @"F",
                              @"signature" : @"dddd"
                              },
                      @"content" : @[ @{
                                          @"type" : @"voice",
                                          @"value" : @"http://gather-hz.oss-cn-hangzhou.aliyuncs.com/0B1D5730-37FD-4904-A7B3-7D8D3EF512F9.mp4",
                                          @"size" : @"30"
                                          }, @{
                                          @"type" : @"text",
                                          @"value" : @"文本内容",
                                          @"size" : @""
                                          }],
                      @"visible" : @"PRIVATE",
                      @"likeCount" : @(0),
                      @"commentCount" : @(0),
                      @"viewCount" : @(0),
                      @"currentUserIsLike" : @(1)
                      }
                  ];
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -table View Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dats.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiGeneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identefier forIndexPath:indexPath];
    NSError * error;
    MiGene * migene = [[MiGene alloc] initWithDictionary:self.dats[indexPath.row] error:&error];
    
    [cell setMiGene:migene];
    cell.currentLocation = self.location;
    return cell;
}
@end
