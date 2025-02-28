*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

*** Variables ***

${COOKIE_ACCEPT_BUTTON}   css=.standard-form__submit
${PICKUP_OFFICE}          id=hire-search
${DROPOFF_OFFICE}         id=return-search
${CHECK_DIFFERENT_RETURN}    xpath=//label[@for='trigger-return-location']
${RBTN_VAN}    //label[@for='fleet-van']
${RBTN_CAR}    //label[@for='fleet-car']
${PICKUP_DATE}    //input[@id='date-from-display']
${DROPOFF_DATE}    //input[@id='date-to-display']
${PICKUP_TIME}          //select[@name='ui-timepicker-time-from-display']  
${DROPOFF_TIME}            //select[@name='ui-timepicker-time-to-display']
${PICKUP_SUGGESTIONS}     css=.booking-widget__results__item:first-child .booking-widget__results__link
${DROPOFF_SUGGESTIONS}     css=.booking-widget__results__item:first-child .booking-widget__results__link
${PICKUP_DATE_SUGGESTIONS}    //div[contains(@class, 'date-picker')]//button[contains(@class, 'pika-button pika-day')]
${DROPOFF_DATE_SUGGESTIONS}    //div[contains(@class, 'date-picker')]//button[contains(@class, 'pika-button pika-day')] 
${PICKUP_TIME_SUGGESTIONS}    //div[contains(@class, 'ui-timepicker-wrapper')]//li[contains(@class, 'ui-timepicker-am') or contains(@class, 'ui-timepicker-pm')]
${DROPOFF_TIME_SUGGESTIONS}    //div[contains(@class, 'ui-timepicker-wrapper')]//li[contains(@class, 'ui-timepicker-am') or contains(@class, 'ui-timepicker-pm')]
${SEARCH_BUTTON}      //*[@id="getAQuote"]/div[7]/button   
${RESULTS_HEADING}        id=title__heading

*** Keywords ***
Set Month Variable
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${current_date}=    Subtract Time From Date    ${current_date}    30 days    date_format=%Y-%m-%d
    ${month}=    Convert To Integer    ${current_date.split('-')[1]}
    Set Suite Variable    ${month}
    RETURN    ${month}
Set Day Variable
    [Arguments]    ${type}
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${month}=    Set Month Variable
    IF    '${type}' == 'pickup'
        ${day}=    Add Time To Date    ${current_date}    1 days    result_format=%d
    ELSE
        ${day}=    Add Time To Date    ${current_date}    2 days    result_format=%d
    END
    Log    ${day}
    Log    ${month}
    ${day}=    Convert To Integer    ${day}
    Set Suite Variable    ${day}
    Set Suite Variable    @{PICKUP_DATE_SUGGESTIONS}    //div[@class='pika-single']//button[@data-pika-year='2024' and @data-pika-month='${month}' and @data-pika-day='${day}']
    Set Suite Variable    @{DROPOFF_DATE_SUGGESTIONS}    //div[@class='pika-single']//button[@data-pika-year='2024' and @data-pika-month='${month}' and @data-pika-day='${day}']

    RETURN    ${day}
Set Time Variable
    ${current_time}=    Get Current Date    result_format=%H:%M
    ${time}=    Format Time    ${current_time}
    Set Suite Variable    ${time}
    Set Suite Variable    ${PICKUP_TIME_SUGGESTIONS}    //ul[@class='ui-timepicker-list']//li[contains(text(), '${time}')]
    Set Suite Variable    ${DROPOFF_TIME_SUGGESTIONS}    //ul[@class='ui-timepicker-list']//li[contains(text(), '${time}')]
    
    RETURN    ${time}
Navigate To Avis
    [Arguments]    ${url}
    Go To    ${url}
    Maximize Browser Window

Accept Cookies
    # Comprobamos que 'Aceptar cookies' esta visible
    ${element_exists}=    Run Keyword And Return Status    Page Should Contain Element    id=consent_prompt_accept
    Log    Cookie accept button exists: ${element_exists}

    # Solamente si esta visible hacemos click
    Run Keyword If    ${element_exists}    Wait Until Element Is Visible    //*[@id="consent_prompt_accept"]    timeout=30s    error=Cookie banner not found
    Run Keyword If    ${element_exists}    Click Element    //*[@id="consent_prompt_accept"]  # Click the accept button

