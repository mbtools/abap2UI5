CLASS z2ui5_cl_app_demo_25 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    CLASS-METHODS factory
      IMPORTING
        i_app           TYPE REF TO z2ui5_if_app
        i_name_attri    TYPE string
      RETURNING
        VALUE(r_result) TYPE REF TO z2ui5_cl_app_demo_25.


    DATA mv_input TYPE string.
    DATA mv_input_previous TYPE string.
    DATA mv_input_previous_set TYPE string.

    DATA mo_app TYPE REF TO z2ui5_if_app.
    DATA mv_name_attri TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_APP_DEMO_25 IMPLEMENTATION.


  METHOD factory.

    r_result = NEW #( ).
    r_result->mo_app = i_app.
    r_result->mv_name_attri = i_name_attri.

  ENDMETHOD.


  METHOD z2ui5_if_app~controller.

    CASE client->get( )-lifecycle_method.

      WHEN client->cs-lifecycle_method-on_event.

        CASE client->get( )-event.

          WHEN 'BUTTON_ROUNDTRIP'.
            client->popup_message_box( 'server-client roundtrip, method on_event of the abap controller was called' ).

          WHEN 'BUTTON_RESTART'.
            client->nav_app_call( NEW z2ui5_cl_app_demo_25( ) ).

          WHEN 'BUTTON_CHANGE_APP'.
            client->nav_app_call( NEW z2ui5_cl_app_demo_01( ) ).

          WHEN 'BUTTON_READ_PREVIOUS'.
            DATA(lo_previous_app) = CAST z2ui5_cl_app_demo_24( client->get_app_by_id( client->get( )-id_prev_app ) ).
            mv_input_previous = lo_previous_app->mv_input2.
            client->popup_message_toast( `data of previous app read` ).

          WHEN 'NEW_APP_EVENT'.
            client->popup_message_box( 'new app called and event NEW_APP_EVENT raised' ).

          WHEN 'SHOW_VIEW_MAIN'.
            client->show_view( 'MAIN' ).

          WHEN 'BACK_WITH_EVENT'.
            client->nav_app_leave( client->get( )-id_prev_app_stack ).
            client->set( event = 'CALL_PREVIOUS_APP_INPUT_RETURN' ).

          WHEN 'BACK'.
            client->nav_app_leave( client->get( )-id_prev_app_stack ).

        ENDCASE.

      WHEN client->cs-lifecycle_method-on_rendering.

        DATA(page) = client->factory_view( 'MAIN'
            )->page(
                    title          = 'abap2UI5 - flow logic - APP 02'
                    navbuttonpress = client->_event( 'BACK' )
                )->header_content(
                    )->link( text = 'Demo'        href = `https://twitter.com/OblomovDev/status/1640743794206228480`
                    )->link( text = 'Source_Code' href = client->get( )-s_request-url_source_code
                )->get_parent( ).

        page->grid( 'L6 M12 S12' )->content( 'l'

              )->simple_form( 'View: FIRST' )->content( 'f'

               )->label( 'Input set by previous app'
               )->input( mv_input_previous_set

               )->label( 'Data of previous app'
               )->input( mv_input_previous
               )->button( text = 'read' press = client->_event( 'BUTTON_READ_PREVIOUS' )

               )->label( 'Call previous app and show data of this app'
               )->input( client->_bind( mv_input )
               )->button( text = 'back' press = client->_event( 'BACK_WITH_EVENT' ) ).

        page = client->factory_view( 'SECOND'
            )->page(
                    title          = 'abap2UI5 - flow logic - APP 02'
                    navbuttonpress = client->_event( 'BACK' )
                )->header_content(
                    )->link( text = 'Demo'        href = `https://twitter.com/OblomovDev/status/1640743794206228480`
                    )->link( text = 'Source_Code' href = client->get( )-s_request-url_source_code
                )->get_parent( ).

        page->grid( 'L6 M12 S12' )->content( 'l'
            )->simple_form( 'View: SECOND' )->content( 'f'
              )->label( 'Demo'
              )->button( text = 'leave to previous app' press = client->_event( 'BACK' )
              )->label( 'Demo'
              )->button( text = 'show view main' press = client->_event( 'SHOW_VIEW_MAIN' ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
