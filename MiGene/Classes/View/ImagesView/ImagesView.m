//
//  ImagesView.m
//  SuperCard
//
//  Created by x1371 on 15/2/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "ImagesView.h"
#import "ImageEditView.h"
#import "ELCImagePickerController.h"
#import "UIButton+Lcy.h"
#import "Tools.h"
#import "UIImageView+Lcy.h"
#import <AssetsLibrary/ALAsset.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MWPhotoBrowser.h"
#import "UIBarButtonItem+Lcy.h"
#define kImageViewLineCount 4
#define kImageViewCount 4
@interface ImagesView()<UIActionSheetDelegate, ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MWPhotoBrowserDelegate>
@property (nonatomic, assign) ImagesType imagesType;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, assign) int selectedIndexs;
@property (nonatomic, assign) CGSize phoneViewSize;
@property (nonatomic, assign) CGFloat marginX;
@property (nonatomic, weak) ELCImagePickerController *elcPicker;
@end
@implementation ImagesView
-(id)initWithFrame:(CGRect)frame imagesType:(ImagesType)imagesType marginX:(CGFloat)marginX
{
    if (self = [super initWithFrame:frame]) {
        self.imagesType = imagesType;
        self.marginX = marginX;
        [self setupAll];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.bCanTapImage = NO;
    }
    
    return self;
}

-(void)setupAll
{
    self.imageViews = [NSMutableArray arrayWithCapacity:kImageViewCount];
    self.imagesData = [NSMutableArray arrayWithCapacity:kImageViewCount];
    CGFloat marginCount = self.imagesType == ImagesTypeEdit ? kImageViewCount + 1 : kImageViewCount - 1;
    CGFloat phoneViewW = (self.width - marginCount*self.marginX)/kImageViewLineCount;

    self.phoneViewSize = CGSizeMake(phoneViewW, phoneViewW);
    
//   设定添加想法时的高度
    self.height = (self.imageUrls.count / 3 + 2)*self.marginX + phoneViewW * (self.imageUrls.count / 3 + 1) * 1;
    
    if(self.imagesType == ImagesTypeEdit)
    {
        UIButton * addBtn = [UIButton buttonItemWithNormalImage:[UIImage imageNamed:@"btn_Image_new"] highlightImage:[UIImage imageNamed:@"btn_add_new_s"] target:self action:@selector(addBtnClick:)];
        addBtn.frame = (CGRect){{self.marginX ,self.marginX} ,self.phoneViewSize};
        [self addSubview:addBtn];
        self.addBtn = addBtn;
    }
    else
    {
        for (int i=0; i<kImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){CGPointMake(0, self.marginX), self.phoneViewSize}];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            imageView.tag = i;
            [self addSubview:imageView];
            if (self.imagesType == ImagesTypeShowBig) {
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
                [imageView addGestureRecognizer:tap];
            }
        }
    }
}



-(UIViewController *) getCurrentViewController
{
    id object = [self nextResponder];
    while (object != nil && ![object isKindOfClass:[UIViewController class]]) {
        object = [object nextResponder];
    }
    
    UIViewController * viewController = nil;
    if(object != nil && [object isKindOfClass:[UIViewController class]])
    {
        viewController = (UIViewController *) object;
    }
    
    return viewController;
}

#pragma mark 展示图片类型
-(void)setImageUrls:(NSArray *)imageUrls
{
    _imageUrls = imageUrls;
    if (imageUrls.count ==1) {
        UIImageView *imageView = (UIImageView *)self.subviews[0];
        imageView.width = self.width;
    }
    
    //设置本imageView的外部高度
    CGFloat marginCount = self.imagesType == ImagesTypeEdit ? kImageViewCount + 1 : kImageViewCount - 1;
    CGFloat phoneViewW = (self.width - marginCount*self.marginX)/kImageViewLineCount;
    self.height = (self.imageUrls.count / 4 + 2)*self.marginX + phoneViewW * (self.imageUrls.count / 4 + 1);
    
    self.photos = [NSMutableArray arrayWithCapacity:[_imageUrls count]];
    for (int i=0; i< kImageViewCount; i++)
    {
        UIImageView *imageView = (UIImageView *)self.subviews[i];
        //imageView.tag = i;
        imageView.size = self.phoneViewSize;
        if (i < [_imageUrls count]) {
           
            [imageView setImageWithURL:_imageUrls[i] placeholderImagePathString:YLImageDefault];
            imageView.hidden = NO;
            NSURL *url = [NSURL URLWithString:_imageUrls[i]];
            [self.photos addObject:[MWPhoto photoWithURL:url]];
        }
        else
            imageView.hidden = YES;
    }
}

