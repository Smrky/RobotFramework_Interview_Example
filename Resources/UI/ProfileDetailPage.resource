*** Settings ***
Resource  UI_Common.resource

*** Variables ***
${profile_hlavicka_text}  Profile
${profile_first_name_input_text}  First name
${profile_last_name_input_text}  Last name
${profile_email_address_input_text}  Email address
${profile_phone_input_text}  Phone
${profile_address_input_text}  Address
${profile_postcode_input_text}  Postcode
${profile_city_input_text}  City
${profile_state_input_text}  State
${profile_country_input_text}  Country
${profile_update_button_text}  Update Profile

*** Keywords ***
Zkontroluj nacteni stranky
    Wait For Load State  domcontentloaded
    Zkontroluj text v hlavicce stranky  ${profile_hlavicka_text}

Ziskej profilove udaje 
    Pockej nez se nactou profilove udaje
    ${ukazane_jmeno}  Ziskej hodnotu z inputu podle textu v label  ${profile_first_name_input_text}
    ${ukazane_prijmeni}  Ziskej hodnotu z inputu podle textu v label  ${profile_last_name_input_text}
    ${ukazany_email}  Ziskej hodnotu z inputu podle textu v label  ${profile_email_address_input_text}
    ${ukazany_telefon}  Ziskej hodnotu z inputu podle textu v label  ${profile_phone_input_text}
    ${ukazana_adresa}  Ziskej hodnotu z inputu podle textu v label  ${profile_address_input_text}
    ${ukazane_psc}  Ziskej hodnotu z inputu podle textu v label  ${profile_postcode_input_text}
    ${ukazane_mesto}  Ziskej hodnotu z inputu podle textu v label  ${profile_city_input_text}
    ${ukazany_stat}  Ziskej hodnotu z inputu podle textu v label  ${profile_state_input_text}
    ${ukazane_zeme}  Ziskej hodnotu z inputu podle textu v label  ${profile_country_input_text}
    &{ukazane_profilove_udaje}  Create Dictionary  ukazane_jmeno=${ukazane_jmeno}  ukazane_prijmeni=${ukazane_prijmeni}  ukazany_email=${ukazany_email}  ukazany_telefon=${ukazany_telefon}
    ...  ukazana_adresa=${ukazana_adresa}  ukazane_psc=${ukazane_psc}  ukazane_mesto=${ukazane_mesto}  ukazany_stat=${ukazany_stat}  ukazane_zeme=${ukazane_zeme}
    RETURN  &{ukazane_profilove_udaje}

Pockej nez se nactou profilove udaje
    ${ukazany_email}  Ziskej hodnotu z inputu podle textu v label  ${profile_email_address_input_text}
    
    WHILE  "${ukazany_email}" == "${EMPTY}"
        Sleep  0.1 s
        ${ukazany_email}  Ziskej hodnotu z inputu podle textu v label  ${profile_email_address_input_text}
    END

Zkontroluj profilove udaje s registracnimi
    [Arguments]  ${ukazane_jmeno}  ${ukazane_prijmeni}  ${ukazany_email}  ${ukazany_telefon}  ${ukazana_adresa}  ${ukazane_psc}  ${ukazane_mesto}  ${ukazany_stat}  ${ukazane_zeme}
    ...  ${jmeno}=${EMPTY}  ${prijmeni}=${EMPTY}  ${email}=${EMPTY}  ${telefon}=${EMPTY}  ${adresa}=${EMPTY}  ${psc}=${EMPTY}  ${mesto}=${EMPTY}  ${stat}=${EMPTY}  ${zeme_kod}=${EMPTY}
    ...  &{nekontrolovane_udaje}
    IF  "${jmeno}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazane_jmeno}  ${jmeno}
    IF  "${prijmeni}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazane_prijmeni}  ${prijmeni}
    IF  "${email}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazany_email}  ${email}
    IF  "${telefon}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazany_telefon}  ${telefon}
    IF  "${adresa}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazana_adresa}  ${adresa}
    IF  "${psc}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazane_psc}  ${psc}
    IF  "${mesto}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazane_mesto}  ${mesto}
    IF  "${stat}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazany_stat}  ${stat}
    IF  "${zeme_kod}" != "${EMPTY}"  Should Be Equal As Strings  ${ukazane_zeme}  ${zeme_kod}
