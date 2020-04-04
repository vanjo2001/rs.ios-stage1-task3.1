#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    
    if ([numbers isEqualToArray:@[]]) {
        return nil;
    }
    
    NSInteger accum = 0;
    NSMutableString *result = [[NSMutableString alloc] init];
    char *symb = "";
    NSInteger count = numbers.count;
    count--;
    
    for (NSNumber *one in numbers) {
        
        NSInteger value = labs([one integerValue]);
        
        if (accum > 0 && accum < numbers.count) {
            symb = [one integerValue] > 0 ? "+" : "-";
        }
        
        if ([one integerValue] == 0) {
            count--;
            continue;
        }
        
        if (count > 1) {
            [result appendFormat:@"%s %lix^%li ", symb, (long)value, (long)count];
        } else if (count == 1) {
            if (labs([one integerValue]) == 1) {
                [result appendFormat:@"%s x ", symb];
            } else {
                [result appendFormat:@"%s %ldx ", symb, (long)value];
            }
        } else {
            [result appendFormat:@"%s %ld ", symb, (long)value];
        }
        symb = "";
        count--;
        accum++;
    }
    
    [result deleteCharactersInRange:NSMakeRange(result.length-1, 1)];
    [result deleteCharactersInRange:NSMakeRange(0, 1)];
    
    return result;
}

@end
