CLASS z2ui5_cl_app_demo_05 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA:
      BEGIN OF screen,
        check_initialized TYPE abap_bool,
        check_is_active   TYPE abap_bool,
        colour            TYPE string,
        combo_key         TYPE string,
        segment_key       TYPE string,
        date              TYPE string,
        date_time         TYPE string,
        time_start        TYPE string,
        time_end          TYPE string,
        check_switch_01   TYPE abap_bool VALUE abap_false,
        check_switch_02   TYPE abap_bool VALUE abap_false,
        progress_value    TYPE string VALUE '3',
        step_val_01       TYPE string VALUE '4',
        step_val_02       TYPE string VALUE '10',
        text_area         TYPE string,
      END OF screen.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_APP_DEMO_05 IMPLEMENTATION.


  METHOD z2ui5_if_app~controller.

    CASE client->get( )-lifecycle_method.

      WHEN client->cs-lifecycle_method-on_event.

        IF screen-check_initialized = abap_false.
          screen-check_initialized = abap_true.

          screen = VALUE #(
             check_initialized = abap_true
             check_is_active   = abap_true
             colour            = 'BLUE'
             combo_key         = 'GRAY'
             segment_key       = 'GREEN'
             date              = '07.12.22'
             date_time         = '23.12.2022, 19:27:20'
             time_start        = '05:24:00'
             time_end          = '17:23:57' ).

          RETURN.
        ENDIF.


        CASE client->get( )-event.

          WHEN 'BUTTON_ROUNDTRIP'.
            DATA(lv_dummy) = 'user pressed a button, your custom implementation can be called here'.

          WHEN 'BUTTON_MSG_BOX'.
            client->popup_message_box(
              text = 'this is a message box with a custom text'
              type = 'success' ).

          WHEN 'BACK'.
            client->nav_app_leave( client->get( )-id_prev_app_stack ).

        ENDCASE.


      WHEN client->cs-lifecycle_method-on_rendering.

        DATA(page) = client->factory_view(
            )->page(
                title          = 'abap2UI5 - Selection-Screen more Controls'
                navbuttonpress = client->_event( 'BACK' )
                class = `class="sapUiContentPadding sapUiResponsivePadding--header sapUiResponsivePadding--subHeader sapUiResponsivePadding--content sapUiResponsivePadding--footer"`
                )->header_content(
                    )->link(
                        text = 'Source_Code'
                        href = client->get( )-s_request-url_source_code
                )->get_parent( ).

        page->generic_tag(
            arialabelledby = 'genericTagLabel'
            text           = 'Project Cost'
            design         = 'StatusIconHidden'
            status         = 'Error'
            class          = 'sapUiSmallMarginBottom'
            )->object_number(
                state      = 'Error'
                emphasized = 'false'
                number     = '3.5M'
                unit       = 'EUR' ).

        page->generic_tag(
            arialabelledby = 'genericTagLabel'
            text           = 'Project Cost'
            design         = 'StatusIconHidden'
            status         = 'Success'
            class          = 'sapUiSmallMarginBottom'
            )->object_number(
                state      = 'Success'
                emphasized = 'false'
                number     = '3.5M'
                unit       = 'EUR' ).

        page->generic_tag(
            arialabelledby = 'genericTagLabel'
            text           = 'Input'
            design         = 'StatusIconHidden'
            class          = 'sapUiSmallMarginBottom'
            )->object_number(
                emphasized = 'true'
                number     = '3.5M'
                unit       = 'EUR' ).

        DATA(grid) = page->grid( 'L12 M12 S12' )->content( 'l' ).

        grid->simple_form( 'More Controls' )->content( 'f'
            )->label( 'ProgressIndicator'
            )->progress_indicator(
                percentvalue    = screen-progress_value
                displayvalue    = '0,44GB of 32GB used'
                showvalue       = abap_true
                state           = 'Success'
            )->label( 'StepInput'
            )->step_input(
                value = client->_bind( screen-step_val_01 )
                step = '2'
                min = '0'
                max = '20'
            )->step_input(
                value = client->_bind( screen-step_val_02 )
                step = '10'
                min = '0'
                max = '100'
            )->label( 'Range Slider'
            )->range_slider(
                max           = '100'
                min           = '0'
                step          = '10'
                startvalue    = '10'
                endvalue      = '20'
                showtickmarks = abap_true
                labelinterval = '2'
                width         = '80%'
                class         = 'sapUiTinyMargin' ).

        grid->simple_form( 'Text Area' )->content( 'f'
            )->label( 'text area'
            )->text_area(
                value = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magn` &&
                    `a aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd` &&
                ` gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam n ` &&
                  `  onumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit am ` &&
                  `  et, consetetur sadipscing elitr, sed diam nonumy eirm sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam no ` &&
                        `numy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`
                growing = abap_true
                growingmaxlines = '7'
                width = '100%' ).

        page->footer(
            )->overflow_toolbar(
                )->button(
                    text  = 'Button with Badge'
                    class = 'sapUiTinyMarginBeginEnd'
                    icon  = 'sap-icon://cart' )->get(
                    )->custom_data(
                        )->badge_custom_data(
                            key     = 'badge'
                            value   = '5'
                            visible = abap_true
                )->get_parent( )->get_parent(
                )->button(
                    text    = 'Emphasized Button with Badge'
                    type    = 'Emphasized'
                    class   = 'sapUiTinyMarginBeginEnd'
                    icon    = 'sap-icon://cart' )->get(
                    )->custom_data(
                        )->badge_custom_data(
                            key     = 'badge'
                            value   = '23'
                            visible = abap_true
                )->get_parent( )->get_parent(
                )->toolbar_spacer(
                )->overflow_toolbar_button(
                    text  = 'Clear'
                    press = client->_event( 'BUTTON_CLEAR' )
                    type  = 'Reject'
                    icon  = 'sap-icon://delete'
                )->overflow_toolbar_button(
                    text  = 'Send to Server'
                    press = client->_event( 'BUTTON_SEND' )
                    type  = 'Success' ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
