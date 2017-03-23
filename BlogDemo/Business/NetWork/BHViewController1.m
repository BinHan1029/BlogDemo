//
//  BHViewController6.m
//  BlogDemo
//
//  Created by HanBin on 16/4/27.
//  Copyright © 2016年 BinHan. All rights reserved.
//

#import "BHViewController1.h"
#import "UILabel+BH.h"
#import "UIButton+BH.h"

@interface BHViewController1()

/**
 开始按钮
 */
@property (nonatomic, strong) UIButton *button;

/**
 response 结果视图
 */
@property (nonatomic, strong) UILabel *label;

/**
 解析 repsonse 数据
 */
@property (nonatomic, strong) NSMutableAttributedString * attrStr;

/**
 AFN 请求标识
 */
@property (nonatomic, assign) NSUInteger taskIdentifier;

@end

@implementation BHViewController1

#pragma mark -cricle

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
}

- (void)dealloc
{
    NSLog(@"%@-释放了",self.class);
    [[BHNetReqManager sharedManager] cancelDataTask:self.taskIdentifier];
}

#pragma mark - Intial Methods

-(void)setUp
{
    [self.view addSubview:self.label];
    [self.view addSubview:self.button];
    [self.view setNeedsUpdateConstraints];
    RAC(self.label, attributedText) = [RACObserve(self, attrStr) distinctUntilChanged];
}

-(void)updateViewConstraints
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(kNavBarHeight + 10.f);
        make.height.mas_equalTo(45.f);
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.button.mas_bottom).mas_offset(50.f);
    }];
    [super updateViewConstraints];
}


#pragma mark - Target Methods

#pragma mark - Private Method

-(UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeSystem].bh_title(@"链式创建UlButton，点击开始网络请求").bh_titleColor([UIColor blueColor]);
        @weakify(self);
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [self signInSignal];
        }];
    }
    return  _button;
}

-(UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init].bh_textColor([UIColor redColor]).bh_textFont(14.f).bh_numberOfLines(0).bh_textAlignment(NSTextAlignmentCenter).bh_text(@"链式创建UlLable");
    }
    return _label;
}

- (RACSignal *)signInSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        self.taskIdentifier = [[BHNetReqManager sharedManager].bh_requestUrl(@"http://binhan1029.github.io/").bh_requestType(GET).bh_responseSerializer(HTTPResponseSerializer).bh_parameters(nil) startRequestWithCompleteHandler:^(id response, NSError *error) {
            if (response)
            {
                NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
                NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[result dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                self.attrStr = attrStr;
            }
            else if(error)
            {
                [MBProgressHUD showHintMessage:error.localizedDescription];
            }
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate


@end
