#import "FibonacciResolver.h"

@implementation FibonacciResolver

- (NSArray*)productFibonacciSequenceFor:(NSNumber*)number {
    NSMutableArray *fibSeries = [NSMutableArray new];
    [fibSeries addObject:[NSNumber numberWithInt:0]];
    long long total = 0;
    long long prev = 1;
    for (long long x=1; x<[number longLongValue]; x++){
        total = total + prev;
        prev = total - prev;
        [fibSeries addObject:[NSNumber numberWithLongLong:total]];
        if (total*prev >= [number longLongValue]) break;
    }
    bool flag = (total*prev == [number longLongValue]);
    return @[[NSNumber numberWithLongLong:prev], [NSNumber numberWithLongLong:total], [NSNumber numberWithBool:flag]];
}
@end
