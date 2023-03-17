# vue

## vue指令

1. v-text:   显示文本
2. v-html:   显示富文本
3. v-if:    if判断语句
4. v-else-id: else-if语句
5. v-else:   else语句
6. v-show:   控制元素的显示和隐藏
7. v-on:    简写@用来给元素添加事件
8. v-bind:   用来绑定元素的属性Attr
9. v-model:  双向绑定
10. v-for:   遍历元素
11. v-once:   性能优化只渲染一次
12. v-memo:   性能优化会有缓存
    * 组件和元素都可以使用，主要可以缓存
    * 类型：any[]
    * 如果数组中的每个值都与最后一次的渲染相同，那么更新将会被跳过。