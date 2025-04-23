*** Settings ***
Resource  ../Common.resource

Library  RequestsLibrary
Library  JSONLibrary

*** Keywords ***
Nastav hodnoty pro JSON soubor
    [Arguments]  ${json_path}  &{json_path_value}
    ${json}  Load Json From File  ${json_path}
    FOR  ${key}  ${value}  IN  &{json_path_value}
        ${value}  Convert To String  ${value}
        ${json}  Update Value To Json  ${json}  json_path=$.${key}  new_value=${value}
    END
    RETURN  ${json}    
