*** Settings ***
Resource  UI_Common.resource

*** Variables ***
${navbar_sign_in_button_text}  Sign in

*** Keywords ***
Klikni na Sign in
    Klikni na element podle jeho textu  ${navbar_sign_in_button_text}
    