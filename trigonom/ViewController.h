//
//  ViewController.h
//  trigonom
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
{
    CGSize velicina;
}

@property (weak, nonatomic) IBOutlet UIImageView *drawImage;
@property (weak, nonatomic) IBOutlet UISlider *klizac; //postavi min/max 0-6,28
@property (weak, nonatomic) IBOutlet UILabel *labela;

@end

