import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'export_config.dart';

/// Header Search Widget
class HeaderSearch extends StatefulWidget {
  final Function(String query) onSearch;
  final Function onCancelSearch;
  final Function onAddData;
  final Function onResetFilter;
  final Function(
          DateTime dateFrom, DateTime dateTo, String filterBy, String statusBy)
      onSubmitFilter;
  final bool showAddButton;

  const HeaderSearch({
    Key key,
    this.onSearch,
    this.onAddData,
    this.onSubmitFilter,
    this.onResetFilter,
    this.showAddButton = true,
    this.onCancelSearch,
  }) : super(key: key);
  @override
  _HeaderSearchState createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen(context),
      padding: EdgeInsets.symmetric(vertical: normal, horizontal: normal),
      decoration: BoxDecoration(
        color: whiteNeutral,
        boxShadow: [
          BoxShadow(color: darkColor, blurRadius: normal),
        ],
      ),
      child: isSearch
          ? CustomTextField(
              hint: "Search....",
              prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    widget.onCancelSearch();
                    setState(() => isSearch = !isSearch);
                  }),
              onChanged: (val) {
                widget.onSearch(val);
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: widget.showAddButton,
                  child: Flexible(
                    child: Container(
                      width: widthScreen(context),
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(small)),
                        color: primaryColor,
                        textColor: whiteNeutral,
                        onPressed: () {
                          widget.onAddData();
                        },
                        icon: Icon(Icons.add),
                        label: Text("Tambah"),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.showAddButton,
                  child: SizedBox(width: small),
                ),
                Flexible(
                  child: Container(
                    width: widthScreen(context),
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(small)),
                      color: primaryColor,
                      textColor: whiteNeutral,
                      onPressed: () {
                        filterDiloag();
                      },
                      icon: Icon(Icons.short_text),
                      label: Text("Filter"),
                    ),
                  ),
                ),
                SizedBox(width: small),
                Flexible(
                  child: Container(
                    width: widthScreen(context),
                    child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(small)),
                      color: primaryColor,
                      textColor: whiteNeutral,
                      onPressed: () {
                        setState(() => isSearch = !isSearch);
                      },
                      icon: Icon(Icons.search),
                      label: Text("Search"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  filterDiloag() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: whiteNeutral,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(medium),
            topRight: Radius.circular(medium),
          ),
        ),
        child: FilterWidget(
          onSubmit: (dateFrom, dateTo, filterBy, statusBy) async {
            widget.onSubmitFilter(dateFrom, dateTo, filterBy, statusBy);
          },
          onReset: (){widget.onResetFilter();},
        ),
      ),
    );
  }
}

/// Dialog note Cancel
dialogNoteCancel(BuildContext context, {Function(String note) onSubmit}) {
  String _note;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Note", style: sansPro(fontWeight: FontWeight.w700)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            minLines: 3,
            maxLines: 10,
            onChanged: (val) {
              _note = val;
            },
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(normal),
          height: 40,
          child: OutlineButton(
            borderSide: BorderSide(color: primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(small)),
            child: Text("Close"),
            textColor: primaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(normal),
          height: 40,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(small)),
            child: Text("Submit"),
            textColor: whiteNeutral,
            color: primaryColor,
            onPressed: () {
              onSubmit(_note);
            },
          ),
        ),
      ],
    ),
  );
}

