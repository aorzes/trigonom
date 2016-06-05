//
//  ViewController.m
//  trigonom
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // uklanja auto layout za određeni objekt
    self.labela.translatesAutoresizingMaskIntoConstraints = YES;
}
-(void)viewDidAppear:(BOOL)animated{

    velicina = self.view.frame.size;
    [self drawArc:_klizac.value];
    [self crtajOznake];
    [self crtajSkalu];
}

//ovo aktivira klizac
- (IBAction)crtaj:(id)sender {
    [self drawArc:_klizac.value];
}

-(void)drawArc:(CGFloat)angle{

    UIGraphicsBeginImageContext(_drawImage.frame.size);
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1, 0, 0, 1);
    CGContextSetLineWidth(myContext, 3.0);
    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 1, 1, 0, 1);
    CGFloat r=velicina.width/4;
    CGPoint centar=CGPointMake(_drawImage.frame.size.width/2, _drawImage.frame.size.height/2);
    CGContextBeginPath (myContext);
    CGContextMoveToPoint (myContext,centar.x,centar.y);
    CGContextAddArc (myContext, centar.x, centar.y,r, 0.0, angle,NO);
    
    //trigonomatrija
    double xl=cos(angle)*r+centar.x;
    double yl=sin(angle)*r+centar.y;
    _labela.center=CGPointMake(xl,yl);
    _labela.text=[NSString stringWithFormat:@"%.2f",angle];
    
    CGContextClosePath (myContext);
    CGContextDrawPath(myContext, kCGPathFillStroke);

    _drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

-(void)crtajOznake{
    NSArray *oznaka=@[@"0",@"Pi/4",@"2Pi/4",@"3Pi/4",@"4Pi/4",@"5Pi/4",@"6Pi/4",@"7Pi/4"];
    CGPoint centar=CGPointMake(_drawImage.frame.size.width/2, _drawImage.frame.size.height/2);
    CGRect kvadrat= CGRectMake(0, 0, 50, 20);
    //font je ralativan u odnosu na context
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];     // set text font
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName: [UIColor blackColor]
                                  };
    double angle=0;
    CGFloat r=velicina.width/3;
    for (int i=0; i<8; i++) {
        UIGraphicsBeginImageContext(kvadrat.size);
        NSString *text1 = [oznaka objectAtIndex:i];
        [text1 drawInRect:kvadrat withAttributes:attributes];
        UIImageView *theImage = [[UIImageView alloc]init];
        theImage.image=UIGraphicsGetImageFromCurrentImageContext();   // extract the image
        double xl=cos(angle)*r+centar.x;
        double yl=sin(angle)*r+centar.y;
        theImage.frame = CGRectMake(xl, yl, kvadrat.size.width, kvadrat.size.height);
        theImage.center=CGPointMake(xl, yl);
        theImage.backgroundColor = [UIColor cyanColor];
        theImage.layer.cornerRadius=10;
        theImage.layer.borderColor = [UIColor grayColor].CGColor;
        theImage.layer.borderWidth = 1;
        [_drawImage addSubview:theImage];
        angle+=M_PI/4;
        UIGraphicsEndImageContext();
    }
    

}

-(void)crtajSkalu{
    CGPoint centar=CGPointMake(_drawImage.frame.size.width/2, _drawImage.frame.size.height/2);
    double angle=0;
    CGFloat r=velicina.width/2;
    for (int i=0; i<16; i++){
        double xl=cos(angle)*r+centar.x;
        double yl=sin(angle)*r+centar.y;
        UIImageView *theDot = [[UIImageView alloc]init];
        theDot.frame=CGRectMake(xl, yl, 10, 10);
        theDot.center=CGPointMake(xl, yl);
        theDot.backgroundColor=[UIColor grayColor];
        theDot.layer.cornerRadius=5;
        [_drawImage addSubview:theDot];
        angle+=M_PI/8;
        
    }


}

@end
