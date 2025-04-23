*** Settings ***
Resource  UI_Common.resource

*** Variables ***
${account_hlavicka_text}  My account
${account_profile_link_text}  Profile

*** Keywords ***
Zkontroluj nacteni stranky
    Zkontroluj text v hlavicce stranky  ${account_hlavicka_text}

Klikni na profil
    Klikni na element podle jeho textu  ${account_profile_link_text}