/// Widget Action Order
Widget actionOrderButton({
  Function() onDetail,
  Function() onComplete,
  Function() onCancel,
  bool visibleComplete = true,
  bool visibleCancel = true,
}) {
  return Column(
    children: [
      Container(
        width: 110,
        child: RaisedButton.icon(
          color: whiteNeutral,
          onPressed: () {
            onDetail();
          },
          icon: Icon(Icons.visibility, size: 15, color: Colors.blue),
          label: Text("Detail", style: sansPro(fontSize: 13)),
        ),
      ),
      Visibility(
        visible: visibleComplete,
        child: Container(
          width: 110,
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onComplete();
            },
            icon: Icon(Icons.check, size: 15, color: Colors.green),
            label: Text("Complete", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
      Visibility(
        visible: visibleCancel,
        child: Container(
          width: 110,
          child: RaisedButton.icon(
            color: whiteNeutral,
            onPressed: () {
              onCancel();
            },
            icon: Icon(Icons.clear, size: 15, color: Colors.red),
            label: Text("Cancel", style: sansPro(fontSize: 13)),
          ),
        ),
      ),
    ],
  );
}

/// Widget Filter By Date
class FilterWidget extends StatefulWidget {
  final Function(
          DateTime dateFrom, DateTime dateTo, String filterBy, String statusBy)
      onSubmit;
  final Function onReset;

  const FilterWidget({Key key, @required this.onSubmit, this.onReset}) : super(key: key);

  @override
  _FilterDateWidgetState createState() => _FilterDateWidgetState();
}

class _FilterDateWidgetState extends State<FilterWidget> {
  DateTime dateFrom, dateTo;
  String filterBy, statusBy;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(normal),
            child: Text(
              "FILTER",
              style: sansPro(fontWeight: FontWeight.w600, fontSize: medium),
            )),
        Divider(thickness: 1),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: normal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Date From",
                          style: sansPro(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      InkWell(
                        onTap: () async {
                          var res = await showDatePicker(
                              context: context,
                              initialDate: dateFrom ?? DateTime.now(),
                              firstDate: firstDate,
                              lastDate: lastDate);
                          if (res != null) {
                            setState(() {
                              dateFrom = res;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: medium),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${formatDate(dateFrom)}"),
                              Icon(Icons.date_range, color: primaryColor),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(normal)),
                        ),
                      ),
                      SizedBox(height: medium),
                      Text("Date To",
                          style: sansPro(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      InkWell(
                        onTap: () async {
                          var res = await showDatePicker(
                              context: context,
                              initialDate: dateTo ?? DateTime.now(),
                              firstDate: firstDate,
                              lastDate: lastDate);
                          if (res != null) {
                            setState(() {
                              dateTo = res;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: medium),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${formatDate(dateTo)}"),
                              Icon(Icons.date_range, color: primaryColor),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(normal)),
                        ),
                      ),
                      SizedBox(height: medium),
                      Text("Filter",
                          style: sansPro(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      borderDropdown(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Filter By"),
                              value: filterBy,
                              items: FILTER_BY.map((e) {
                                return DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                );
                              }).toList(),
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() => filterBy = val);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: medium),
                      Text("Status",
                          style: sansPro(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      borderDropdown(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Status"),
                              value: statusBy,
                              items: FILTER_STATUS.map((e) {
                                return DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                );
                              }).toList(),
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() => statusBy = val);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: medium),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: medium),
                          width: widthScreen(context),
                          height: 45,
                          child: OutlineButton(
                            child: Text("Reset"),
                            textColor: primaryColor,
                            borderSide: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(small)),
                            onPressed: () {

                              setState(() {
                                dateFrom = null;
                                dateTo = null;
                                filterBy = null;
                                statusBy = null;

                              });
                              Navigator.pop(context);
                              widget.onReset();
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: medium),
                          width: widthScreen(context),
                          height: 45,
                          child: RaisedButton(
                            child: Text("Submit"),
                            color: primaryColor,
                            textColor: whiteNeutral,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(small)),
                            onPressed: () async {
                              Navigator.pop(context);
                              widget.onSubmit(
                                  dateFrom, dateTo, filterBy, statusBy);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Not found Data
Widget notFoundDataStatus() {
  return Center(child: Text("No data available in table"));
}

/// Snackbar
Future showLocalSnackbar(content, GlobalKey<ScaffoldState> key) async {
  key.currentState.showSnackBar(SnackBar(content: Text("$content")));
}

/// Label Progress
Widget labelProgress(String status) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: normal),
    padding: EdgeInsets.symmetric(vertical: normal, horizontal: medium),
    child: Text(
      "$status",
      style: sansPro(color: whiteNeutral, fontSize: 12),
    ),
    decoration: BoxDecoration(
        color: () {
          if (status == "CANCELED") {
            return Colors.red;
          }
          if (status == "PROGRESS") {
            return labelColor;
          }
          if (status == "COMPLETED") {
            return primaryColor;
          }
          return labelColor;
        }(),
        borderRadius: BorderRadius.circular(100)),
  );
}

/// Circular Progress Indicator
Widget circularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
  ));
}

/// Confirm Dialog
customConfirmDialog(context,
    {String content = "", Function() yesButton, Function() noButton}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm",
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$content",
            style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(normal),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal)),
                    color: whiteNeutral,
                    borderSide: BorderSide(color: primaryColor),
                    child: Text("No"),
                    textColor: primaryColor,
                    onPressed: () {
                      noButton();
                    },
                  ),
                ),
              ),
              SizedBox(width: medium),
              Flexible(
                child: Container(
                  height: 45,
                  width: widthScreen(context),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal)),
                    color: primaryColor,
                    textColor: whiteNeutral,
                    child: Text("Yes"),
                    onPressed: () {
                      yesButton();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

/// Progress Dialog
progressDialog(BuildContext context) {
  showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      context: context,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(),
          ));
}

