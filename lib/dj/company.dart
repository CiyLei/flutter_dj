import 'package:flutter/material.dart';
import 'view_animation.dart';
import 'item_scaling.dart';
import 'news_details.dart';
import 'fade_page_route.dart';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bulidContent();
  }

  Widget _bulidContent() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return AnimatedOpacityTranslation(
          widget: _buildListItem(context, index),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return _buildListViewSeparated(10);
      },
      itemCount: 30,
    );
  }

  Widget _buildListViewSeparated(double height) {
    return Container(
      height: height,
      color: Theme.of(context).dividerColor,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            FadeTransitionPageRoute(
                widget: NewsDetails(
              newsTimeTag: "NewsTime$index",
              newsPersonTag: "NewsPerson$index",
              newsImage: "NewsImage$index",
              newsTitle: "NewsTitle$index",
              newsContent: "NewsContent$index",
            )));
      },
      child: AnimationItemScale(
        widget: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        "https://oa.djcps.com/DJOA/img0/M00/0B/F1/ChpbMFuSdnuARv-0AAFaIpiVax8632.jpg"),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: "NewsPerson$index",
                        child: DefaultTextStyle(
                            style: TextStyle(color: Colors.black),
                            child: Text(
                              "东经科技",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Hero(
                        tag: "NewsTime$index",
                        child: DefaultTextStyle(
                          child: Text("2018年12月24日 14:54:59"),
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).hintColor,
                )
              ],
            ),
            Hero(
              tag: "NewsImage$index",
              child: Image.network(
                "https://oa.djcps.com/DJOA/img0/M00/0F/50/ChpbMFxBo4WAD94WAAO-Ik3spjc951.JPG",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Hero(
                  tag: "NewsTitle$index",
                  child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black),
                      child: Text(
                        "东经科技2018年12月份及年度总结表彰大会——2019不变的还是变 019不变的还是变019不变的还是变",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10),
              child: Hero(
                  tag: "NewsContent$index",
                  child: DefaultTextStyle(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      child: Text(
                        """
                1月16日、17日晚，2018年12月份及年度总结表彰大会在丽岙分部和慈湖总部分别召开。
本次会议内容主要围绕经营总结报告、组织文化建设分析报告、表彰先进、总裁讲话四大方面进行。会议由激光主持。

       会议第一项议程，经营总结报告。
            """
                            .trim(),
                        maxLines: 2,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
