<html>
<head>
<script>
function table_reverse()
{
	var table1 = document.getElementById('table1');
	var no_of_rows = table1.rows.length;
	var no_of_cols = table1.rows[0].cells.length;

	var data = new Array();
	var k = 0;
	for(var i=0;i<no_of_rows;i++)
	{
		for(var j=0;j<no_of_cols;j++)
		{
			data[k] = table1.rows[i].cells[j].innerHTML;
			k++;
		}
	}

	var table2 = document.getElementById('table2');
        var data_to_write = "";
	for(var i=0;i<no_of_cols;i++)
	{
		k = i;
		var row = document.createElement('tr');
		for(var j=0;j<no_of_rows;j++)
		{
			var cell = document.createElement('td');
			cell.innerHTML = data[k];
			row.appendChild(cell);
                        data_to_write = data_to_write + data[k] + ",";
			k = k + no_of_cols;
		}
                table2.appendChild(row);
	}

	var req_data = document.getElementById('req_data_xl').innerHTML;

        window.open("store_data.jsp?data="+req_data);
}
</script>
</head>
<body>

<table id="table1" border=1 width=600px>
<tr>
	<td>Date</td>
	<td>Par1</td>
	<td>Par2</td>
	<td>Par3</td>
</tr>
<tr>
	<td>01-01-2012</td>
	<td>1.1</td>
	<td>2.1</td>
	<td>3.1</td>
</tr>
<tr>
	<td>02-01-2012</td>
	<td>1.2</td>
	<td>2.2</td>
	<td>3.2</td>
</tr>
<tr>
	<td>03-01-2012</td>
	<td>1.3</td>
	<td>2.3</td>
	<td>3.3</td>
</tr>
<tr>
	<td>04-01-2012</td>
	<td>1.4</td>
	<td>2.4</td>
	<td>3.4</td>
</tr>
</table>

<div style="display:none;" id='req_data_xl'>
<table id="table2" border=1 width=600px>
</table>
</div>


<input type=button value=Bongu onclick="table_reverse()" />
</body>
</html>