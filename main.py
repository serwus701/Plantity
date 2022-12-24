from shared_functionalities import start
from shared_sql_requests import do_sum_sql_request, sql_request_login

if __name__ == '__main__':
    print(sql_request_login("Mistknnn", "123password"))