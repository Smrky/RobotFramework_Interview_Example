*** Settings ***
Resource  ../Resources/UI/UI_Common.resource
Resource  ../Resources/UI/NavigationBar.resource
Resource  ../Resources/UI/LoginPage.resource
Resource  ../Resources/UI/RegisterPage.resource
Resource  ../Resources/UI/AccountPage.resource
Resource  ../Resources/UI/ProfileDetailPage.resource

*** Test Cases ***
Zaregistruj uzivatele s nahodnymi udaji
    Otevri prohlizec na strance  ${PRACTICE_SITE}
    NavigationBar.Klikni na Sign in
    LoginPage.Zkontroluj nacteni stranky
    LoginPage.Klikni na zaregistrovat ucet
    RegisterPage.Zkontroluj nacteni stranky
    &{registracni_udaje}  RegisterPage.Vypln registracni formular
    LoginPage.Zkontroluj nacteni stranky
    LoginPage.Prihlas se  ${registracni_udaje}[email]  ${registracni_udaje}[heslo]
    AccountPage.Zkontroluj nacteni stranky
    AccountPage.Klikni na profil
    ProfileDetailPage.Zkontroluj nacteni stranky
    &{profilove_udaje}  ProfileDetailPage.Ziskej profilove udaje
    ProfileDetailPage.Zkontroluj profilove udaje s registracnimi  &{profilove_udaje}  &{registracni_udaje}
