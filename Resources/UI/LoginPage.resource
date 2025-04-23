*** Settings ***
Resource  UI_Common.resource

*** Variables ***
${login_hlavicka_text}  Login
${login_email_input_text}  Email address *
${login_password_input_text}  Password *
${login_login_button_text}  Login
${login_login_button_type}  input
${login_register_link_text}  Register your account

*** Keywords ***
Zkontroluj nacteni stranky
    Zkontroluj text v hlavicce stranky  ${login_hlavicka_text}

Prihlas se
    [Arguments]  ${email}  ${heslo}
    Vypln input podle textu v label  ${login_email_input_text}  ${email}
    Vypln input podle textu v label  ${login_password_input_text}  ${heslo}
    Klikni na element podle jeho textu  ${login_login_button_text}  ${login_login_button_type}

Klikni na zaregistrovat ucet
    Klikni na element podle jeho textu  ${login_register_link_text}
