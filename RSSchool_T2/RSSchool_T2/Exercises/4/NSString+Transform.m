#import "NSString+Transform.h"

@implementation NSString (Transform)

-(NSString*)transform {
    if (!self) return @"";
    NSString *modifiedString = [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:0 error:&error];
    modifiedString = [regex stringByReplacingMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length]) withTemplate:@" "];
    if ([modifiedString length] == 0) return @"";
    NSMutableString *newString = [modifiedString mutableCopy];

    NSString *replacements = @"";
    NSRegularExpression *matches;
    if ([modifiedString isPangram:modifiedString]) {
        replacements = @"aeiouy";
        matches = [NSRegularExpression regularExpressionWithPattern:@"[AEIOUY]" options:0 error:&error];
    } else {
        replacements = @"bcdfghjklmnpqrstvwxz";
        matches = [NSRegularExpression regularExpressionWithPattern:@"[BCDFGHJKLMNPQRSTVWXZ]" options:0 error:&error];
    }
    [newString enumerateSubstringsInRange:NSMakeRange(0, [newString length])
                                  options:NSStringEnumerationByComposedCharacterSequences
                               usingBlock:
        ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            if ([replacements containsString:substring]) {
                [newString replaceCharactersInRange:substringRange withString: [substring uppercaseString]];
            }
        }
    ];
    NSArray *arr = [newString componentsSeparatedByString:@" "];
    NSMutableArray *result = [NSMutableArray array];
    unsigned long cnt;
    for (int i=0; i<[arr count]; i++){
        cnt = [matches numberOfMatchesInString:arr[i] options:0 range:NSMakeRange(0, [arr[i] length])];
        [result insertObject:[NSString stringWithFormat:@"%lu%@", cnt, arr[i]] atIndex:i];
    }
    NSArray *final = [result sortedArrayUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
        unsigned long a_cnt = [matches numberOfMatchesInString:a options:0 range:NSMakeRange(0, [a length])];
        unsigned long b_cnt = [matches numberOfMatchesInString:b options:0 range:NSMakeRange(0, [b length])];
        if (a_cnt > b_cnt) {
            return NSOrderedDescending;
        } else if (a_cnt < b_cnt) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    return [final componentsJoinedByString:@" "];
}

-(BOOL)isPangram:(NSString *)str {
    NSArray *alphabet = [@"a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p.q.r.s.t.u.v.w.x.y.z" componentsSeparatedByString:@"."];
    str = [str lowercaseString];
    for (NSString *letter in alphabet) {
        if (![str containsString:letter]) {
            return NO;
        }
    }
    return YES;
}

@end
