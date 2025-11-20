**FREE
// Programa: HOLAMUNDO
// Descripción: Programa simple que muestra un mensaje "Hola Mundo"

Ctl-Opt DftActGrp(*No) ActGrp(*New);

Dcl-S Mensaje Char(50);

// Asignar el mensaje
Mensaje = 'Hola Mundo';

// Mostrar el mensaje en la consola
Dsply Mensaje;

*InLr = *On;
Return;
