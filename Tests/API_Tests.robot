*** Settings ***
Resource  ../Resources/API/API_Definition.resource
Resource  ../Resources/UI/RegisterPage.resource

Library  Collections

Test Setup  Create Session  ${PRACTICE_SITE_SESSION_ALIAS}  ${PRACTICE_SITE_API}

*** Test Cases ***
Zaregistruj uzivatele s nahodnymi udaji pak se s nim zaloguj a zkontroluj udaje pres API
    ${firstname}  ${lastname}  ${dob}  ${address}  ${postcode}  ${city}  ${state}  ${country_code}  ${phone}  ${email}  ${password}
    ...  RegisterPage.Vygeneruj nahodne chybejici udaje
    ${register_response}  Zavolej POST users/register  firstname=${firstname}  lastname=${lastname}  address=${address}  city=${city}
    ...  state=${state}  postcode=${postcode}  country=${country_code}  phone=${phone}  dob=${dob}  password=${password}  email=${email}
    Status Should Be  201  ${register_response}
    ${login_response}  Zavolej POST users/login  email=${email}  password=${password}
    Status Should Be  200  ${login_response}
    ${me_response}  Zavolej GET users/me  ${login_response.json()}[access_token]
    Status Should Be  200  ${me_response}
    Zkontroluj response GET users/me oproti zadanym hodnotam  response=${me_response}  firstname=${firstname}  lastname=${lastname}  
    ...    dob=${dob}  address=${address}  postcode=${postcode}  city=${city}  state=${state}  country_code=${country_code}  
    ...    phone=${phone}  email=${email}  id=${register_response.json()}[id]

Zkontroluj registraci uzivatele mladsiho 18 let
    ${firstname}  ${lastname}  ${dob}  ${address}  ${postcode}  ${city}  ${state}  ${country_code}  ${phone}  ${email}  ${password}
    ...  RegisterPage.Vygeneruj nahodne chybejici udaje  vek_max=17  heslo=aaa

    ${register_response}  Zavolej POST users/register  firstname=${firstname}  lastname=${lastname}  address=${address}  city=${city}
    ...  state=${state}  postcode=${postcode}  country=${country_code}  phone=${phone}  dob=${dob}  password=${password}  email=${email}
    Status Should Be  422  ${register_response}
    List Should Contain Value  ${register_response.json()}[dob]  Customer must be 18 years old.
    Log  ${register_response.json()}
