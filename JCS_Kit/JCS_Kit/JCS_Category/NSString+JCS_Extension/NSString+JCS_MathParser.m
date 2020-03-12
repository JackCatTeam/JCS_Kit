//
//  NSString+JCS_MathParser.m
//  JCS_Create
//
//  Created by 永平 on 2020/2/26.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "NSString+JCS_MathParser.h"

/**<
 1.过滤空格
 2.判断字符串是否有多余字符(除数字,小数点,括号,+,-,*,/)
 3.运算顺序：先乘除，再加减，有括号先算括号里面的。
    “5+2*3*1”的具体步骤是：
    先算优先级高的2*3=6
    用6替换掉2*3,
    得到 "5+6*1"
    再检测是否还有高优先级的*,有则
    6*1=6,用"6"替换掉"6*1"
    得到"5+6"
    接着没有高优先级的运算符字符了，可以算低优先级字符
    接着得到用"11"替换"5+6"。
 */

@implementation NSString (JCS_MathParser)

/// 计算数学表达式
+ (NSString *)jcs_caculate:(NSString *)formulaString {
    NSString *outString = @"0";
    
    //去空格
    formulaString = [formulaString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (formulaString.length == 0) {
        return outString;
    }
    
    //判断是否合法
    if (![self jcs_validate_string:formulaString]) {
        return outString;
    }
    
    //开始计算
    return [self jcs_start_caculate:formulaString];
}
- (NSString *)jcs_caculate {
    return [[self class] jcs_caculate:self];
}

+ (NSString *)jcs_start_caculate:(NSString *)formulaString{
    //从右往左搜索
    //第一个左括号
    NSRange leftRange = [formulaString rangeOfString:@"(" options:NSBackwardsSearch];
    //没有括号，进行四则运算
    if (leftRange.length == 0) {
        return [self jcs_four_arithmetic_operation:formulaString];
    }
    
    //再找右括号
    NSString *rightFormulaString = [formulaString substringFromIndex:leftRange.location];
    NSRange rightRange = [rightFormulaString rangeOfString:@")"];
    
    //左 中 右 三部分
    NSString *leftPart   = [formulaString substringToIndex:leftRange.location];
    NSString *middlePart = [rightFormulaString substringWithRange:NSMakeRange(1, rightRange.location-1)];
    NSString *rightPart  = [rightFormulaString substringFromIndex:rightRange.location+1];
    
    //简化的公式
    middlePart = [self jcs_four_arithmetic_operation:middlePart];
    NSString *xFormulaString = [NSString stringWithFormat:@"%@%@%@",leftPart,middlePart,rightPart];
    return [self jcs_start_caculate:xFormulaString];
}

+(NSString *)jcs_four_arithmetic_operation:(NSString *)formulaString{
    NSRange mulSymbol = [formulaString rangeOfString:@"*"];
    NSRange divSymbol = [formulaString rangeOfString:@"/"];
    
    //只有 + -
    if (mulSymbol.length == 0 && divSymbol.length == 0) {
        return [self jcs_add_and_div_operation:formulaString];
    }
    
    //有 * /
    NSRange xrange;
    if (mulSymbol.length > 0 && divSymbol.length > 0) {
        xrange = mulSymbol.location < divSymbol.location ? mulSymbol : divSymbol;
    }else if (mulSymbol.length > 0){
        xrange = mulSymbol;
    }else{
        xrange = divSymbol;
    }
    
    NSString *xsymbol = [formulaString substringWithRange:xrange];
    
    //左边
    NSString *leftPart = [formulaString substringToIndex:xrange.location];
    
    //右边
    NSString *rightPart = [formulaString substringFromIndex:xrange.location+1];
    
    NSString *leftNumber  = [self jcs_last_number_in_string:leftPart];
    NSString *rightNumber = [self jcs_first_number_in_string:rightPart];
    
    leftPart = [leftPart substringToIndex:leftPart.length - leftNumber.length];
    rightPart = [rightPart substringFromIndex:rightNumber.length];
    
    NSString *middlePart = @"0";
    if ([xsymbol isEqualToString:@"*"]) {
        middlePart = [self jcs_mul:leftNumber and:rightNumber];
    }else{
        middlePart = [self jcs_div:leftNumber and:rightNumber];
    }
    
    NSString *xFormulaString = [NSString stringWithFormat:@"%@%@%@",leftPart,middlePart,rightPart];
    return [self jcs_four_arithmetic_operation:xFormulaString];
}

+ (NSString *)jcs_last_number_in_string:(NSString *)string{
    NSUInteger start = 0;
    for (NSInteger i = string.length - 1; i >= 0; --i) {
        char c = [string characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            start = i + 1;
            break;
        }
    }
    return [string substringFromIndex:start];
}

+ (NSString *)jcs_first_number_in_string:(NSString *)string{
    NSUInteger end = string.length;
    NSInteger i = 0;
    if ([string hasPrefix:@"-"]) {//有可能是负数
        i = 1;
    }
    for (; i < string.length; ++i) {
        char c = [string characterAtIndex:i];
        if ((c < '0' || c > '9') && c != '.') {
            end = i;
            break;
        }
    }
    return [string substringToIndex:end];
}

+ (NSString *)jcs_add_and_div_operation:(NSString *)fromulaString{
    NSString *outResult = @"0";
    NSUInteger start = 0;
    char operationSymbol = '+';
    NSUInteger i = 0;

     // ++ -- +- -+
    fromulaString = [fromulaString stringByReplacingOccurrencesOfString:@"++" withString:@"+"];
    fromulaString = [fromulaString stringByReplacingOccurrencesOfString:@"--" withString:@"+"];
    fromulaString = [fromulaString stringByReplacingOccurrencesOfString:@"+-" withString:@"-"];
    fromulaString = [fromulaString stringByReplacingOccurrencesOfString:@"-+" withString:@"-"];
 
    char pre_c = [fromulaString characterAtIndex:0];;
    for (; i < fromulaString.length; ++i) {
        char c = [fromulaString characterAtIndex:i];
        if (c == '+' || c == '-') {
            NSString *number = [fromulaString substringWithRange:NSMakeRange(start, i - start)];
            if (operationSymbol == '+') {
                outResult = [self jcs_add:outResult and:number];
            }else{
                outResult = [self jcs_sub:outResult and:number];
            }
            start = i + 1;
            operationSymbol = c;
        }
        
        //上一个字符
        pre_c = c;
    }
    
    //最后一个数
    if (start < fromulaString.length) {
        NSString *number = [fromulaString substringFromIndex:start];
        if (operationSymbol == '+') {
            outResult = [self jcs_add:outResult and:number];
        }else{
            outResult = [self jcs_sub:outResult and:number];
        }
    }
    
    return outResult;
}

+ (NSString *)jcs_add:(NSString *)num1 and:(NSString *)num2{
    return [NSString stringWithFormat:@"%.6f",[num1 floatValue] + [num2 floatValue]];
}

+ (NSString *)jcs_sub:(NSString *)num1 and:(NSString *)num2{
    return [NSString stringWithFormat:@"%.6f",[num1 floatValue] - [num2 floatValue]];
}

+ (NSString *)jcs_mul:(NSString *)num1 and:(NSString *)num2{
    return [NSString stringWithFormat:@"%.6f",[num1 floatValue] * [num2 floatValue]];
}

+ (NSString *)jcs_div:(NSString *)num1 and:(NSString *)num2{
    return [NSString stringWithFormat:@"%.6f",[num1 floatValue] / [num2 floatValue]];
}

+ (BOOL)jcs_validate_string:(NSString *)formula{
    BOOL flag = YES;
    for (NSUInteger i = 0; i < formula.length; ++i) {
        char c = [formula characterAtIndex:i];
        if (c != '(' &&
            c != ')' &&
            c != '*' &&
            c != '+' &&
            c != '-' &&
            c != '.' &&
            c != '/' &&
            c != '0' &&
            c != '1' &&
            c != '2' &&
            c != '3' &&
            c != '4' &&
            c != '5' &&
            c != '6' &&
            c != '7' &&
            c != '8' &&
            c != '9' ) {
            flag = NO;
        }
    }
    return flag;
}

@end
