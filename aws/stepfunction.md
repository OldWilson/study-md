### 参考</br>
AWS Step Functions文档参考：https://docs.aws.amazon.com/zh_cn/step-functions/latest/dg/welcome.html</br>
Step Function API:https://docs.aws.amazon.com/zh_cn/step-functions/latest/apireference/Welcome.html</br>

### 状态机结构</br>
> Comment(可选): 状态机描述</br>
> StartAt(必需): 字符串，必须与某个状态对象的名称完全匹配（区分大小写）</br>
> TimeoutSeconds(可选): 状态机运行的最大秒数</br>
> Version(可选): 版本</br>
> States(必需): 对象，状态集合</br>

### 状态</br>
> Type(必需):状态类型</br>
> Next:当前状态完成时将运行的下一个状态的名称</br>
> End:设置为true时，指定此状态作为终端（结束执行）。</br>
> Comment(可选):描述</br>
> InputPath(可选):用于选择要传递到状态任务进行处理的状态输入的一部分。</br>
> OutputPath(可选):用于选择要传递到状态输出的状态输入的一部分</br>

#### Pass状态</br>
Pass状态仅将其输入传递到输出，不执行任何工作。</br>
> Result(可选):按照ResultPath字段的说明进行筛选。</br>
> ResultPath(可选):按照OutputPath字段的说明进行筛选。</br>

#### Task任务</br>
Task状态代表状态机执行的一个工作单元</br>
> Resource(必需):资源名称(ARN)</br>
> ResultPath(可选):指定(输入中)用于放置Resource中所指定任务的执行结果的位置。</br>
> Retry(可选):一个称为重试器的对象的数组。</br>
> Catch(可选):一个成为捕获器的对象的数组。</br>
> TimeoutSeconds(可选):任务运行时间。超过将执行失败，返回States.Timeout错误名称。默认99999999。</br>
> HeartbeatSeconds(可选):任务检测信号之间的时间。</br>

#### Choice</br>
Choice状态向状态机添加分支逻辑。Choice状态不支持End字段。</br>
> Choice(必需):确定状态机接下来转换为什么状态。</br>
> Default(可选):在Choices中没有进行任何转换时，要转换为的状态的名称。</br>

选项规则: </br>
> And</br>
> BooleanEquals</br>
> Not</br>
> NumericEquals</br>
> NumericGreaterThan</br>
> NumericGreaterThanEquals</br>
> NumericLessThan</br>
> NumericLessThanEquals</br>
> Or</br>
> StringEquals等</br>
> TimestampEquals等</br>

#### Wait</br>
Wait状态使状态机延迟指定的时间，然后再继续。</br>
> Seconds:启动Next字段中指定状态之前等待的时间，以秒为单位。</br>
> Timestamp:一个绝对时间，等到该时间后再启动Next字段中指定的状态。(2016-08-18T17:33:00Z)</br>
> SecondsPath:启动在Next字段中指定的状态所等待的时间，以秒为单位。</br>
> TimestampPath:绝对时间，等到该时间后再启动在Next字段中指定的状态。</br>

#### Succeed</br>
* Succeed状态可成功停止执行。不执行任何操作，只是停止执行。</br>
```JSON
"SuccessState": {
  "Type": "Succeed"
}
```

#### Fail</br>
Fail状态将停止状态机的执行并将其标记为出现故障。</br>
仅允许使用以下字段:
> Type</br>
> Comment</br>
> Cause(可选):提供可用于操作或诊断用途的自定义故障字符串。</br>
> Error(可选):提供可用于错误处理(Retry/Catch)、操作或诊断用途的错误名称。</br>

#### Parallel</br>
> Parallel状态可用于在状态机中创建并行执行分支。</br>
> Branches(必需):对象数组，指定要并行执行的状态机。</br>
> ResultPath(可选)</br>
> Retry</br>
> Catch</br>

#### 输入与输出处理</br>
**InputPath:**</br>
> 选择状态输入的一部分。如果省略则会获取$值，表示整个输入。如果设置null，则会丢弃输入入(不发送到状态的任务)，并且任务会接收表示空对象的JSON文本{}。</br>

**ResultPath:**</br>
> 如果某个状态不执行任务，则将该状态的输入不经过修改作为输出直接发送。</br>
> ResultPath获取状态任务的执行结果，并将其放在输入中。</br>
> 如果ResultPath匹配状态输入中的某个项，则状态任务的执行结果仅覆盖该输入项。修改后的整个输入可作为状态的输出。</br>
> 如果ResultPath未与状态输入中的项匹配，将在输入中添加执行结果。扩展后的输入成为状态输出。</br>
> 如果ResultPath设置未默认值$，则匹配整个输入。状态执行结果会完全覆盖输入，而输入变为可传递状态。</br>
> 如果ResultPath为null，则将丢弃状态执行结果，而输入保持不变。</br>

**OutputPath:**</br>
> 如果OutputPath与状态输入中的项匹配，则只选择该输入项作为状态的输出。</br>
> 如果OutputPath未与状态输入中的项匹配，则将出现路径无效的异常。</br>
> 如果outputPath设为默认值$，则将完全匹配整个输入。</br>
> 如果OutputPath为null，则将表示空对象的JSON文本{}发送到下一个状态。</br>

#### 错误</br>
**错误表示形式:**</br>
> States.ALL:匹配任何错误名称的通配符</br>
> States.Timeout:Task状态要么运行时间长度超过"TimeoutSeconds"值，要么在超过"HeartbeatSeconds"值的时间内未发送检测信号。</br>
> States.TaskFailed:执行期间失败的Task状态。</br>
> States.Permissions:Task状态由于没有足够的权限执行指定代码而失败。</br>

**重试Retry:**</br>
重试被视为状态转换。</br>
> ErrorEquals(必需):匹配错误名称的非空字符串数组。</br>
> IntervalSeconds(可选):整数，第一次重试之前等待的秒数(默认值为1)。</br>
> MaxAttempts(可选):正整数，表示重试的最大次数(默认值为3)。超过指定次数，停止重试并恢复正常错误处理。设为0时，错误永远不应重试。</br>
> BackoffRate(可选):每次重试时间间隔增长的倍数(默认值为2.0)。</br>

**回退Catch:**</br>
> ErrorEquals(必需):与错误名称匹配的非空字符串数组。</br>
> Next(必需):字符串，必须与状态机的状态名称之一完全匹配。</br>
> ResultPath(可选):确定将什么内容作为输入发送到next字段所指定的状态。</br>
