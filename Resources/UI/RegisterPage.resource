*** Settings ***
Resource  UI_Common.resource

Library  FakerLibrary

*** Variables ***
${register_hlavicka_text}  Customer registration
${register_first_name_input_text}  First name
${register_last_name_input_text}  Last name
${register_date_of_birth_input_text}  Date of Birth *
${register_address_input_text}  Address
${register_postcode_input_text}  Postcode
${register_city_input_text}  City
${register_state_input_text}  State
${register_state_input_type}  select
${register_country_input_text}  Country
${register_phone_input_text}  Phone
${register_email_address_input_text}  Email address
${register_password_input_text}  Password
${register_register_button_text}  Register

*** Keywords ***
Zkontroluj nacteni stranky
    Zkontroluj text v hlavicce stranky  ${register_hlavicka_text}

Vypln registracni formular
    [Arguments]  ${jmeno}=${None}  ${prijmeni}=${None}  ${datum_narozeni}=${None}  ${adresa}=${None}  ${psc}=${None}  
    ...  ${mesto}=${None}  ${stat}=${None}  ${zeme_kod}=${None}  ${telefon}=${None}  ${email}=${None}  ${heslo}=${None}

    ${jmeno}  ${prijmeni}  ${datum_narozeni}  ${adresa}  ${psc}  ${mesto}  ${stat}  ${zeme_kod}  ${telefon}  ${email}  ${heslo}  
    ...    Vygeneruj nahodne chybejici udaje  jmeno=${jmeno}  prijmeni=${prijmeni}  datum_narozeni=${datum_narozeni}  adresa=${adresa}  
    ...    psc=${psc}  mesto=${mesto}  stat=${stat}  zeme_kod=${zeme_kod}  telefon=${telefon}  email=${email}  heslo=${heslo}
    Vypln input podle textu v label  ${register_first_name_input_text}  ${jmeno}
    Vypln input podle textu v label  ${register_last_name_input_text}  ${prijmeni}
    Vypln input podle textu v label  ${register_date_of_birth_input_text}  ${datum_narozeni}
    Vypln input podle textu v label  ${register_address_input_text}  ${adresa}
    Vypln input podle textu v label  ${register_postcode_input_text}  ${psc}
    Vypln input podle textu v label  ${register_city_input_text}  ${mesto}
    Vypln input podle textu v label  ${register_state_input_text}  ${stat}
    ${zeme}  Vyber ze selectu hodnotu podle value a textu v label a vrat vyplnenou hodnotu  ${register_country_input_text}  ${zeme_kod}
    Vypln input podle textu v label  ${register_phone_input_text}  ${telefon}
    Vypln input podle textu v label  ${register_email_address_input_text}  ${email}
    Vypln input podle textu v label  ${register_password_input_text}  ${heslo}
    Klikni na element podle textu v label  ${register_date_of_birth_input_text}
    &{uzivatelske_udaje}  Create Dictionary  jmeno=${jmeno}  prijmeni=${prijmeni}  datum_narozeni=${datum_narozeni}  adresa=${adresa}  
    ...    psc=${psc}  mesto=${mesto}  stat=${stat}  zeme_kod=${zeme_kod}  telefon=${telefon}  email=${email}  heslo=${heslo}  zeme=${zeme}
    Potvrd odeslani formulare
    RETURN  &{uzivatelske_udaje}

Vygeneruj nahodne chybejici udaje
    [Arguments]  ${jmeno}=${None}  ${prijmeni}=${None}  ${datum_narozeni}=${None}  ${vek_min}=18  ${vek_max}=115
    ...  ${adresa}=${None}  ${psc}=${None}  ${mesto}=${None}  ${stat}=${None}  ${zeme_kod}=${None}  ${telefon}=${None}  
    ...  ${email}=${None}  ${email_domena}=c.de  ${heslo}=${None}  ${heslo_delka_min}=12  ${heslo_delka_max}=30
    IF  "${jmeno}" == "${None}"
        ${jmeno}  FakerLibrary.Firstname
    END

    IF  "${prijmeni}" == "${None}"
        ${prijmeni}  FakerLibrary.Lastname
    END

    IF  "${datum_narozeni}" == "${None}"
        IF  ${vek_max} < ${vek_min}
            ${vek_min}  Set Variable  ${vek_max}
        END
        ${datum_narozeni}  FakerLibrary.DateOfBirth  minimum_age=${vek_min}  maximum_age=${vek_max}
    END

    IF  "${adresa}" == "${None}"
        ${adresa}  FakerLibrary.StreetAddress
    END

    IF  "${psc}" == "${None}"
        ${psc}  FakerLibrary.Postcode
    END

    IF  "${mesto}" == "${None}"
        ${mesto}  FakerLibrary.City
    END

    IF  "${stat}" == "${None}"
        ${stat}  FakerLibrary.State
    END

    IF  "${zeme_kod}" == "${None}"
        ${zeme_kod}  FakerLibrary.Country Code
    END

    IF  "${telefon}" == "${None}"
        ${telefon}  FakerLibrary.Random Number
    END

    IF  "${email}" == "${None}"
        ${email}  FakerLibrary.Email  domain=${email_domena}
    END

    IF  "${heslo}" == "${None}"
        ${heslo}  Vygeneruj heslo  ${heslo_delka_min}  ${heslo_delka_max}
    END

    RETURN  ${jmeno}  ${prijmeni}  ${datum_narozeni}  ${adresa}  ${psc}  ${mesto}  ${stat}  ${zeme_kod}  ${telefon}  ${email}  ${heslo}

Vygeneruj heslo
    [Arguments]  ${delka_start}=0  ${delka_konec}=30
    ${nahodna_delka}  Evaluate  random.randint(${delka_start}, ${delka_konec})
    ${heslo}  FakerLibrary.Password  length=${nahodna_delka}
    RETURN  ${heslo}

Potvrd odeslani formulare
    Klikni na element podle jeho textu  ${register_register_button_text}
