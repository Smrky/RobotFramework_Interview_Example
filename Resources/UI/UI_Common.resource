*** Settings ***
Resource  ../Common.resource

Library  Browser

*** Keywords ***
Otevri prohlizec na strance
    [Arguments]  ${url}  ${browser}=${BROWSER}  ${headless}=${False}
    New Browser  ${browser}  headless=${headless}
    New Page  ${url}

Zkontroluj text v hlavicce stranky
    [Arguments]  ${text}
    ${element}  Set Variable  h1:text-is("${text}"), h2:text-is("${text}"), h3:text-is("${text}"), h4:text-is("${text}"), h5:text-is("${text}"), h6:text-is("${text}")
    Wait For Elements State  ${element}  visible

Klikni na element podle jeho textu
    [Arguments]  ${text}  ${typ_elementu}=${EMPTY}
    Click  ${typ_elementu}:text-is("${text}")

Vypln input podle textu v label
    [Arguments]  ${label_text}  ${text}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> input
    Fill Text  ${element}  ${text}

Klikni na element podle textu v label
    [Arguments]  ${label_text}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> :not(label)
    Click  ${element}

Vyber ze selectu hodnotu podle jejiho textu a textu v label
    [Arguments]  ${label_text}  ${hodnota_text}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> select
    Select Options By  ${element}  text  ${hodnota_text}

Vyber ze selectu hodnotu podle value a textu v label a vrat vyplnenou hodnotu
    [Arguments]  ${label_text}  ${value_text}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> select
    Select Options By  ${element}  value  ${value_text}
    ${hodnota}  Get Selected Options  ${element}  text
    RETURN  ${hodnota}

Vyber ze selectu nahodnou hodnotu podle textu v label a vrat vyplnenou hodnotu
    [Arguments]  ${label_text}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> select
    ${pocet_moznosti}  Get Element Count  ${element} option
    ${nahodny_index}  Evaluate  random.randint(0, ${pocet_moznosti}-1)
    Select Options By  ${element}  index  ${nahodny_index}
    ${hodnota}  Get Selected Options  ${element}  text
    RETURN  ${hodnota}

Ziskej hodnotu z elementu podle textu v label
    [Arguments]  ${label_text}  ${typ_elementu}
    ${element}  Set Variable  label:text-is("${label_text}") >> .. >> ${typ_elementu}
    ${hodnota}  Get Text  ${element}
    RETURN  ${hodnota}

Ziskej hodnotu z inputu podle textu v label
    [Arguments]  ${label_text}
    ${hodnota}  Ziskej hodnotu z elementu podle textu v label  ${label_text}  input
    RETURN  ${hodnota}

Ziskej hodnotu ze selectu podle textu v label
    [Arguments]  ${label_text}
    ${hodnota}  Ziskej hodnotu z elementu podle textu v label  ${label_text}  select
    RETURN  ${hodnota}
