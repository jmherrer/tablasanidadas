<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TablaAnidada.aspx.cs" Inherits="TablasAnidadas.TablaAnidada" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tablas Anidadas: Gridview Bootstrap 4</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("[src*=plus]").live("click", function () {
            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
            $(this).attr("src", "images/minus.png");
        });
        $("[src*=minus]").live("click", function () {
            $(this).attr("src", "images/plus.png");
            $(this).closest("tr").next().remove();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div class="container text-center">
                <h1 class="display-4">Tablas anidadas.</h1>
                <h3>Gridview & Boostrap 4</h3>
            </div>
        </header>

    <div class="container">

        <asp:GridView ID="grvModelos" runat="server" AutoGenerateColumns="false" CssClass="table table-sm table-bordered" DataKeyNames="ProductModelID" OnRowDataBound="grvModelos_RowDataBound">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <img alt = "" style="cursor: pointer" src="images/plus.png" />
                        
                        <asp:Panel ID="pnlProductos" runat="server" Style="display: none;">
                            <asp:GridView ID="grvProductos" AutoGenerateColumns="false" CssClass="table table-sm table-bordered" runat="server">
                                <Columns>
                                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" />
                                    <asp:BoundField DataField="ProductNumber" HeaderText="ProductNumber" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="StandardCost" HeaderText="Cost" />
                                    <asp:BoundField DataField="ListPrice" HeaderText="Price" />
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Nombre" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
