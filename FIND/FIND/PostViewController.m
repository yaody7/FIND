//
//  PostViewController.m
//  FIND
//
//  Created by ydy on 2020/2/29.
//  Copyright © 2020 ydy. All rights reserved.
//
#define X_OFFSET 0.05 * self.view.frame.size.width
#define WIDTH 0.9 * self.view.frame.size.width
#import "PostViewController.h"
#import "UITextViewWithPlaceholder.h"

@interface PostViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *radioButton; //0 for lose, 1 for find
    UIImage *toClick;
    UIImage *clicked;
    UIButton *btn;
    UILabel *placeholder;
}

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //init image
    self->toClick = [UIImage imageNamed:@"toClick.png"];
    self->clicked = [UIImage imageNamed:@"clicked.png"];
    //add subview
    [self.view addSubview:self.thing];
    [self.view addSubview:self.choose];
    [self.view addSubview:self.image];
    [self.view addSubview:self.detail];
    //set confirm bar
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.confirm];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    //set title
    self.title = @"POST";
    //set backgroundColor
    self.view.backgroundColor = UIColor.whiteColor;
    
}
- (UIView *)choose{
    CGFloat yOffset = 0.01 * self.view.frame.size.height;
    CGFloat height = 0.1 * self.view.frame.size.height;
    _choose = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, WIDTH, height)];
    //title
    UILabel *c = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, WIDTH, height / 3)];
    c.text = @"LOST/FOUND:";
    c.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_choose addSubview:c];
    //radio button
    //button 1
    CGFloat xOffset = 0;//0.05 * self.view.frame.size.width;
    radioButton = [[NSArray alloc]initWithObjects:[[UIButton alloc]init], [[UIButton alloc]init], nil];
    UIButton *tmp = ((UIButton *)[radioButton objectAtIndex:0]);
    tmp.frame = CGRectMake(xOffset, height / 2.1, height / 6, height / 6);
    [tmp setImage:self->toClick forState:normal];
    [tmp addTarget:self action:@selector(clickLose) forControlEvents:UIControlEventTouchUpInside];
    [_choose addSubview:tmp];
    //button 2
    tmp = ((UIButton *)[radioButton objectAtIndex:1]);
    tmp.frame = CGRectMake(xOffset, 2 * height / 2.5, height / 6, height / 6);
    [tmp setImage:self->toClick forState:normal];
    [tmp addTarget:self action:@selector(clickFind) forControlEvents:UIControlEventTouchUpInside];
    [_choose addSubview:tmp];
    xOffset += 0.06 * self.view.frame.size.width;
    //label 1
    UILabel *l = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(xOffset, height / 2.55, WIDTH, height / 3)];
    l.text = @"I lose something...";
    l.font = [UIFont systemFontOfSize:25];
    [_choose addSubview:l];
    //label 2
    UILabel *f = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(xOffset, 2 * height / 2.9, WIDTH, height / 3)];
    f.text = @"I find something...";
    f.font = [UIFont systemFontOfSize:25];
    [_choose addSubview:f];
    return _choose;
}

- (UIView *)thing{
    CGFloat yOffset = 0.13 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 0.2 * self.view.frame.size.height / 3;
    _thing = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *t = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    t.text=@"THING:";
    t.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_thing addSubview:t];
    //set textfield
    yOffset = 0.15 * self.view.frame.size.height;
    width = self.view.frame.size.width - X_OFFSET;
    height = 30;
    UITextViewWithPlaceholder *textView = [[UITextViewWithPlaceholder alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, 35)];
    textView.font = [UIFont systemFontOfSize:25];
    textView.placeholder.text = @"Insert breif introduction...";
    [_thing addSubview:textView];
    return _thing;
}

- (UIView *)image{
    CGFloat yOffset = 0.23 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 3 * width / 4 + 35 ;
    _image = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *i = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    i.text=@"PICTURE:";
    i.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_image addSubview:i];
    //set image
    btn = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, 3 * width / 4)];
    [btn setTitle:@"Click to choose picture..." forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setBorderColor:UIColor.grayColor.CGColor];
    [btn.layer setBorderWidth:2];
    btn.titleLabel.font = [UIFont systemFontOfSize:25];
    [_image addSubview:btn];
    return _image;
}

- (UIView *)detail{
    CGFloat yOffset = 0.6 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 3 * width / 4 + 35 ;
    _detail = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *d = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    d.text=@"DETAIL:";
    d.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_detail addSubview:d];
    //set textview
    UITextViewWithPlaceholder *textView = [[UITextViewWithPlaceholder alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, height - 35)];
    textView.font = [UIFont systemFontOfSize:25];
    textView.placeholder.text = @"Insert detail....";
    textView.placeholder.font = [UIFont systemFontOfSize:25];
    textView.placeholder.textColor = UIColor.grayColor;
    [_detail addSubview:textView];
    return _detail;
}

- (UIButton *)confirm{
    CGFloat x = 0.05 * self.view.frame.size.width;
    CGFloat y = 0.45 * self.view.frame.size.height;
    CGFloat width = 0.12 * self.view.frame.size.width;
    CGFloat height = 0.04 * self.view.frame.size.height;
    _confirm = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [_confirm setTitle:@"Done" forState:UIControlStateNormal];
    _confirm.backgroundColor = UIColor.greenColor;
    [_confirm addTarget:self action:@selector(doConfirm) forControlEvents:UIControlEventTouchUpInside];
    [_confirm.layer setCornerRadius:10];
    _confirm.titleLabel.font = [UIFont systemFontOfSize: 20.0 weight:UIFontWeightBold];
    return _confirm;
}
- (void)doConfirm{
    //TODO send urlsession
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)chooseImage{
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    PickerImage.allowsEditing = YES;
    PickerImage.delegate = self;
    [self presentViewController:PickerImage animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [self->btn setImage:[info objectForKey:@"UIImagePickerControllerEditedImage"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickLose{
    [((UIButton *)[self->radioButton objectAtIndex:0]) setImage:self->clicked forState:UIControlStateNormal];
    [((UIButton *)[self->radioButton objectAtIndex:1]) setImage:self->toClick forState:UIControlStateNormal];
}

- (void)clickFind{
    [((UIButton *)[self->radioButton objectAtIndex:1]) setImage:self->clicked forState:UIControlStateNormal];
    [((UIButton *)[self->radioButton objectAtIndex:0]) setImage:self->toClick forState:UIControlStateNormal];
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
