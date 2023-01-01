from admin_functionalities import add_expert, delete_client, delete_expert, hide_record, delete_record
from expert_functionalities import add_plant_to_encyclopedia, edit_plant_description
# from shared_functionalities import report_an_issue
from user_functionalities import search_for_plant_in_encyclopedia, add_plant_to_library, show_library, \
    delete_from_library


def user_interface():
    logged = True
    while logged:
        user_input = input(
            "1: log out\n2: search for plants\n3: add plant to library\n4: show library\n5: delete from library")

        if user_input == "1":
            logged = False
            continue
        elif user_input == "2":
            search_for_plant_in_encyclopedia()
        elif user_input == "3":
            add_plant_to_library()
        elif user_input == "4":
            show_library()
        elif user_input == "5":
            delete_from_library()
        else:
            print("wrong input")


def expert_interface():
    logged = True

    while logged:
        user_input = input(
            "1: log out\n2: search for plants\n3: add plant to library\n4: show library\n5: delete from library\n6: add "
            "plant to encyclopedia\n7: edit plant description")

        if user_input == "1":
            logged = False
            continue
        elif user_input == "2":
            search_for_plant_in_encyclopedia()
        elif user_input == "3":
            add_plant_to_library()
        elif user_input == "4":
            show_library()
        elif user_input == "5":
            delete_from_library()
        elif user_input == "6":
            add_plant_to_encyclopedia()
        elif user_input == "7":
            edit_plant_description()
        else:
            print("wrong input")


def admin_interface():
    logged = True
    user_input = input(
        '1: log out\n2: add expert\n3: delete client\n4: delete expert\n5: hide record\n6: add expert\n7: delete record')

    while logged:
        if user_input == "1":
            logged = False
            continue
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
