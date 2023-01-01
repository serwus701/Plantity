from admin_functionalities import edit_if_expert, delete_client, hide_record, delete_record
from expert_functionalities import add_plant_to_encyclopedia, edit_plant_description
# from shared_functionalities import report_an_issue
from user_functionalities import search_for_plant_in_encyclopedia, add_plant_to_library, show_library, \
    delete_from_library


# TODO: Redo entire UI in flutter (heh)
# TODO: Rethink report issue
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


# TODO: Add admin UI
def admin_interface():
    logged = True

    while logged:
        user_input = input(
            '1: log out\n2: edit if expert\n3: delete client\n4: hide record\n5: add expert\n6: delete record')

        if user_input == "1":
            logged = False
            continue
        elif user_input == "2":
            edit_if_expert()
        elif user_input == "3":
            delete_client()
        elif user_input == "4":
            hide_record()
        elif user_input == "5":
            delete_record()
        else:
            print("wrong input")
