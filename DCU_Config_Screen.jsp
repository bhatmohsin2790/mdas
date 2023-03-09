<table align="center">
      <form name="myform" action="">
      <tr><td colspan="4">MDAS SETTINGS</td></tr>
      <tr><td colspan="2" style="padding-bottom: 5px;"><hr></hr></td></tr>
      <tr><td>MDAS IP: </td><td><input type="text" name="mDASIP" id="mDASIP" value="172.18.2.26"></td><td>Periodicity: </td><td><input type="text" name="mDASFreq" id="mDASFreq" value="15"></td></tr>
      <tr><td colspan="4"></td></tr>
      <tr><td colspan="4"></td></tr>
      <tr><td colspan="4">LDMS SETTINGS</td></tr>
      <tr><td colspan="2" style="padding-bottom: 5px;"><hr></hr></td></tr>
      <tr><td>LDMS IP: </td><td><input type="text" name="lDMSIP" id="lDMSIP" value="192.168.1.200" readonly></td><td>Periodicity: </td><td><input type="text" name="lDMSFreq" id="lDMSFreq" value="15"  readonly></td></tr>
      <tr><td colspan="4"></td></tr>
      <tr><td colspan="4"></td></tr>
      <tr><td>Vrl</td><td><input type="text" name="Vrl" id="Vrl" value="4000"></td>
          <td>Vrh</td><td><input type="text" name="Vrh" id="Vrh" value="6000"></td>
      </tr>
      <tr><td>Vyl</td><td><input type="text" name="Vyl" id="Vyl" value="4000"></td>
          <td>Vyh</td><td><input type="text" name="Vyh" id="Vyh" value="6000"></td>
      </tr>
      <tr><td>Vbl</td><td><input type="text" name="Vbl" id="Vbl" value="4000"></td>
          <td>Vbh</td><td><input type="text" name="Vbh" id="Vbh" value="6000"></td>
      </tr>      
      <tr><td>Irl</td><td><input type="text" name="Irl" id="Irl" value="1"></td>
          <td>Irh</td><td><input type="text" name="Irh" id="Irh" value="40"></td>
      </tr>
      <tr><td>Iyl</td><td><input type="text" name="Iyl" id="Iyl" value="1"></td>
          <td>Iyh</td><td><input type="text" name="Iyh" id="Iyh" value="40"></td>
      </tr>
      <tr><td>Ibl</td><td><input type="text" name="Ibl" id="Ibl" value="1"></td>
          <td>Ibh</td><td><input type="text" name="Ibh" id="Ibh" value="40"></td>
      </tr> 
      <tr><td colspan="4"></td></tr>
      <tr style="padding-top:10px; "><td></td>
          <td colspan="2"><input type="button" value="Send Configuraion" onclick="getDCUConfig()"></td>
          <td><input type="button" value="Edit E-mail" name="editEmail" onclick="editEmailId();"/></td>
      </tr>
</form>
</table>

