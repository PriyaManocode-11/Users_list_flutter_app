import 'package:flutter/material.dart';
import 'package:users_list/constants/colors.dart';
import 'package:users_list/constants/strings.dart';
import 'package:users_list/model/user_model/item_model.dart';

class BottomPaginationWidget extends StatelessWidget{
  final List<Item> footerArr;
  final Function(Item item) stepperIndexClick;
  const BottomPaginationWidget(this.footerArr, {super.key, required this.stepperIndexClick});
  @override
  Widget build(BuildContext context) {
    bool isDisableAtEnd = footerArr.indexWhere((element) => element.isClicked) == footerArr.length-1;
    bool isDisableAtBeginning = footerArr.indexWhere((element) => element.isClicked) == 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(splashRadius:18,onPressed: isDisableAtBeginning? null : () {
          stepperIndexClick.call(Item(id: -1, name: Strings.left));
        }, icon:  Icon(Icons.chevron_left, size: 25, color:isDisableAtBeginning? Colors.grey : ColorCode.kPurple,)),
        SizedBox(
            height: 50,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: footerArr.length,
              itemBuilder: ((BuildContext context, int index) {
                index = index;
                int selectedIndex = footerArr.indexWhere((element) => element.isClicked);
                return footerArr[index].isClicked || index == 0 || index == footerArr.length-1 || index == (selectedIndex+1) || index == (selectedIndex-1)
                    ? Container(
                  margin: EdgeInsets.only(left: (index != 0 ? 5 : 0)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (){
                      selectedIndex == index ? null : stepperIndexClick.call(Item(id: index, name: ''));
                    },
                    child: Container (
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: ColorCode.kPurple),
                        shape: BoxShape.circle,
                        color: footerArr[index].isClicked ? ColorCode.kPurple : Colors.transparent,
                      ),
                      child:Text(footerArr[index].name, style: TextStyle(color:  footerArr[index].isClicked ? Colors.white : ColorCode.kPurple, fontSize:  12,fontWeight:  FontWeight.w600),),
                    ),
                  ),
                )
                    : index == (selectedIndex+2) || index == (selectedIndex+3) || index == (selectedIndex+4) || index == (selectedIndex-2) || index == (selectedIndex-3) || index == (selectedIndex-4)
                    ? Container (width: 10, height: 10, alignment: Alignment.center,
                  child: const Text('.', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),),
                ) : Container();
              }),
            )),
        IconButton(splashRadius:18,onPressed:isDisableAtEnd ? null : (){
          stepperIndexClick.call(Item(id: 1, name: Strings.right));
        }, icon:  Icon(Icons.chevron_right, size: 25, color:isDisableAtEnd ? Colors.grey : ColorCode.kPurple,)),
      ],
    );
  }
}