/// Custom Text Field
class CustomTextField extends StatefulWidget {
  final String label;
  final readOnly;
  final bool autoValidate;
  final String hint;
  final TextStyle labelStyle;
  final String initialValue;
  final Function(String value) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final int minLines;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final Function onEditingComplete;
  final Function onSaved;
  final EdgeInsetsGeometry contentPadding;
  final Function validator;
  const CustomTextField({
    Key key,
    this.label = "",
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.onSaved,
    this.hint = "",
    this.readOnly = false,
    this.initialValue,
    this.keyboardType,
    this.onEditingComplete,
    this.controller,
    this.autoValidate = false,
    this.labelStyle,
    this.validator
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: widget?.label?.isNotEmpty,
              child: Text("${widget?.label}",
                  style: widget?.labelStyle ??
                      sansPro(fontWeight: FontWeight.w600)),
            ),
            Visibility(
              visible: widget?.autoValidate == true,
              child: widget.controller != null
                  ? Text(
                      widget.controller.text.isEmpty ? "Form Wajib Diisi" : "",
                      style: sansPro(color: Colors.red))
                  : Text(value.isEmpty ? "Form Wajib Diisi" : "",
                      style: sansPro(color: Colors.red)),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: medium, right: normal),
          decoration: BoxDecoration(
              color: widget.readOnly ? greyNeutral : Colors.transparent,
              border: widget.autoValidate == true
                  ? widget.controller != null
                      ? Border.all(
                          color: widget.controller.text.isEmpty
                              ? Colors.red
                              : greyColor)
                      : Border.all(
                          color: value.isEmpty ? Colors.red : greyColor)
                  : Border.all(color: greyColor),
              borderRadius: BorderRadius.all(Radius.circular(normal))),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            initialValue:
                widget.controller != null ? null : widget.initialValue ?? "",
            readOnly: widget.readOnly,
            textInputAction: widget.maxLines < 1
                ? TextInputAction.done
                : TextInputAction.newline,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            onSaved: widget.onSaved,
            obscureText: widget.obscureText,
            onEditingComplete: widget.onEditingComplete == null
                ? null
                : () {
                    widget.onEditingComplete();
                    FocusScope.of(context).unfocus();
                  },
            onChanged: (val) {
              widget.onChanged(val);
              setState(() {
                value = val;
              });
            },
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hint,
              counterText: "",
              hintStyle: widget.readOnly
                  ? TextStyle(color: Colors.black)
                  : TextStyle(),
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

/// Border Dropdown
Widget borderDropdown({Widget child, bool autovalidate = false, var value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: autovalidate
              ? Border.all(
                  color: value == null ? Colors.red : greyColor,
                  style: BorderStyle.solid,
                  width: 0.80)
              : Border.all(
                  color: greyColor, style: BorderStyle.solid, width: 0.80),
        ),
        child: child,
      ),
    ],
  );
}

/// Detail Item2
Widget detailItem2(context,
    {String title, String content, TextStyle styleContent}) {
  return Container(
    margin: EdgeInsets.only(top: medium),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.only(right: normal),
              width: widthScreen(context),
              child: Text(
                title ?? "n/a",
                style: sansPro(fontWeight: FontWeight.w600),
              )),
        ),
        Flexible(
          child: Container(
              width: widthScreen(context),
              child: Text(
                ": ${content ?? ""}",
                style: styleContent ?? sansPro(),
              )),
        ),
      ],
    ),
  );
}

/// Chat Widget
Widget senderWidget(String content) {
  return Container(
    margin: EdgeInsets.only(top: normal),
    child: BubbleSpecialOne(
      text: content,
      isSender: true,
      color: Color(0xFFE2FFC7),
      tail: true,
      seen: true,
    ),
  );
}

// Widget receiverWidget(String content) {
//   return Container(
//     margin: EdgeInsets.only(top: normal),
//     child: BubbleSpecialOne(
//       text: content,
//       isSender: false,
//       color: Color(0xAF6AD0F5),
//     ),
//   );
// }

Widget receiverWidget(String msg, String consumerName, String dateAndTime) {
  return Container(
    margin: EdgeInsets.only(top: normal + small),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(consumerName[0].toUpperCase()),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BubbleSpecialOne(
              text: msg,
              senderName: consumerName,
              isSender: false,
              color: Color(0xAF6AD0F5),
            ),
            Container(
              padding: EdgeInsets.only(right: normal),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  dateAndTime ?? "",
                  style: sansPro(fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

