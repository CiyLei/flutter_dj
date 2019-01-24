import 'package:flutter/material.dart';
import 'view_animation.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails(
      {this.newsTimeTag,
      this.newsPersonTag,
      this.newsImage,
      this.newsTitle,
      this.newsContent});

  final String newsTimeTag;
  final String newsPersonTag;
  final String newsImage;
  final String newsTitle;
  final String newsContent;

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("企业发文"),
      ),
      body: SingleChildScrollView(
        child: _buildContent(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pop();
      }),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: AnimatedOpacityTranslation(
              duration: const Duration(milliseconds: 300),
              widget: DefaultTextStyle(
                child: Text("标题"),
                style: TextStyle(
                    fontSize: 36, color: Colors.black),
              ),
              type: 1,
            ),
          ),
          Row(
            children: <Widget>[
              Hero(
                tag: widget.newsTimeTag,
                child: DefaultTextStyle(
                  child: Text("2018年12月24日 14:54:59 "),
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Hero(
                  tag: widget.newsPersonTag,
                  child: DefaultTextStyle(
                    child: Text("东经科技  "),
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 20,
                bottom: 20),
            child: Hero(
                tag: widget.newsImage,
                child: Image.network(
                  "https://oa.djcps.com/DJOA/img0/M00/0F/50/ChpbMFxBo4WAD94WAAO-Ik3spjc951.JPG",
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Hero(
                tag: widget.newsTitle,
                child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 24, color: Colors.black),
                    child: Text(
                      "东经科技2018年12月份及年度总结表彰大会——2019不变的还是变 019不变的还是变019不变的还是变",
                    ))),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Hero(
                tag: widget.newsContent,
                child: DefaultTextStyle(
                    style: TextStyle(color: Theme.of(context).hintColor),
                    child: Text(
                      """
                  1月16日、17日晚，2018年12月份及年度总结表彰大会在丽岙分部和慈湖总部分别召开。
本次会议内容主要围绕经营总结报告、组织文化建设分析报告、表彰先进、总裁讲话四大方面进行。会议由激光主持。

       会议第一项议程，经营总结报告。

量子在慈湖总部作“总体经营总结报告”，量子围绕“主要经营数据通报、2018成绩与张力、2019年度目标宣贯与2018年张力解决、东经智能管理平台、年度话题”方面对报告进行阐述，并对12月目标挑战奖及2018年目标挑战奖达成情况进行说明。在2018成绩与张力中，量子提到主要的成绩有销售业绩翻番；在资本寒冬期完成首轮融资近6000万；拓展模式从模糊到清晰，逐步标准化。

针对2019年度目标宣贯与2018年张力解决模块中，量子表示2019年经营方针是实现又快又好的发展，打造快创新、强执行的团队文化，实现事项可视化，产品服务化，服务产品化及大幅提升人均效能。在报告的结尾，量子布置了4大年度话题的思考任务。

阿尔法在丽岙分部作“生产系统运营总结报告”。阿尔法围绕“客户投诉率、纸板准时入库率、原纸利用率（含修边）、修边率、车速、系统停机、制程损耗”等主要生产管理指标和管理体系落地情况进行了通报，总结了2018年的成绩和不足之处，汇报了接下来的行动计划。

猎鹰在丽岙分部作“供应链系统运营总结报告”。猎鹰围绕“合作伙伴开发、合作伙伴降本、区域物流”等供应链系统成果进行了通报，阐述了2018年存在的张力及相应的解决措施。报告的最后，猎鹰汇报了2019年的工作计划。

会议第二项议程，组织文化建设分析报告。

狼牙分别从“评价体系结果通报及应用、千里马机制运行通报、专项表彰、关键岗位内部推荐奖励标准及2018年组织架构图”这五方面对报告进行了阐述。在2018年度千里马机制运行中，狼牙提到了六次千里马的获得者袁凤霜战友2017年10月16日入职，2018年共获奖15次，4月、10月调级两档，2019年1月正式晋升为团长，累计获得奖励20137元，累计涨薪300%。报告的最后，狼牙公布了2019年组织架构图，并讲解了组织架构图的创新意义。

会议第三项议程，表彰先进。

慈湖总部方面：姜伊泽、黄玉艳、徐建箫、鲁恩善、张宏权、高豪伦、吕宗远、柏倩、吴小珍、张鹏、吴孙群、李兵、丁永胜、林静洁、温坚宾、房忠、周甲度、李黎明、米冬昊、林淑瑶、李后、徐涛、宁运琼、鲍冬冬、程文、丁学紧、杨慧丹、广梦秋、钟齐梅、杨时雨、闰尚伟、袁凤霜共32位战友被评为12月千里马！

研发中心鲁恩善作为千里马代表发言！

12月份加入东经大家庭的新成员风采展示！

新入职的管理人员亮相分享：总裁助理—骑士陈海晏。

高新技术企业申报工作合弄制获得12月度优秀合弄制！

钟齐梅获得12月商务拓展中心赛马机制个人勇争第一奖！

温北区域业务团队获得12月商务拓展中心赛马机制团队勇争第一奖！

市场中心完成5份全国主要工业城市的区域市场评估报告、研发中心

完成平滑升级挑战项目、研发中心完成2018年12月25日，OA SaaS功能上线，支持其他公司上线，并完成公司紧急迭代内容、商拓中心完成12月份，嘉兴市场全月接单量550万平方挑战目标！

12月度“日新日高”特别奖颁奖中袁凤霜荣获“自我挑战”专项奖、黄如翔荣获“自我挑战”专项奖！

2018年度价值观提报颁奖中：年度价值观推优上榜次数前三名依次是钟齐梅、潘克彬、李清清；年度价值观总提报次数对应核心价值观6大条的第一名分别是李中志（用户至上奖）、潘克彬（和而不同奖）、袁凤霜（商务拓展中心）、邓友朝（极致高效奖）、杜学良（简单快乐奖）、张龙（诚信尽责奖）！

2018年度张力提报颁奖中：年度张力总提报次数前3名，第1名是陈婷婷、第2名是罗华生、第3名是程梦茜、李婷！

年度优秀员工分别是袁凤霜、苏思思、鲍冬冬、郑淑君、广梦秋、闰尚伟、陈薇、章麦特、王岳城、杨慧丹！

朱晴倩、陈笑笑、潘兵丰、刘景景、江林、鲁恩善、方舒、刘莉、谢娇、陈坚盛、李黎明、张鹏、杨法晓、潘建生、苏思思、倪佳琦、佘微、林永磊、李娜、史旭良、潘克彬、章秀兴、陈婷婷、钟文凤、陈光远、叶媚媚、林静密、胡飞燕、李小红、林辉平共30位战友12月生日快乐！

丽岙分部方面：

刘运国、骆田军、杜忠杰、朱艳茹、李超众、邱泽升、潘克龙、蔡丰新、何立强、林保荣、王小明、邓友朝共12位战友被评为12月千里马！

一路好运李超众作为千里马代表发言！

12月份加入东经大家庭的新成员风采展示！

杨祺获得12月度价值观经典案例奖！

朱万田获得极致高效 “装车质量”个人专项奖！ 

陈洁获得勇争第一—— “配货质量”个人专项奖！

郑振涛获得和而不同——“出库质量”个人专项奖！ 

张龙获得和而不同——“入库质量”个人专项奖！

物流本部获得3MS系统实施“和而不同”专项奖！
仓储管理部全体成员（含非在册的装车员）完成仓储人均效能月度目标挑战奖颁奖！

获得年度优秀员工分别是李清清、邓友朝、朱元丰！

获得年度优秀团队是B班操作团队！

李家林、刘现群、陈洁、张忠华、柯昌全、李温儒、刘裕、罗余强、姜冬莲、刘安艳、易章华、胡连英、张美、汪葆莹共14位战友12月生日快乐！

会议第四项议程，老兵总结发言。

2018年东经变了什么，哪些没变，哪些是我们需要去改变的，这是今天要跟大家沟通的话题。

东经从原来一个非常传统的纸板加工企业，转型成为“包装+互联网”企业，过去一年，我们的商业模式、经营模式、业务内容都发生了改变。这些都是有意识的刻意的改变，我们为了发展被迫做出的改变。

2018年我们有些方面还没发生改变？一个是思维模式，整个公司形成合力的思维模式还没形成。还有管理模式，虽然员工的考核和管理机制发生了改变，但是管理人员的考核机制还没有跟上。同时我们的文化也没有很好的跟上，目前的企业文化与我们现在的业务、管理不是很符合。这些方面的改变是无意识的、自然而然的改变，只有这些变化深入骨髓，我们才实现了真正的改变。东经要实现愿景和目标，困难会无限的加大，我们必须要进行改变，否则，就永远不可能进步。

传统的工业企业，每个人就是一个价值传输点，互联网时代，每个人都必须是一个价值的放大点。一个传统的工业企业，它的管理是自上而下的，一个真正的互联网企业，核心就是自下而上的管理。当我们每个东经人都在思考自己的价值，实现自我驱动的时候，东经就真正成功了。
2019年是东经的决战之年，我们的思维模式、组织方式、工作方法、文化习惯都要做出改变，希望我们把这些变化变成我们骨髓里的东西，一起努力、艰苦奋斗，创造更多的价值，实现我们每个人自己的梦想。提前给大家拜个早年，祝各位战友和家人新年快乐，阖家幸福！
            """,
                    ))),
          )
        ],
      ),
    );
  }
}
