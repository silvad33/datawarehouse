  CREATE PROCEDURE [mdr].[spUpdateD365Table] as
  UPDATE mdr.[DataEntityFields]
  SET D365Table=LEFT(Field_Binding,CHARINDEX('(',Field_Binding)-1)
  WHERE CHARINDEX('(',Field_Binding)-1>0