Set Location
    [Arguments]    ${field_locator}    ${location}    ${type}
    Wait Until Element Is Visible    ${field_locator}    timeout=10s
    Clear Element Text    ${field_locator}
   
    Wait Until Element Is Visible    ${DROPOFF_OFFICE}    timeout=10s
    # Convertimos location en una lista
    @{location_list}=    Create List    ${location}  # Ensure location is treated as a list
    # Tecleamos la location caracter a caracter
    FOR    ${char}    IN    @{location_list}
        Input Text    ${field_locator}    ${char}    append=True
        Sleep    0.3s
    END
    Sleep    1s
    Press Keys    ${field_locator}    ARROW_DOWN    RETURN

    # Comprobamos que las sugerencias estan visibles
    Wait Until Element Is Visible    ${PICKUP_SUGGESTIONS}    timeout=10s
    Wait Until Element Is Visible    ${DROPOFF_SUGGESTIONS}    timeout=10s

    # Comprobamos que las sugerencias estan habilitadas
    ${pickup_suggestions_interactable}=    Run Keyword And Return Status    Element Should Be Enabled    ${PICKUP_SUGGESTIONS}
    ${dropoff_suggestions_interactable}=    Run Keyword And Return Status    Element Should Be Enabled    ${DROPOFF_SUGGESTIONS}

    # Hacemos click en la sugerencia
    IF    '${type}' == 'pickup' and ${pickup_suggestions_interactable}
        Click Element    ${PICKUP_SUGGESTIONS}
    ELSE IF    '${type}' == 'dropoff' and ${dropoff_suggestions_interactable}
        Click Element    ${DROPOFF_SUGGESTIONS}
    ELSE
        Log    Invalid location type specified or element not interactable: ${type}
    END

Set Date
    [Arguments]    ${date_field}    ${date}    ${type}
    Log    Setting date: '${date}' for type: '${type}'
    Wait Until Element Is Visible     ${date_field}
    Click Element    ${date_field}
    
    IF    '${type}' == 'pickup'
        Wait Until Element Is Visible    ${PICKUP_DATE_SUGGESTIONS}    timeout=10s
        Click Element    ${PICKUP_DATE_SUGGESTIONS}
    ELSE IF    '${type}' == 'dropoff'
        Wait Until Element Is Visible    ${DROPOFF_DATE_SUGGESTIONS}    timeout=10s
        Click Element    ${DROPOFF_DATE_SUGGESTIONS}
    ELSE
        Log    Invalid date type specified: ${type}
    END

Set Time
    [Arguments]    ${time_field}    ${time}    ${type}  
    Log    Setting time: ${time} for type: ${type}
    Wait Until Element Is Visible    ${time_field}    timeout=10s
    Click Element    ${time_field}

    IF    '${type}' == 'pickup'
        Wait Until Element Is Visible    ${PICKUP_TIME_SUGGESTIONS}    timeout=10s
        Click Element    ${PICKUP_TIME_SUGGESTIONS}
    ELSE IF    '${type}' == 'dropoff'
        Wait Until Element Is Visible    ${DROPOFF_TIME_SUGGESTIONS}    timeout=10s
        Click Element    ${DROPOFF_TIME_SUGGESTIONS}
    ELSE
        Log    Invalid time type specified: ${type}
    END



Format Time
    [Arguments]    ${time}
    ${time_parts}=    Split String    ${time}    :
    ${hour}=    Convert To Integer    ${time_parts[0]}
    ${minute}=    Convert To Integer    ${time_parts[1]}

    # Comprobar que la hora y los minutos son correctos
    Run Keyword If    ${hour} < 0 or ${hour} > 23 or ${minute} < 0 or ${minute} > 59    Fail    Invalid time format: ${time}
    
    # Aseguramos el formato de la hora
    ${formatted_time}=    Set Variable    ${hour}:00
    RETURN    ${formatted_time}

Perform Complete Search
    [Arguments]    ${pickup_location}    ${dropoff_location}    ${pickup_date}    ${dropoff_date}    ${pickup_time}    ${dropoff_time}    ${vehicle_type}
    Log    Performing search for vehicle type: ${vehicle_type}
    IF     '${vehicle_type}' == 'VAN'
        Log    Targeting van radio button: ${RBTN_VAN}
        Wait Until Element Is Visible    ${RBTN_VAN}    timeout=10s
        Click Element    ${RBTN_VAN}
    ELSE IF     '${vehicle_type}' == 'CAR'
        Log    Targeting car radio button: ${RBTN_CAR}
        Wait Until Element Is Visible    ${RBTN_CAR}    timeout=10s
        Click Element    ${RBTN_CAR}
    END
    Click Element    ${CHECK_DIFFERENT_RETURN}
    Set Location    ${PICKUP_OFFICE}    ${pickup_location}    pickup
    Set Location    ${DROPOFF_OFFICE}    ${dropoff_location}    dropoff
    Click Element    ${SEARCH_BUTTON}

Verify Search Results
    ${current_url}=    Get Location

    # Comprobamos si ha habido algun error en la busqueda
    ${contains_error}=    Run Keyword And Return Status    Should Contain    ${current_url}    errorType=ES999

    IF    ${contains_error}
        Should Contain    ${current_url}    errorType=ES999
    ELSE
        Should Contain    ${current_url}    resultados
        Wait Until Element Is Visible    ${RESULTS_HEADING}
        Element Should Contain    ${RESULTS_HEADING}    coches
    END

