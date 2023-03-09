
<form method="post" action="fileUpload.jsp" name="upform" enctype="multipart/form-data">
  <table width="90%" border="0" cellspacing="1" cellpadding="1" align="left" class="style1" >
    <tr>
      <td align="left">Select a file to upload :
        <input type="file" name="uploadfile" size="25" style="border:1px solid #666666;">
        
		<input type="hidden" name="todo" value="upload">
        <input type="submit" name="Submit" value="Upload">
        <input type="reset" name="Reset" value="Cancel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="get details">
        </td>
    </tr>
  </table>
</form>
 