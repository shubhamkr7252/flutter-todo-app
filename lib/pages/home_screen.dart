import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todo_test_app/pages/home_components/drawer.dart';
import 'package:todo_test_app/widgets/input_helper.dart';
import 'dart:math' as math;

class HomeScreenShowcase extends StatelessWidget {
  const HomeScreenShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (_) => const HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String? _date;
  String? _time;
  List<Map<String, Object>> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const HomeDrawer(),
      appBar: AppBar(title: const Text("TODO LIST"), centerTitle: true),
      body: todoList.isNotEmpty
          ? groupedList()
          : Center(
              child: Text(
                "Click on '+' icon to add a new task.",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .04,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                  return bottomSheet(context, setModalState);
                });
              }).whenComplete(() => {
                _time = null,
                _date = null,
                _textEditingController.clear(),
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  GroupedListView<dynamic, String> groupedList() {
    return GroupedListView<dynamic, String>(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => item1['Time'].compareTo(item2['Time']),
      order: GroupedListOrder.DESC,
      elements: todoList,
      groupBy: (todoList) => todoList!['Date'],
      groupSeparatorBuilder: (value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      itemBuilder: (context, listItem) => Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(todoList.indexOf(listItem).toString()),
        background: Card(
          color: Theme.of(context).colorScheme.error,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete),
          ),
        ),
        onDismissed: (direction) {
          setState(() {
            todoList.remove(listItem);
          });
        },
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 25,
                width: 5,
                color: listItem["startContainerColor"],
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Opacity(
                    opacity: listItem["isComplete"] ? 0.3 : 1,
                    child: Row(
                      children: [
                        Expanded(child: Text(listItem["Description"])),
                        const SizedBox(width: 10),
                        Text(listItem["Time"]),
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            checkColor:
                                Theme.of(context).colorScheme.background,
                            fillColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            value: listItem["isComplete"],
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {
                              setState(() {
                                listItem["isComplete"] =
                                    !listItem["isComplete"];
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding bottomSheet(BuildContext context, StateSetter setModalState) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width * .02),
                const Center(child: Icon(Icons.drag_handle)),
                SizedBox(height: MediaQuery.of(context).size.width * .035),
                Text(
                  "ADD TASK",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.width * .05,
                  ),
                ),
                InputHelper.textInput(context,
                    prefixIcon: const Icon(Icons.task_alt),
                    hint: "Task",
                    textCapitalization: TextCapitalization.sentences,
                    onValidate: (String value) {
                  if (value.isEmpty) {
                    return "Task field cannot be empty.";
                  }
                  return null;
                },
                    textInputAction: TextInputAction.done,
                    textController: _textEditingController),
                SizedBox(height: MediaQuery.of(context).size.width * .035),
                InputHelper.animatedButton(
                    context: context,
                    buttonText: "Save",
                    buttonController: _btnController,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (validataAndSave()) {
                        addTask();
                      } else {
                        _btnController.reset();
                      }
                    }),
                SizedBox(height: MediaQuery.of(context).size.width * .03),
                Row(
                  children: [
                    Expanded(
                        child: TextButton.icon(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.utc(2030, 12, 31),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            setModalState(() {
                              _date = DateFormat('MMM dd yyyy')
                                  .format(pickedDate)
                                  .toUpperCase();
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.today),
                      label: Text(_date ?? "Select Date"),
                    )),
                    Expanded(
                        child: TextButton.icon(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((pickedTime) {
                          if (pickedTime != null) {
                            setModalState(() {
                              _time = pickedTime.format(context);
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(_time ?? "Select Time"),
                    )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addTask() {
    _btnController.success();
    Future.delayed(const Duration(seconds: 1)).then((_) => {
          setState(() {
            todoList.add({
              "Date": _date ??
                  DateFormat('MMM dd yyyy')
                      .format(DateTime.now())
                      .toUpperCase(),
              "Time": _time ?? TimeOfDay.now().format(context),
              "Description": _textEditingController.text.trim(),
              "isComplete": false,
              "startContainerColor":
                  Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
            });
          }),
          Navigator.of(context).pop(),
        });
  }

  bool validataAndSave() {
    final form = _globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
