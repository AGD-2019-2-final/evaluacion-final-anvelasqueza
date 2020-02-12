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
--fs -rm -f -r data.csv;
--fs -put data.csv;
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
u = LOAD 'data.csv' USING PigStorage(',')
    AS (f1:INT, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY, f6: INT);

substringdata = FOREACH u GENERATE SUBSTRING (f4, 0, 4);

words = FOREACH substringdata GENERATE FLATTEN(TOKENIZE($0)) AS word;

grouped = GROUP words BY word;

wordcount = FOREACH grouped GENERATE group, COUNT(words) as ld1: CHARARRAY;
    
wordcount2 = FOREACH wordcount GENERATE CONCAT(group, ',' , ld1);
STORE wordcount2 INTO './output' using PigStorage('\t');
