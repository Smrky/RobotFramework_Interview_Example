*** Settings ***
Resource  API_Common.resource

*** Keywords ***
Zavolej POST users/register
    [Arguments]  ${firstname}  ${lastname}  ${address}  ${city}  ${state}  ${postcode}  ${country}  ${phone}  ${dob}  ${password}  ${email}
    ${request_body}  Nastav hodnoty pro JSON soubor  ${JSON_FOLDER}${/}POST_Users_Register.json  
    ...  first_name=${firstname}  last_name=${lastname}  address=${address}  city=${city}  state=${state}  
    ...  postcode=${postcode}  country=${country}  phone=${phone}  dob=${dob}  password=${password}  email=${email}

    ${response}  POST On Session  ${PRACTICE_SITE_SESSION_ALIAS}  users/register  json=${request_body}  expected_status=any
    RETURN  ${response}

Zavolej POST users/login
    [Arguments]  ${email}  ${password}
    ${request_body}  Nastav hodnoty pro JSON soubor  ${JSON_FOLDER}${/}POST_Users_Login.json  
    ...  email=${email}  password=${password}

    ${response}  POST On Session  ${PRACTICE_SITE_SESSION_ALIAS}  users/login  json=${request_body}  expected_status=any
    RETURN  ${response}

Zavolej GET users/me
    [Arguments]  ${token}
    ${headers}  Create Dictionary  Authorization=Bearer ${token}
    ${response}  GET On Session  ${PRACTICE_SITE_SESSION_ALIAS}  users/me  headers=${headers}  expected_status=any
    RETURN  ${response}
