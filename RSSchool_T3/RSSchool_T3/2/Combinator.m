#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    NSInteger res = [[array firstObject] integerValue];
    NSInteger bound = [[array objectAtIndex:1] integerValue];
    
    for (long i = 0; i < bound; i++) {
        if (binomialCoeff(bound, i) == res)
            return [NSNumber numberWithInteger:i];
    }
    
    return nil;
}

int binomialCoeff(long n, long k) {
    if (k == 0 || k == n)
        return 1;
    return binomialCoeff(n - 1, k - 1) + binomialCoeff(n - 1, k);
}

@end
