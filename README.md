# 多机构资料入库的延迟约束与隔离提交

各记录目录保存独立的合成业务资料。SQL 文件仅包含原始关系表与已有行。manifest.json 记录库角色、表、行数及运行参数。timeline.json 记录后续客户端行为、来源提交或故障，用 pos 表示可比较的到达次序。同一 pos 按数组顺序。提交位置由相应记录的业务字段指定。

## 接入协议

各组业务写以 batch、group、submission 识别，主库的 proof_id 由签发机构分配，标签相同不等价。交换记录 rows 中的 action 为 apply、replace 或 withdraw，可同时提供课程 course、证明 proof 和核验明细 check。proof 的区间左闭右开，replace 需要引用原版本且不可在同机构、同证明身份上保留交叠的有效显示区间。check 引用明确的 proof 及 course，二者必须属于核验行认可机构。requires 可引用同批证明组，若已提交证明明确写为 live 引用。
live_proofs 与 live_checks 是接收前已正式落库的事实。新 revision 使用新的版本编号。提交回执可以给到组，为接口避免重复记账用 submission 唯一识别具体内容。supplies 中获授权的联合组共享临时代号，不自动允许把另一个机构的证明搬到当前机构。

## 本地资料

使用 Python 3.11.2 和内置 SQLite 3.40.1。以下命令从记录创建关系库，目标文件需要尚不存在。各角色可以作为独立 SQLite 文件读取。

~~~sh
python3 seed_db.py fixtures/reference-cycle-with-live-withdrawal main-local.db --role main
~~~

使用 Python 的 sqlite3 打开新文件即可访问原始表。用 python3 -m unittest -v 核对资料可装载、表与原始记录一致、SQLite 可同时打开读写连接。后续事件保存在各自的原始记录中。
