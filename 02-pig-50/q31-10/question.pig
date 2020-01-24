-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Cuente la cantidad de personas nacidas por año.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
fs -rm -f -r data.csv;
fs -put data.csv;
-- 
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
v = FOREACH u GENERATE SUBSTRING(birthday,0,4)as i;
z = GROUP v BY i;
y = FOREACH z GENERATE group,COUNT(v);
--DUMP y;
STORE y INTO 'output' USING PigStorage(',');
fs -get output/ ;