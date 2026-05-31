/* =======================================================================================
   
   Equipo: Los Normalizados
   Integrantes: 
   - Aguilar Lara Ericka
   - Bautista Reyes Sofía
   - Bermejo Flores José Tristán
   - Cruz Basilio Ximena Carolina
   - Jardón Marín Rodrigo
   - Parra Fernández Héctor Emilio
   
   Fecha de entrega: 30 de mayo de 2026
   
   =======================================================================================
   OBJETIVO DE LA CONSULTA:
   Identificar y listar los nombres de todos los productos (platillos o bebidas) 
   pertenecientes al menú del restaurante que actualmente se encuentran marcados 
   como "no disponibles" en el sistema. 
   
   Se utiliza la cláusula SELECT para proyectar el atributo 'nombre' con un alias 
   llamado como "producto_no_disponible". La consulta extrae los registros de 
   la relación 'producto' y aplica una restricción lógica en la cláusula WHERE 
   para evaluar el campo booleano 'disponibilidad' y filtrar únicamente los 
   valores equivalentes a FALSE.
   ======================================================================================= */

SELECT nombre AS producto_no_disponible 
FROM producto 
WHERE disponibilidad = FALSE;