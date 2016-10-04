//
//  AboutUsViewController.m
//  GIZA LAUNDRY
//
//  Created by Clement on 06/07/16.
//  Copyright © 2016 Clement Freelance. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"


#define isiPhone4  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE


@implementation AboutUsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 25, 30);
        [btn setImage:[UIImage imageNamed:@"sidebar_icon.png"] forState:UIControlStateNormal];
        [btn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *sidebarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [self.navigationItem setLeftBarButtonItem:sidebarButton animated:YES];
        
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
    
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0/255.0 alpha:1.0]];
    

    CGFloat xValue = (([UIScreen mainScreen].bounds.size.width)/2)-75;
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xValue, 5, 150 , 45)];[titleImageView setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = titleImageView;
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 50)];
    titleLabel.text = @"   ABOUT US";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:titleLabel];
    
    
    
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,50, self.view.frame.size.width , self.view.frame.size.height-110)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    
    
    
    if(isiPhone4){
    
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height);
    
    
    }else{
        
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height-90);
    
    }
    
    
    

        
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,0, self.view.frame.size.width -10 , self.view.frame.size.height-100)];
    
    if(isiPhone4){
        
        detailLabel.frame = CGRectMake(5,0, self.view.frame.size.width -10 , self.view.frame.size.height);
        
    }else if(isiPhone6 || isiPhone6Plus){
        
        
        detailLabel.frame = CGRectMake(5,0, self.view.frame.size.width -10 , self.view.frame.size.height-250);
        
    }
    
    NSString *text = @"GIZA LAUNDRY was built with the explicit goal of providing customers with the most convenient, easy and high quality way to do their laundry. We offer you with professional dry cleaning, washing, and steam pressing. Our company along with its main office is located near one of Doha’s most popular area, Old Airport Street.\nWe also offer you with the pick and drop and App services that would help you in your busy schedule. It is integrated throughout our operations and ensures that we can give you high quality products, in a faster time frame. If you use our service, you’ll experience the difference.\nOur workers have years of experience in all categories of services and their priority relays on the quality of work they do to reach the highest. You will be assured that your items will be cleaned to the highest standards, always achieving the same amusing results.\n\nTrust us, when we say our service and quality is the best in cleaning your laundry, \n\n\t\t\tWe Mean Clean !";
    
    if(isiPhone6 || isiPhone6Plus){
        
        
        text = @"GIZA LAUNDRY was built with the explicit goal of providing customers with the most convenient, easy and high quality way to do their laundry. We offer you with professional dry cleaning, washing, and steam pressing. Our company along with its main office is located near one of Doha’s most popular area, Old Airport Street.\nWe also offer you with the pick and drop and App services that would help you in your busy schedule. It is integrated throughout our operations and ensures that we can give you high quality products, in a faster time frame. If you use our service, you’ll experience the difference.\nOur workers have years of experience in all categories of services and their priority relays on the quality of work they do to reach the highest. You will be assured that your items will be cleaned to the highest standards, always achieving the same amusing results.\n\nTrust us, when we say our service and quality is the best in cleaning your laundry, \n\n\t\t\t\tWe Mean Clean !";
        
    }
    
    
    //@"Have a cool story about how your product or service was helps change lives? put it on your About Us page. Good stories humanise your brand and provide context and meaning of your product. Whats more, good stories are sticky which means people are more likely to connect with and pass them on.. ";
    //detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:detailLabel];
    
    
    
    
    
    NSRange range = [text rangeOfString:@"GIZA LAUNDRY"];
    
    
    NSRange range1 = [text rangeOfString:@"dry cleaning, washing, and steam pressing"];
    
    
    NSRange range2 = [text rangeOfString:@"pick and drop and App services"];
    
    
    NSRange range3 = [text rangeOfString:@"Trust us, when we say our service and quality is the best in cleaning your laundry,"];
    
    
    NSRange range4 = [text rangeOfString:@"We Mean Clean !"];
    
    
    
    
    
    
    
    
    
    
    if ([detailLabel respondsToSelector:@selector(setAttributedText:)])
    {
        
        // Create the attributes
        
        
        
        
        const CGFloat fontSize = 15;
        NSDictionary *attrs = @{
                                NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:16],
                                NSForegroundColorAttributeName:[UIColor blackColor]
                                };
        
        
        NSDictionary *attrs1 = @{
                                NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:fontSize],
                                NSForegroundColorAttributeName:[UIColor blackColor]
                                };
        
        NSDictionary *attrs2 = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"Arial" size:fontSize],
                                 NSForegroundColorAttributeName:[UIColor blueColor]
                                 };
        
        NSDictionary *attrs3 = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:18],
                                 NSForegroundColorAttributeName:[UIColor brownColor]
                                 };
        
        
        NSDictionary *subAttrs = @{
                                   NSFontAttributeName:[UIFont fontWithName:@"Arial" size:fontSize]
                                   };
        
        
        
        /////////////////////////////////
        
        
        
        //const NSRange range = NSMakeRange(9,[text length]-9);
        
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:subAttrs];
        [attributedText setAttributes:attrs range:range];
        [attributedText setAttributes:attrs1 range:range1];
        [attributedText setAttributes:attrs1 range:range2];
        [attributedText setAttributes:attrs2 range:range3];
        [attributedText setAttributes:attrs3 range:range4];
        
        // Set it in our UILabel and we are done!
        [detailLabel setAttributedText:attributedText];
        
        
        MYLog(@"OK");
        
    }

    
    
    
    
    
    
    
    [self.view addSubview:scrollView];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
