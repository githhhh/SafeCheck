## SafeCheck

OC 数组、字典 语法糖初始化、存、取值 的校验,避免release 模式下的crash

## 使用

推荐使用语法糖初始化、存、取值  。
 
在Rlease模式下不会崩溃,其它模式会正常报出错误

*注意* NSMutableArray+SafeCheck 使用了MRC ，确保添加了-fno-objc-arc 标识
