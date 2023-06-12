# 1.Preface前言
This a page for the Course Design Project of OOPJava
# 2.Git地址
<https://github.com/Godtokoo666/projectx>
由于本项目是使用Maven构建和管理的，所以Git中并不提供jar包，因此您看不到属于jar包的lib文件夹。但除jdk11所提供的所有jar包外，所需的所有文件都可以借由Maven的配置文件pom.xml看到，包括但不限于MySQL Connector/J、JavaServer Pages(TM) API
# 3.项目概览
### 整体介绍
本着面向对象程序设计“高内聚，低耦合”的思想，本项目借鉴了MVC模式中的内容，即三个基本部分：**模型（Model）**、**视图（View）**和**控制器（Controller）**。在MVC中，存在三层架构，即**表示层（USL，User Show Layer）**、**业务逻辑层（BLL，Business Logic Layer）**、**数据访问层（DAL，Data Access Layer）**。
### 结构解释
在IntelliJ IDEA中，截得的项目源代码结构图如下
![图1-项目源代码结构图](/image/2023-6-13/1.png)

如您所见，src文件夹中存在着Bean、Dao、Servlet三个包以及一个webapp文件夹，其中Bean包内的类作为实体类将各种数据进行封装，以便使数据在三层架构间进行流通。
![图2-三层架构图](/image/2023-6-13/2.png)

webapp中的内容作为表示层部分，用于处理用户请求。在本项目中，webapp主要处理注册登录、单词测试数据的表单提交、个人数据的查询以及管理员页面的全局数据查询和单词的添加操作。Servlet包中的类作为业务逻辑层，承上启下，通过HttpServlet接受request，并通过具体代码与Dao包中的内容进行交互或通过session把请求直接实现。Dao包中的类作为数据访问层，由于该层直接通过JDBC与数据库交互，因此也起着最底层的数据访问作用。
对于数据的储存，本项目使用MySQL数据库，其表结构如下：
![图3-MySQL表结构](/image/2023-6-13/3.png)

其中，出于轻量化的目的，本项目user表同时存储用户名和明文密码以及单词测试产生的数据。但我们并不建议您这么错，更为安全的做法是将password转码加密或者使用其他方式储存。word表存储单词的英文和中文属性。此外，为了拓展功能，后续可添加词性或其他属性对单词进行分类。test表用于存储测试数据，但在此项目的第一版中，我们并未投入使用，后续将考虑进行延申。
# 4.功能实现
### 登录与注册
#### 前端页面：
演示图：
![图4-登录界面](/image/2023-6-13/4.png)	

![图5-注册界面](/image/2023-6-13/5.png)

#### 具体实现：
1.对于登录操作，在前端jsp页面中，我们使用表单form将username以及password提交到Servlet，Servlet
### 单词测试
### 数据查询
# 5.扩展功能
# 6.场景化应用
# 7.demo 
-- 由于服务器资源昂贵，本demo仅提供至2024年4月
-- 请移步<https://x.demo.funfs.com/>
# 8.敬请期待（to do list）
1.App Version
……
