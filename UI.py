from admin_functionalities import add_expert, delete_client, delete_expert, hide_record, delete_record
from expert_functionalities import add_plant, edit_plant_description, report_an_issue
from user_functionalitioes import search_for_plant


def user_interface():

    logged = True
    while logged:
        user_input = input("1: log out\n2: search for plants")

        if user_input == "1":
            logged = False
        elif user_input == "2":
            search_for_plant()
        else:
            print("wrong input")


def expert_interface():
    logged = True
    user_input = input("1: log out\n2: add plant\n3: edit plant description\n4: report an issue\n")

    while logged:
        if user_input == "1":
            logged = False
        elif user_input == "2":
            add_plant()
        elif user_input == "3":
            edit_plant_description()
        elif user_input == "4":
            report_an_issue()
        else:
            print("wrong input")

def admin_interface():
    logged = True
    user_input = input("1: log out\n2: add expert\n3: delete client\n4: delete expert\n5: hide record\n6: add expert\n7: delete record")

    while logged:
        if user_input == "1":
            logged = False
        elif user_input == "2":
            add_expert()
        elif user_input == "3":
            delete_client()
        elif user_input == "4":
            delete_expert()
        elif user_input == "5":
            hide_record()
        elif user_input == "6":
            delete_record()
        else:
            print("wrong input")