-(void)tapImage:(UIGestureRecognizer *) gr
{
    ProLog(@"image tap ===========");
}

-(void)setImageUrls:(NSString *)imageUrl width:(CGFloat)w height:(CGFloat)h{
    _imageUrls = @[imageUrl];
    
    for (int i=0; i< kImageViewCount; i++)
    {
        UIImageView *imageView = (UIImageView *)self.subviews[i];
        

        if (i < [_imageUrls count]) {

            
            self.photos = [NSMutableArray arrayWithCapacity:[_imageUrls count]];
            NSURL *url = [NSURL URLWithString:_imageUrls[i]];
            [self.photos addObject:[MWPhoto photoWithURL:url]];
            
            [imageView setImageWithURL:_imageUrls[i] placeholderImagePathString:YLImageDefault];
            imageView.hidden = NO;
           
            if (w>self.width) {
                imageView.width = self.width;
                self.height = 
                imageView.height = self.width/w*h;
            }else{
                imageView.width = w;
                self.height = 
                imageView.height = h;
            }
            imageView.x = 0;
            imageView.y = 0;
        }
        else{
            imageView.hidden = YES;
        }
    }

}

-(void)clickImage:(UIGestureRecognizer *)gr
{
    if(self.parentVC == nil)
        return;
    
    MWPhotoBrowser *browser = [self getPhotoBrowser];
    [browser setCurrentPhotoIndex:gr.view.tag];
    [browser reloadData];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    [self.parentVC presentViewController:nc animated:NO completion:nil];
}


-(MWPhotoBrowser *)getPhotoBrowser
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = NO; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    return browser;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}


#pragma mark 编辑图片类型
-(void)addBtnClick:(UIButton *)btn
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"添加照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [action showInView:self];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self selectPicWithCount:kImageViewCount - self.selectedIndexs];
    }
    else if (buttonIndex == 1)
    {
        [self takePhoto];
    }
}

#pragma mark 照相
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    [self showPhoto:sourceType];
}

-(void)showPhoto:(UIImagePickerControllerSourceType) sourceType
{
    if([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = sourceType;
        imagePickerController.videoQuality=UIImagePickerControllerQualityTypeLow;
        [self.parentVC presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        [Tools showToastWithMessage:@"不支持相机."];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(image, kCompressionQuality);
    UIImage *newImage = [UIImage imageWithData:imageData];
    ImageEditView *imageView = [[ImageEditView alloc] initWithFrame:(CGRect){CGPointMake(0, self.marginX), self.phoneViewSize}];
    imageView.image = newImage;
    __weak __typeof(self) weakSelf = self;
    [imageView registerClearBlock:^(NSInteger index) {
        [weakSelf.imageViews removeObjectAtIndex:index];
        [weakSelf.imagesData removeObjectAtIndex:index];
        weakSelf.selectedIndexs -= 1;
        for (int i=0; i<self.selectedIndexs; i++) {
            ((UIImageView *)weakSelf.imageViews[i]).tag = i;
        }
        [weakSelf setNeedsLayout];
    }];
    NSMutableDictionary * imagesDic = [[NSMutableDictionary alloc]init];
    [imagesDic setObject:imageData forKey:@"imageData"];
    NSString *sizeStr = [NSString stringWithFormat:@"%.0f,%.0f",imageView.image.size.width,imageView.image.size.height];
    [imagesDic setObject:sizeStr forKey:@"imageSize"];
    
    [self.imagesData addObject:imagesDic];
    [self.imageViews addObject:imageView];
    [self addSubview:imageView];
    self.selectedIndexs +=1;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 多选选择器
-(void)selectPicWithCount:(NSUInteger)picCount
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.delegate = self;
    elcPicker.maximumImagesCount = picCount; //Set the maximum number of images to select, defaults to 4
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage];
    elcPicker.imagePickerDelegate = self;
    self.elcPicker = elcPicker;
    [self.parentVC presentViewController:elcPicker animated:YES completion:nil];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count > 1)
    {
        UIBarButtonItem *leftBarBtnItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"nav_back"] selectedImage:nil target:self action:@selector(backClick)];
        viewController.navigationItem.leftBarButtonItem = leftBarBtnItem;
    }
}

