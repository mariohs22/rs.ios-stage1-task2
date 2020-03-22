#import "Blocks.h"

@interface Blocks()
@property (nonatomic, copy) NSArray *arr;
@end

@implementation Blocks

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.blockA = ^(NSArray *array) {
            self.arr = array;
        };
        self.blockB = ^(Class class) {
            NSMutableArray *arr2 = [self.arr mutableCopy];
            [arr2 removeObjectIdenticalTo:[NSNull null]];
            [arr2 filterUsingPredicate:[NSPredicate predicateWithFormat: @"self isKindOfClass: %@", class]];
            if (class == [NSString class]) {
                self.blockC([arr2 componentsJoinedByString:@""]);
            } else if (class == [NSNumber class]) {
                self.blockC([arr2 valueForKeyPath:@"@sum.self"]);
            } else if (class == [NSDate class]) {
                NSDate *neededDate = [arr2 firstObject];
                for (NSDate *curDate in arr2) {
                    neededDate = [curDate laterDate:neededDate];
                }
                NSDateFormatter *format = [NSDateFormatter new];
                [format setDateFormat:@"dd.MM.yyyy"];
                self.blockC([format stringFromDate:neededDate]);
            }
        };
    }
    return self;
}

@end
