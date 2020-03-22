#import "AbbreviationMaker.h"

@implementation AbbreviationMaker
- (NSString *) abbreviationFromA:(NSString *)a toB:(NSString *)b {
    if (([a length] == 0) || ([b length]==0) || !a || !b) return @"NO";
    NSString *modifiedA = [[[a uppercaseString] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:b] invertedSet]] componentsJoinedByString:@""];
    return [modifiedA isEqualToString:b]? @"YES" : @"NO";
}
@end
