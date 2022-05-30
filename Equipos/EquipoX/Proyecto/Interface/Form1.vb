Option Explicit On
'Option Strict On

Imports Npgsql
Imports System.D

Public Class Form1
    Private ID As String = ""
    Private intRow As Integer = 0
    Dim idestado As Integer = -1

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        LoadEstados()
        LoadClients()
        LoadPlatillos()
        LoadExistentClients()
    End Sub

    Private Sub InsertaCliente(MySQL As String, Optional Parameter As String = "")
        Cmd = New NpgsqlCommand(MySQL, Con)
        AddParametersInsertClient(Parameter)
        PerformCRUD(Cmd)
    End Sub

    Private Sub AddParametersInsertClient(str As String)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("rfc", txtRFC.Text.Trim())
        Cmd.Parameters.AddWithValue("nombre", txtNombre.Text.Trim())
        Cmd.Parameters.AddWithValue("apPat", txtApPat.Text.Trim())
        Cmd.Parameters.AddWithValue("apMat", txtApMat.Text.Trim())
        Cmd.Parameters.AddWithValue("RS", txtRS.Text.Trim())
        Cmd.Parameters.AddWithValue("email", txtEmail.Text.Trim())
        Cmd.Parameters.AddWithValue("CP", CInt(txtCP.Text.Trim()))
        Cmd.Parameters.AddWithValue("colonia", txtColonia.Text.Trim())
        Cmd.Parameters.AddWithValue("calle", txtCalle.Text.Trim())
        Cmd.Parameters.AddWithValue("numero", CInt(txtNumero.Text.Trim()))
        Cmd.Parameters.AddWithValue("idEdo", idestado)
    End Sub

    Private Sub LoadEstados(Optional keyword As String = "")
        SQL = "SELECT * FROM CATALOGO_ESTADOS"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvEstado
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
        End With
    End Sub

    Private Sub LoadClients(Optional keyword As String = "")
        SQL = "SELECT * FROM cliente_orden;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvClient
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(1).Width = 200
        End With
    End Sub
    Private Sub LoadExistentClients(Optional keyword As String = "")
        SQL = "SELECT * FROM cliente;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvConsulta
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(1).Width = 200
        End With
    End Sub

    Private Sub LoadPlatillos(Optional keyword As String = "")
        SQL = "SELECT id_pb AS id,nombre_pb AS nombre,precio,descripcion,receta FROM PRODUCTO WHERE es_platillo=true;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvProduct
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
        End With
    End Sub

    Private Sub LoadBebidas(Optional keyword As String = "")
        SQL = "SELECT id_pb AS id,nombre_pb AS nombre,precio,descripcion,receta FROM PRODUCTO WHERE es_bebida=true;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvProduct
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
        End With
    End Sub

    Private Sub LoadEmployee(Optional keyword As String = "")
        SQL = "SELECT EMPLEADO.num_empleado AS N_E, EMPLEADO.nombre||' '||EMPLEADO.ap_paterno||' '||EMPLEADO.ap_materno AS nombre, EMPLEADO.rfc_emp AS rfc
               FROM MESERO INNER JOIN EMPLEADO USING(rfc_emp);"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvSelectEmployee
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
        End With
    End Sub

    Private Sub LoadEmpleados(Optional keyword As String = "")
        SQL = "SELECT EMPLEADO.num_empleado AS N_E, EMPLEADO.nombre||' '||EMPLEADO.ap_paterno||' '||EMPLEADO.ap_materno AS nombre, EMPLEADO.rfc_emp AS rfc
               FROM EMPLEADO;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvSelectEmployee
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
        End With
    End Sub

    Private Sub LoadPMV(Optional keyword As String = "")
        SQL = "SELECT id_pb AS ID, nombre_pb AS Platillo, precio, descripcion  FROM PLATILLO_MAS_VENDIDO;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvPMasVendido
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(2).Visible = False
        End With
    End Sub

    Private Sub LoadBMV(Optional keyword As String = "")
        SQL = "SELECT id_pb AS ID, nombre_pb AS Bebida, precio, descripcion FROM BEBIDA_MAS_VENDIDA;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvBMasVendida
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(2).Visible = False
        End With
    End Sub

    Private Sub LoadPND(Optional keyword As String = "")
        SQL = "SELECT id_pb, nombre_pb FROM PRODUCTO WHERE disponibilidad IS FALSE;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvProdNoDisponibles
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
        End With
    End Sub

    Private Sub LoadClientsCC(Optional keyword As String = "")
        SQL = "SELECT * FROM cliente_orden;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvCierraCuenta
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(1).Width = 200
        End With
    End Sub

    Private Sub LoadFactura(Optional keyword As String = "")
        SQL = "SELECT * FROM FACTURA WHERE rfc_cliente=@rfc and descripcion like '%" & dgvCierraCuenta.CurrentRow.Cells(0).Value.ToString.Trim() & "%';"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("keyword", strKeyword)
        Cmd.Parameters.AddWithValue("rfc", dgvCierraCuenta.CurrentRow.Cells(2).Value.ToString.Trim())
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvFactura
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
        End With
    End Sub

    Private Sub LoadVPE(Optional keyword As String = "")
        SQL = "SELECT COUNT(folio) AS cantidad_de_ordenes_generadas, SUM(total_orden) FROM ORDEN
        WHERE rfc_emp = cantidad_ordenes_mesero(@num_empleado) AND fecha = CURRENT_DATE;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("num_empleado", CInt(dgvSelectEmployee.CurrentRow.Cells(0).Value.ToString.Trim()))
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvVPE
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(1).Width = 200
        End With
    End Sub

    Private Sub LoadVPF(Optional keyword As String = "")
        SQL = "SELECT id_pb AS id, PRODUCTO.nombre_pb AS PRODUCTO, sum(total_X_produc) AS TOTAL
               FROM CONTENIDO_ORDEN INNER JOIN ORDEN using(folio) INNER JOIN PRODUCTO using (id_pb)
               WHERE ORDEN.fecha BETWEEN CAST(@inicio AS DATE) AND CAST(@final AS DATE) GROUP BY id_pb, PRODUCTO.nombre_pb;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("inicio", Format(dtpInicio.Value, "yyyy-MM-dd"))
        Cmd.Parameters.AddWithValue("final", Format(dtpFinal.Value, "yyyy-MM-dd"))
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvBuscaFecha
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
            .Columns(0).Width = 80
            .Columns(1).Width = 200
        End With
    End Sub

    Private Sub LoadEmployeeData(Optional keyword As String = "")
        SQL = "SELECT EMPLEADO.rfc_emp AS RFC, EMPLEADO.num_empleado, EMPLEADO.nombre||' '||EMPLEADO.ap_paterno||' '||EMPLEADO.ap_materno AS Nombre, EMPLEADO.edad,
               EMPLEADO.fecha_nac, EMPLEADO.sueldo, EMPLEADO.calle, EMPLEADO.numero, EMPLEADO.colonia, EMPLEADO.cp, CATALOGO_ESTADOS.nombre_estado AS Estado,
               EMPLEADO.foto
               FROM EMPLEADO INNER JOIN CATALOGO_ESTADOS using(id_estado)
               WHERE EMPLEADO.rfc_emp = @rfc;"
        Dim strKeyword As String = String.Format("%{0}%", keyword)
        Cmd = New NpgsqlCommand(SQL, Con)
        Cmd.Parameters.Clear()
        Cmd.Parameters.AddWithValue("rfc", dgvSelectEmployee.CurrentRow.Cells(2).Value.ToString.Trim())
        Dim dt As DataTable = PerformCRUD(Cmd)
        If dt.Rows.Count > 0 Then
            intRow = Convert.ToInt32(dt.Rows.Count.ToString())
        Else
            intRow = 0
        End If
        ToolStripStatusLabel1.Text = "Number of rows:" & intRow.ToString()
        With dgvEmployee
            .MultiSelect = False
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .AutoGenerateColumns = True
            .DataSource = dt
        End With
    End Sub

    Private Sub rdbCliente_CheckedChanged(sender As Object, e As EventArgs) Handles rdbCliente.CheckedChanged
        If rdbCliente.Checked Then
            grpCliente.Visible = True
            LoadEstados()
        Else
            grpCliente.Visible = False
        End If
    End Sub

    Private Sub dgvEstado_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgvEstado.CellContentClick
        idestado = CInt(dgvEstado.CurrentRow.Cells(0).Value)
        txtEstado.Text = dgvEstado.CurrentRow.Cells(1).Value.ToString()
    End Sub

    Private Sub dgvEstado_CellEnter(sender As Object, e As DataGridViewCellEventArgs) Handles dgvEstado.CellEnter
        idestado = CInt(dgvEstado.CurrentRow.Cells(0).Value)
        txtEstado.Text = dgvEstado.CurrentRow.Cells(1).Value.ToString()
    End Sub

    Private Sub btnInsertClient_Click(sender As Object, e As EventArgs) Handles btnInsertClient.Click
        Dim i As Integer
        If txtNombre.Text = Nothing Then
            MsgBox("Ingrese el nombre del cliente", MsgBoxStyle.Exclamation, Title:="Información personal incompleta")
        ElseIf txtApPat.Text = Nothing Then
            MsgBox("Ingrese el apellido paterno del cliente", MsgBoxStyle.Exclamation, Title:="Información personal incompleta")
        ElseIf txtEmail.Text = Nothing Then
            MsgBox("Ingrese el correo electrónico del cliente", MsgBoxStyle.Exclamation, Title:="Información personal incompleta")
        ElseIf txtRS.Text = Nothing Then
            MsgBox("Ingrese la razón social del cliente", MsgBoxStyle.Exclamation, Title:="Información legal incompleta")
        ElseIf txtRFC.Text = Nothing Then
            MsgBox("Ingrese el RFC del cliente", MsgBoxStyle.Exclamation, Title:="Información legal incompleta")
        ElseIf txtCalle.Text = Nothing Then
            MsgBox("Ingrese la Calle del domicilio", MsgBoxStyle.Exclamation, Title:="Domicilio incompleto")
        ElseIf txtNumero.Text = Nothing Then
            MsgBox("Ingrese el Número del domicilio", MsgBoxStyle.Exclamation, Title:="Domicilio incompleto")
        ElseIf txtColonia.Text = Nothing Then
            MsgBox("Ingrese la Colonia del domicilio", MsgBoxStyle.Exclamation, Title:="Domicilio incompleto")
        ElseIf txtCP.Text = Nothing Then
            MsgBox("Ingrese el código postal del domicilio", MsgBoxStyle.Exclamation, Title:="Domicilio incompleto")
        ElseIf idestado = -1 Then
            MsgBox("Seleccione el Estado del domicilio", MsgBoxStyle.Exclamation, Title:="Domicilio incompleto")
        ElseIf MsgBox("¿Confirma que los datos son correctos?" & vbNewLine & "Cliente: " & txtNombre.Text & " " &
                   txtApPat.Text & " " & txtApMat.Text & vbNewLine & "Correo electrónico: " & txtEmail.Text &
                   vbNewLine & "Razón social: " & txtRS.Text & vbNewLine & "RFC: " & txtRFC.Text & vbNewLine &
                   "Domicilio: " & txtCalle.Text & " " & txtNumero.Text & ", " & txtColonia.Text &
                   ", " & txtCP.Text & ", " & txtEstado.Text, MsgBoxStyle.YesNo, Title:="Confirme datos") = MsgBoxResult.Yes Then
            For i = 0 To dgvConsulta.RowCount - 1
                MsgBox(i)
                If dgvConsulta.Rows(i).Cells(0).Value.ToString = txtRFC.Text Then
                    MsgBox("Este cliente ya nos ha visitado", Title:="Cliente frecuente")
                    i = dgvConsulta.RowCount
                ElseIf (i = dgvConsulta.RowCount - 1) Then
                    SQL = "INSERT INTO CLIENTE(rfc_cliente,nombre,ap_paterno,ap_materno,razon_social,email,cp,colonia,calle,numero,id_estado)
                        VALUES (@rfc,@nombre,@apPat,@apMat,@RS,@email,@CP,@colonia,@calle,@numero,@idEdo);"
                    If Con.State = ConnectionState.Closed Then
                        Con.Open()
                    End If
                    InsertaCliente(SQL, "Insert") 'Registramos al cliente
                End If
            Next
            Try
                If Con.State = ConnectionState.Closed Then
                    Con.Open()
                End If
                SQL = "SELECT cliente_genera_orden(@fecha, @rfc);"
                Cmd = New NpgsqlCommand(SQL, Con)
                Cmd.Parameters.Clear()
                Cmd.CommandType = CommandType.Text
                Cmd.Parameters.AddWithValue("fecha", Format(Today, "yyyy,MM,dd"))
                Cmd.Parameters.AddWithValue("rfc", txtRFC.Text.Trim())
                Cmd.ExecuteNonQuery()
                Con.Close()
                MsgBox("El cliente se ha registrado con éxito y se le abrió una cuenta", MsgBoxStyle.Information And MsgBoxStyle.OkOnly, Title:="Registro exitoso")
            Catch ex As Exception
                MsgBox("Hubo un error al registrar al cliente" & vbNewLine & ex.Message & SQL, MsgBoxStyle.Critical, Title:="Error")
            End Try
            ClrClient()
            rdbAddProduct.Checked = True
        End If
    End Sub

    Private Sub ClrClient()
        txtNombre.Text = Nothing
        txtApPat.Text = Nothing
        txtApMat.Text = Nothing
        txtEmail.Text = Nothing
        txtRS.Text = Nothing
        txtRFC.Text = Nothing
        txtCalle.Text = Nothing
        txtNumero.Text = Nothing
        txtColonia.Text = Nothing
        txtCP.Text = Nothing
        LoadEstados()
        txtEstado.Text = Nothing
        idestado = -1
    End Sub

    Private Sub txtEmail_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtEmail.KeyPress
        Try
            If (Asc(e.KeyChar)) = 32 Then
                e.KeyChar = CChar(vbNullChar)
            End If
        Catch ex As Exception
            MsgBox("Caracter inválido")
        End Try
    End Sub

    Private Sub btnClrClient_Click(sender As Object, e As EventArgs) Handles btnClrClient.Click
        ClrClient()
    End Sub

    Private Sub txtCP_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtCP.KeyPress
        If Asc(e.KeyChar) < 48 Or Asc(e.KeyChar) > 57 Then
            If Not Asc(e.KeyChar) = 8 Then
                e.KeyChar = CChar(vbNullChar)
            End If
        End If
    End Sub

    Private Sub rdbAddProduct_CheckedChanged(sender As Object, e As EventArgs) Handles rdbAddProduct.CheckedChanged
        If rdbAddProduct.Checked Then
            grpProductos.Visible = True
            LoadClients()
            rdbPlatillo.Checked = True
            If dgvClient.RowCount = 0 Then
                btnAddProduct.Enabled = False
            Else
                btnAddProduct.Enabled = True
            End If
        Else
            grpProductos.Visible = False
        End If
    End Sub

    Private Sub rdbPlatillo_CheckedChanged(sender As Object, e As EventArgs) Handles rdbPlatillo.CheckedChanged
        If rdbPlatillo.Checked Then
            LoadPlatillos()
        End If
    End Sub

    Private Sub rdbBebida_CheckedChanged(sender As Object, e As EventArgs) Handles rdbBebida.CheckedChanged
        If rdbBebida.Checked Then
            LoadBebidas()
        End If
    End Sub

    Private Sub btnAddProduct_Click(sender As Object, e As EventArgs) Handles btnAddProduct.Click

        If MsgBox("¿Está seguro de agregar " & cboCantidad.SelectedItem.ToString & " " & dgvProduct.CurrentRow.Cells(1).Value.ToString &
               " a la cuenta " & dgvClient.CurrentRow.Cells(0).Value.ToString & "?", MsgBoxStyle.YesNo,
               Title:="Confirme datos") = MsgBoxResult.Yes Then
            If Con.State = ConnectionState.Closed Then
                Con.Open()
            End If
            SQL = "SELECT agrega_productos(@folio, @id, @cantidad);"
            Cmd = New NpgsqlCommand(SQL, Con)
            Cmd.Parameters.Clear()
            Cmd.CommandType = CommandType.Text
            Cmd.Parameters.AddWithValue("folio", dgvClient.CurrentRow.Cells(0).Value.ToString.Trim())
            Cmd.Parameters.AddWithValue("id", CInt(dgvProduct.CurrentRow.Cells(0).Value.ToString.Trim()))
            Cmd.Parameters.AddWithValue("cantidad", CInt(cboCantidad.SelectedItem.ToString.Trim()))
            Cmd.ExecuteNonQuery()
            Con.Close()
            MsgBox("Producto agregado con éxito", MsgBoxStyle.OkOnly And MsgBoxStyle.MsgBoxRight)
        End If
    End Sub

    Private Sub rdbEmpleado_CheckedChanged(sender As Object, e As EventArgs) Handles rdbConsultas.CheckedChanged
        If rdbConsultas.Checked Then
            grpEmpleado.Visible = True
        Else
            grpEmpleado.Visible = False
        End If
    End Sub

    Private Sub rdbOrdenesXEmpleado_CheckedChanged(sender As Object, e As EventArgs) Handles rdbOrdenesXEmpleado.CheckedChanged
        If rdbOrdenesXEmpleado.Checked Then
            LoadEmployee()
            lblSelectEmployee.Visible = True
            btnBuscar.Visible = True
            dgvSelectEmployee.Visible = True
            txtSelectedEmployee.Visible = True
        Else
            lblSelectEmployee.Visible = False
            btnBuscar.Visible = False
            dgvSelectEmployee.Visible = False
            txtSelectedEmployee.Visible = False
            dgvVPE.Visible = False
        End If
    End Sub

    Private Sub btnPBMasVendidos_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub rdbPBMasVendidos_CheckedChanged(sender As Object, e As EventArgs) Handles rdbPBMasVendidos.CheckedChanged
        If rdbPBMasVendidos.Checked Then
            dgvPMasVendido.Visible = True
            dgvBMasVendida.Visible = True
            LoadPMV()
            LoadBMV()
        Else
            dgvPMasVendido.Visible = False
            dgvBMasVendida.Visible = False
        End If
    End Sub

    Private Sub rdbProdNoDisponibles_CheckedChanged(sender As Object, e As EventArgs) Handles rdbProdNoDisponibles.CheckedChanged
        If rdbProdNoDisponibles.Checked Then
            dgvProdNoDisponibles.Visible = True
            LoadPND()
            If dgvProdNoDisponibles.RowCount = 0 Then
                Beep()
                MsgBox("Tenemos todos los productos disponibles", MsgBoxStyle.Information And MsgBoxStyle.OkOnly, Title:="Disponibilidad de productos")
            End If
        Else
            dgvProdNoDisponibles.Visible = False
        End If
    End Sub

    Private Sub rdbFactura_CheckedChanged(sender As Object, e As EventArgs) Handles rdbFactura.CheckedChanged
        If rdbFactura.Checked Then
            LoadClientsCC()
            grpCerrarFacturar.Visible = True
            If dgvCierraCuenta.RowCount = 0 Then
                btnCF.Enabled = False
            Else
                btnCF.Enabled = True
            End If
        Else
            rtxtFactura.Text = Nothing
            grpCerrarFacturar.Visible = False
        End If
    End Sub

    Private Sub dgvCierraCuenta_CellClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgvCierraCuenta.CellClick
        btnCF.visible = True
    End Sub

    Private Sub btnCF_Click(sender As Object, e As EventArgs) Handles btnCF.Click
        Dim factura As String = ""
        If MsgBox("¿Está seguro de cerrar la cuenta con folio " & dgvCierraCuenta.CurrentRow.Cells(0).Value.ToString, MsgBoxStyle.YesNo) = MsgBoxResult.Yes Then
            LoadFactura()
            factura = factura + vbNewLine + dgvFactura.CurrentRow.Cells(0).Value.ToString + vbNewLine + "    " + dgvFactura.CurrentRow.Cells(2).Value.ToString + vbNewLine +
                      "    LUGAR Y FECHA DE EMISIÓN: " + dgvFactura.CurrentRow.Cells(3).Value.ToString + vbNewLine + vbNewLine + "CLIENTE" + vbNewLine + "    RFC: " +
                      dgvFactura.CurrentRow.Cells(4).Value.ToString + vbNewLine + "    NOMBRE: " + dgvFactura.CurrentRow.Cells(5).Value.ToString + vbNewLine +
                      "    CORREO ELECTRONICO: " + dgvFactura.CurrentRow.Cells(8).Value.ToString + vbNewLine + "    RAZON SOCIAL: " + dgvFactura.CurrentRow.Cells(6).Value.ToString +
                      vbNewLine + "    USO DE CDFI: " + dgvFactura.CurrentRow.Cells(9).Value.ToString + vbNewLine + vbNewLine + "CANTIDAD: " +
                      dgvFactura.CurrentRow.Cells(10).Value.ToString + vbNewLine + "DESCRIPCION: " + dgvFactura.CurrentRow.Cells(11).Value.ToString + vbNewLine + "IMPORTE: $" +
                      dgvFactura.CurrentRow.Cells(12).Value.ToString + vbNewLine + vbNewLine + "FORMA DE PAGO: " + dgvFactura.CurrentRow.Cells(13).Value.ToString + vbNewLine +
                      "METODO DE PAGO: " + dgvFactura.CurrentRow.Cells(14).Value.ToString + vbNewLine + "CONDICIONES DE PAGO: " + dgvFactura.CurrentRow.Cells(15).Value.ToString
            rtxtFactura.Text = factura
            chkFactura.Checked = True
            System.IO.File.WriteAllText("C:\Users\Miguel Galán\Desktop\FI_UNAM\Semestre_6.2022-2\Bases de Datos\Tareas\Proyecto\Facturas\Factura" +
                                        dgvFactura.CurrentRow.Cells(4).Value.ToString + dgvCierraCuenta.CurrentRow.Cells(0).Value.ToString + ".txt", factura)
            SQL = "UPDATE ORDEN SET status = @status where folio = @folio"
            Cmd = New NpgsqlCommand(SQL, Con)
            Cmd.Parameters.Clear()
            Cmd.Parameters.AddWithValue("status", False)
            Cmd.Parameters.AddWithValue("folio", dgvCierraCuenta.CurrentRow.Cells(0).Value.ToString.Trim())
            PerformCRUD(Cmd)
            MsgBox("La cuenta se cerró exitosamente")
            LoadClients()
        End If
    End Sub

    Private Sub chkFactura_CheckedChanged(sender As Object, e As EventArgs) Handles chkFactura.CheckedChanged
        If chkFactura.Checked Then
            rtxtFactura.Visible = True
        Else
            rtxtFactura.Visible = False
        End If
    End Sub

    Private Sub dgvSelectEmployee_CellClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgvSelectEmployee.CellClick
        txtSelectedEmployee.Text = "Número de empleado: " + dgvSelectEmployee.CurrentRow.Cells(0).Value.ToString
    End Sub

    Private Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        If rdbEmpleado.Checked Then
            LoadEmployeeData()
            dgvEmployee.Visible = True
            pcbEmpleado.Image = Image.FromFile(dgvEmployee.CurrentRow.Cells(11).Value.ToString.Trim())
            pcbEmpleado.Visible = True
        Else
            LoadVPE()
            dgvVPE.Visible = True
        End If
    End Sub

    Private Sub dgvSelectEmployee_CellEnter(sender As Object, e As DataGridViewCellEventArgs) Handles dgvSelectEmployee.CellEnter
        txtSelectedEmployee.Text = "Número de empleado: " + dgvSelectEmployee.CurrentRow.Cells(0).Value.ToString
    End Sub

    Private Sub Button5_Click(sender As Object, e As EventArgs) Handles btnBuscaFecha.Click
        LoadVPF()
    End Sub

    Private Sub rdbBuscaFecha_CheckedChanged(sender As Object, e As EventArgs) Handles rdbBuscaFecha.CheckedChanged
        If rdbBuscaFecha.Checked Then
            lblInstrucciones.Visible = True
            dtpInicio.Visible = True
            dtpFinal.Visible = True
            btnBuscaFecha.Visible = True
            dgvBuscaFecha.Visible = True
        Else
            lblInstrucciones.Visible = False
            dtpInicio.Visible = False
            dtpFinal.Visible = False
            btnBuscaFecha.Visible = False
            dgvBuscaFecha.Visible = False
        End If
    End Sub

    Private Sub rdbEmpleado_CheckedChanged_1(sender As Object, e As EventArgs) Handles rdbEmpleado.CheckedChanged
        If rdbEmpleado.Checked Then
            LoadEmpleados()
            lblSelectEmployee.Visible = True
            dgvSelectEmployee.Visible = True
            txtSelectedEmployee.Visible = True
            btnBuscar.Visible = True
        Else
            lblSelectEmployee.Visible = False
            dgvSelectEmployee.Visible = False
            txtSelectedEmployee.Visible = False
            btnBuscar.Visible = False
            dgvEmployee.Visible = False
            pcbEmpleado.Visible = False
        End If
    End Sub

    Private Sub chkExistentes_CheckedChanged(sender As Object, e As EventArgs) Handles chkExistentes.CheckedChanged
        If chkExistentes.Checked Then
            LoadExistentClients()
            dgvConsulta.Visible = True
            btnExistente.Visible = True
            txtRS.ReadOnly = True
            txtRFC.ReadOnly = True
            btnInsertClient.Enabled = False
            btnClrClient.Enabled = False
        Else
            dgvConsulta.Visible = False
            btnExistente.Visible = False
            txtRS.ReadOnly = False
            txtRFC.ReadOnly = False
            btnInsertClient.Enabled = True
            btnClrClient.Enabled = True
        End If
    End Sub

    Private Sub btnExistente_Click(sender As Object, e As EventArgs) Handles btnExistente.Click
        txtRFC.Text = dgvConsulta.CurrentRow.Cells(0).Value
        txtNombre.Text = dgvConsulta.CurrentRow.Cells(1).Value
        txtApPat.Text = dgvConsulta.CurrentRow.Cells(2).Value
        txtApMat.Text = dgvConsulta.CurrentRow.Cells(3).Value
        txtRS.Text = dgvConsulta.CurrentRow.Cells(5).Value
        txtEmail.Text = dgvConsulta.CurrentRow.Cells(6).Value
        txtCalle.Text = dgvConsulta.CurrentRow.Cells(9).Value
        txtNumero.Text = dgvConsulta.CurrentRow.Cells(10).Value
        txtColonia.Text = dgvConsulta.CurrentRow.Cells(8).Value
        txtCP.Text = dgvConsulta.CurrentRow.Cells(7).Value
        For i = 0 To dgvEstado.RowCount - 1
            If dgvEstado.Rows(i).Cells(0).Value = dgvConsulta.CurrentRow.Cells(11).Value Then
                txtEstado.Text = dgvEstado.Rows(i).Cells(1).Value
            End If
        Next
        chkExistentes.Checked = False
    End Sub
End Class