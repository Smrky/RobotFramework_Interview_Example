*** Settings ***
Resource  GlobalVariables.resource
Resource  TestData.resource

*** Keywords ***
Zkontroluj response GET users/me oproti zadanym hodnotam
    [Arguments]  ${response}  ${firstname}  ${lastname}  ${address}  ${city}  ${state}  ${country_code}  ${postcode}  ${phone}  ${dob}  ${email}  ${id}
    Should Be Equal As Strings  ${response.json()}[first_name]  ${firstname}
    Should Be Equal As Strings  ${response.json()}[last_name]  ${lastname}
    Should Be Equal As Strings  ${response.json()}[address]  ${address}
    Should Be Equal As Strings  ${response.json()}[city]  ${city}
    Should Be Equal As Strings  ${response.json()}[state]  ${state}
    Should Be Equal As Strings  ${response.json()}[country]  ${country_code}
    Should Be Equal As Strings  ${response.json()}[postcode]  ${postcode}
    Should Be Equal As Strings  ${response.json()}[phone]  ${phone}
    Should Be Equal As Strings  ${response.json()}[dob]  ${dob}
    Should Be Equal As Strings  ${response.json()}[email]  ${email}
    Should Be Equal As Strings  ${response.json()}[id]  ${id}
