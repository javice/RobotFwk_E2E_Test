*** Settings ***
Documentation    Avis Vehicle Search Tests
Resource         ../resources/AvisPage.robot


Suite Setup    Setup Browser 
#Open Browser    about:blank    chrome    options=add_argument("--user-data-dir=/tmp/chrome-user-data")
Suite Teardown   Close All Browsers

*** Variables ***
${NAVIGATION_LINKS}    xpath=//nav[contains(@class, 'link-list')]//a

*** Keywords ***
Setup Browser
    ${unique_dir}=    Evaluate    '/tmp/chrome-user-data-' + str(uuid.uuid4())    uuid
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    selenium
    ${options.add_argument}=    Set Variable    --user-data-dir=${unique_dir}
    Open Browser    about:blank    chrome    options=${options}

Navigate To Popular Locations
    [Arguments]    ${location}
    ${elements}=    Get WebElements    ${NAVIGATION_LINKS}
    # Recorremos todos los links
    FOR    ${element}    IN    @{elements}
        ${link_text}=    Get Element Attribute    ${element}    text
        Log    Found link: ${link_text}
        # Seleccionamos el link que cumpla con el criterio
        Run Keyword If    '${link_text}' == '${location}'    Click Element    ${element}
    END

Setup Dates and Times
    ${pickup_date}=    Set Day Variable    pickup
    ${dropoff_date}=    Set Day Variable    dropoff
    ${pickup_time}=    Set Time Variable    
    ${dropoff_time}=    Set Time Variable    
    RETURN    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}


*** Test Cases ***
# Búsqueda de coches.
Should Successfully Search For A Car Rental
    [Documentation]    Tests the car rental search functionality
    Navigate To Avis    https://www.avis.es/
    Accept Cookies
    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}=    Setup Dates and Times       
    Perform Complete Search    Madrid Aeropuerto    Barcelona Aeropuerto    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}    CAR

# Búsqueda de furgonetas.
Should Successfully Search For A Van Rental
    [Documentation]    Tests the van rental search functionality
    Navigate To Avis    https://www.avis.es/
    Accept Cookies
    
    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}=    Setup Dates and Times       
    Perform Complete Search    Barcelona    Alicante    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}    VAN