#import "ViewController.h"

#define LEFT_INDENT 15
#define TOP_INDENT 75
#define WIDTH_SCREEN UIScreen.mainScreen.bounds.size.width
#define HEIGHT_SCREEN UIScreen.mainScreen.bounds.size.height
#define COEFF_OF_SREEN_WIDTH 0.67



@interface ViewController ()

@property (nonatomic, strong) UILabel *labelResultColor;
@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;

@property (nonatomic, strong) UITextField *textFieldRed;
@property (nonatomic, strong) UITextField *textFieldGreen;
@property (nonatomic, strong) UITextField *textFieldBlue;

@property (nonatomic, strong) UIButton *buttonProcess;

@property (nonatomic, strong) UIView *viewResultColor;


@end


@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupLabels];
    [self setupResultView];
    [self setupTextFields];
    [self setupButton];
    [self subscribeAccessibilityIdentifier];
}

- (void)setupButton {
    self.buttonProcess = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonProcess.frame = CGRectMake(WIDTH_SCREEN/2-60, HEIGHT_SCREEN/2, 120, 35);
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    self.buttonProcess.titleLabel.textColor = UIColor.blueColor;
    [self.buttonProcess addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.buttonProcess];
}

- (void)setupResultView {
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(110,
                                                                    TOP_INDENT-10,
                                                                    WIDTH_SCREEN*0.60-25,
                                                                    45)];
    self.viewResultColor.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.viewResultColor];
}

- (void)setupTextFields {
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(85,
                                                                      2*TOP_INDENT,
                                                                      WIDTH_SCREEN*0.60,
                                                                      35)];
    self.textFieldRed.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldRed.placeholder = @"0..255";
    
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(85,
                                                                        3*TOP_INDENT,
                                                                        WIDTH_SCREEN*0.60,
                                                                        35)];
    self.textFieldGreen.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldGreen.placeholder = @"0..255";
    
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(85,
                                                                       4*TOP_INDENT,
                                                                       WIDTH_SCREEN*0.60,
                                                                       35)];
    self.textFieldBlue.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldBlue.placeholder = @"0..255";
    
    [self.textFieldRed addTarget:self action:@selector(handleOpenField:) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldGreen addTarget:self action:@selector(handleOpenField:) forControlEvents:UIControlEventAllTouchEvents];
    [self.textFieldBlue addTarget:self action:@selector(handleOpenField:) forControlEvents:UIControlEventAllTouchEvents];
    
    
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
}

- (void)setupLabels {

    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INDENT,
                                                                      TOP_INDENT-10,
                                                                      70,
                                                                      45)];

    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INDENT,
                                                              2*TOP_INDENT,
                                                              70,
                                                              35)];

    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INDENT,
                                                                3*TOP_INDENT,
                                                                70,
                                                                35)];

    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_INDENT,
                                                               4*TOP_INDENT,
                                                               70,
                                                               35)];
    self.labelResultColor.text = @"Color";
    self.labelRed.text = @"RED";
    self.labelGreen.text = @"GREEN";
    self.labelBlue.text = @"BLUE";
    
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
}

- (void)pressButton {
    if (([self.textFieldRed.text isEqualToString:@""] || [self.textFieldGreen.text isEqualToString:@""] || [self.textFieldBlue.text isEqualToString:@""]) || ([self.textFieldRed.text integerValue] < 0 || [self.textFieldRed.text integerValue] > 255) || ([self.textFieldGreen.text integerValue] < 0 || [self.textFieldGreen.text integerValue] > 255) || ([self.textFieldBlue.text integerValue] < 0 || [self.textFieldBlue.text integerValue] > 255) || [self stringIsNumeric:self.textFieldRed.text] == false || [self stringIsNumeric:self.textFieldGreen.text] == false || [self stringIsNumeric:self.textFieldBlue.text] == false) {
        
        
        
        self.labelResultColor.text = @"Error";
    } else {
        UIColor *color = [UIColor colorWithRed:[self.textFieldRed.text doubleValue]/255
                                         green:[self.textFieldGreen.text doubleValue]/255
                                         blue: [self.textFieldBlue.text doubleValue]/255
                                         alpha:1.0];
        self.viewResultColor.backgroundColor = color;
        self.labelResultColor.text = [self hexStringFromColor:color];
        
    }
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
    
}

- (void)handleOpenField:(UITextField *)field {
    self.labelResultColor.text = @"Color";
}


- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"0x%02X%02X%02X",
            (int)(r * 255),
            (int)(g * 255),
            (int)(b * 255)];
}

-(BOOL) stringIsNumeric:(NSString *) str {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:str];
    [formatter release];
    return !!number;
}


- (void)subscribeAccessibilityIdentifier {
    
    self.view.accessibilityIdentifier = @"mainView";
    
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

@end
