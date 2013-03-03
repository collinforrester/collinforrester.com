/* Author: Collin Forrester */

// Small script to change the active tab at the top
var url = window.location.pathname;
$( '.nav' ).children().removeClass( 'active' );
$( '.nav' ).find( 'a[href$="' + url + '"]' ).parent().addClass( 'active' );


