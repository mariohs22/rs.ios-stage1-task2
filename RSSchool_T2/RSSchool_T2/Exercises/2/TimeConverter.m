#import "TimeConverter.h"

@implementation TimeConverter
// Complete the following function
- (NSString*)convertFromHours:(NSString*)hours minutes:(NSString*)minutes {
    if (!hours || !minutes) return @"";
    NSDictionary *words = @{@"0":@"midnight", @"1":@"one", @"2":@"two", @"3":@"three", @"4":@"four", @"5":@"five", @"6":@"six", @"7":@"seven", @"8":@"eight", @"9":@"nine", @"10":@"ten", @"11":@"eleven", @"12":@"twelve", @"13":@"thirteen", @"14":@"fourteen", @"15":@"fifteen", @"16":@"sixteen", @"17":@"seventeen", @"18":@"eighteen", @"19":@"nineteen", @"20":@"twenty", @"21":@"twenty one", @"22":@"twenty two", @"23":@"twenty three", @"24":@"twenty four", @"25":@"twenty five", @"26":@"twenty six", @"27":@"twenty seven", @"28":@"twenty eight", @"29":@"twenty nine"};
    
    NSInteger hrs = [hours integerValue];
    NSString *hrs_str = [NSString stringWithFormat:@"%ld", hrs];
    NSInteger min = [minutes integerValue];
    NSString *min_str = [NSString stringWithFormat:@"%ld", min];

    if (hrs >= 0 && hrs <= 23) {
        if (hrs == 0 && min == 0) {
            return @"midnight";
        } else if (min == 0) {
            return [NSString stringWithFormat:@"%@ o' clock", [words valueForKeyPath:hrs_str]];
        } else if (min == 1) {
            return [NSString stringWithFormat:@"one minute past %@", [words valueForKeyPath:hrs_str]];
        } else if (min == 15) {
            return [NSString stringWithFormat:@"quarter past %@", [words valueForKeyPath:hrs_str]];
        } else if (min == 30) {
            return [NSString stringWithFormat:@"half past %@", [words valueForKeyPath:hrs_str]];
        } else if (min >= 2 && min <= 29) {
            return [NSString stringWithFormat:@"%@ minutes past %@", [words valueForKeyPath:min_str], [words valueForKeyPath:hrs_str]];
        } else if (min > 30 && min <= 59) {
            hrs++;
            if (hrs == 24) hrs = 0;
            hrs_str = [NSString stringWithFormat:@"%ld", hrs];
            if (min == 45) {
                return [NSString stringWithFormat:@"quarter to %@", [words valueForKeyPath:hrs_str]];
            } else {
                min = 60-min;
                min_str = [NSString stringWithFormat:@"%ld", min];
                if (min == 1) {
                    return [NSString stringWithFormat:@"one minute to %@", [words valueForKeyPath:hrs_str]];
                } else {
                    return [NSString stringWithFormat:@"%@ minutes to %@", [words valueForKeyPath:min_str], [words valueForKeyPath:hrs_str]];
                }
            }
        }
    }
    return @"";
}
@end
