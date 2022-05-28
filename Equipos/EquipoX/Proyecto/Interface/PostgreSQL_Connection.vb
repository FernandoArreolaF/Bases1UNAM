Option Explicit On
Option Strict On

Imports Npgsql

Module PostgreSQL_Connection
    Public Function GetConnectionString() As String
        Dim host As String = "Host=192.168.100.114;"
        Dim port As String = "Port=5432;"
        Dim db As String = "Database=proyecto_final_postgres;"
        Dim user As String = "Username=postgres;"
        Dim pass As String = "Password=10022001;"
        Dim conString As String = String.Format("{0}{1}{2}{3}{4}", host, port, db, user, pass)
        Return conString
    End Function

    Public Con As New NpgsqlConnection(GetConnectionString())
    Public Cmd As New NpgsqlCommand
    Public SQL As String = ""

    Public Function PerformCRUD(Com As NpgsqlCommand) As DataTable
        Dim da As NpgsqlDataAdapter
        Dim dt As New DataTable()
        Try
            da = New NpgsqlDataAdapter
            da.SelectCommand = Com
            da.Fill(dt)
        Catch ex As Exception
            MessageBox.Show("Conexión fallida con la base de datos" & ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            dt = Nothing
        End Try
        Return dt
    End Function
End Module