-(void)backClick
{
    [self.elcPicker popViewControllerAnimated:YES];
}

//图片布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.imagesType == ImagesTypeEdit)
    {
        for (int i=0; i<self.selectedIndexs; i++) {
            UIImageView *imageView = self.imageViews[i];
            imageView.tag = i;
            imageView.x = self.marginX + (self.phoneViewSize.width + self.marginX ) * (i % kImageViewLineCount);
            imageView.y = self.marginX + (self.phoneViewSize.height + self.marginX) * (i / kImageViewLineCount);
        }
        if (self.selectedIndexs < kImageViewCount) {
            self.addBtn.x = self.marginX + (self.phoneViewSize.width + self.marginX ) * (self.selectedIndexs % kImageViewLineCount);
            self.addBtn.y = self.marginX + (self.phoneViewSize.height + self.marginX) * (self.selectedIndexs / kImageViewLineCount);
            self.addBtn.hidden = NO;
        }
        else if(self.selectedIndexs == kImageViewCount)
        {
            self.addBtn.hidden = YES;
        }
        
        CGFloat marginCount = self.imagesType == ImagesTypeEdit ? kImageViewCount + 1 : kImageViewCount - 1;
        CGFloat phoneViewW = (self.width - marginCount*self.marginX)/kImageViewLineCount;
        self.height = (self.selectedIndexs / 3 + 2)*self.marginX + phoneViewW * (self.imageViews.count / kImageViewLineCount +(self.imageViews.count<kImageViewLineCount?1:0)) ;
        
        if ([_delegate respondsToSelector:@selector(ImagesViewChangeImage:)]) {
            [_delegate ImagesViewChangeImage:self];
        }
    }
    else
    {
        NSArray *imageViews = self.subviews;
//        for (int i=0; i<[imageViews count]; i++) {
//            ((UIImageView *)imageViews[i]).x = (self.phoneViewSize.width + self.marginX) * i;
//        }
        CGFloat marginCount = self.imagesType == ImagesTypeEdit ? kImageViewCount + 1 : kImageViewCount - 1;
        CGFloat phoneViewW = (self.width - marginCount*self.marginX)/kImageViewLineCount;
        
        for (int i = 0; i < [imageViews count] / 3; i ++) {
            for (int j = 0; j < 3; j ++) {
                ((UIImageView *)imageViews[i * 3 + j]).x = (self.phoneViewSize.width + self.marginX) * j;
                ((UIImageView *)imageViews[i * 3 + j]).y = self.marginX * (i + 1) + phoneViewW * i;
            }
        }
        self.height = (self.selectedIndexs / 3 + 2)*self.marginX + phoneViewW * (self.imageViews.count / 3 + 1) ;
    }
    if ([self.imageUrls count]==1) {
        UIImageView *imageView = (UIImageView *)self.subviews[0];
        self.height = imageView.height;
    }
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (int i=self.selectedIndexs;i <[info count] + self.selectedIndexs;i++)
    {
        NSDictionary *dict = info[i - self.selectedIndexs];
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                UIImage *image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                NSData *imageData = UIImageJPEGRepresentation(image, kCompressionQuality);
                UIImage *newImage = [UIImage imageWithData:imageData];
                ImageEditView *imageView = [[ImageEditView alloc] initWithFrame:(CGRect){CGPointMake(0, self.marginX), self.phoneViewSize}];
                imageView.image = newImage;
                __weak __typeof(self) weakSelf = self;
                [imageView registerClearBlock:^(NSInteger index) {
                    [weakSelf.imageViews removeObjectAtIndex:index];
                    [weakSelf.imagesData removeObjectAtIndex:index];
                    weakSelf.selectedIndexs -= 1;
                    for (int i=0; i<self.selectedIndexs; i++) {
                        ((UIImageView *)weakSelf.imageViews[i]).tag = i;
                    }
                    [weakSelf setNeedsLayout];
                }];
                
                NSMutableDictionary * imagesDic = [[NSMutableDictionary alloc]init];
                [imagesDic setObject:imageData forKey:@"imageData"];
                NSString *sizeStr = [NSString stringWithFormat:@"%.0f,%.0f",imageView.image.size.width,imageView.image.size.height];
                [imagesDic setObject:sizeStr forKey:@"imageSize"];
                
                [self.imagesData addObject:imagesDic];
                [self.imageViews addObject:imageView];
                [self addSubview:imageView];
            }
        }
    }
    self.selectedIndexs += (int)[info count];
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

@end
