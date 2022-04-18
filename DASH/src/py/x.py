import dash
from dash import Dash, dcc, html
import plotly.express as px
import pandas as pd
app = Dash(__name__)
colors = {
'background': '#111111',
'text': '#FFFFFF'
}
df = pd.read_csv('file://localhost/Users/marmorri/csv_nfs/tpch')
df['date'] = pd.to_datetime(df['date'])
df = df.sort_values(by=['date'])
fdf01 = df[(df.querynum == "Q01") & (df.para == "autoparallel")]
fig01 = px.scatter(fdf01, x="date", y="runtime", color="org", symbol="para", title="Q01")
fig01.update_yaxes(range=[0, max(fdf01.runtime)*1.1])
fig01.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf02 = df[(df.querynum == "Q02") & (df.para == "autoparallel")]
fig02 = px.scatter(fdf02, x="date", y="runtime", color="org", symbol="para", title="Q02")
fig02.update_yaxes(range=[0, max(fdf02.runtime)*1.1])
fig02.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf03 = df[(df.querynum == "Q03") & (df.para == "autoparallel")]
fig03 = px.scatter(fdf03, x="date", y="runtime", color="org", symbol="para", title="Q03")
fig03.update_yaxes(range=[0, max(fdf03.runtime)*1.1])
fig03.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf04 = df[(df.querynum == "Q04") & (df.para == "autoparallel")]
fig04 = px.scatter(fdf04, x="date", y="runtime", color="org", symbol="para", title="Q04")
fig04.update_yaxes(range=[0, max(fdf04.runtime)*1.1])
fig04.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf05 = df[(df.querynum == "Q05") & (df.para == "autoparallel")]
fig05 = px.scatter(fdf05, x="date", y="runtime", color="org", symbol="para", title="Q05")
fig05.update_yaxes(range=[0, max(fdf05.runtime)*1.1])
fig05.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf06 = df[(df.querynum == "Q06") & (df.para == "autoparallel")]
fig06 = px.scatter(fdf06, x="date", y="runtime", color="org", symbol="para", title="Q06")
fig06.update_yaxes(range=[0, max(fdf06.runtime)*1.1])
fig06.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf07 = df[(df.querynum == "Q07") & (df.para == "autoparallel")]
fig07 = px.scatter(fdf07, x="date", y="runtime", color="org", symbol="para", title="Q07")
fig07.update_yaxes(range=[0, max(fdf07.runtime)*1.1])
fig07.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf08 = df[(df.querynum == "Q08") & (df.para == "autoparallel")]
fig08 = px.scatter(fdf08, x="date", y="runtime", color="org", symbol="para", title="Q08")
fig08.update_yaxes(range=[0, max(fdf08.runtime)*1.1])
fig08.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf09 = df[(df.querynum == "Q09") & (df.para == "autoparallel")]
fig09 = px.scatter(fdf09, x="date", y="runtime", color="org", symbol="para", title="Q09")
fig09.update_yaxes(range=[0, max(fdf09.runtime)*1.1])
fig09.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf10 = df[(df.querynum == "Q10") & (df.para == "autoparallel")]
fig10 = px.scatter(fdf10, x="date", y="runtime", color="org", symbol="para", title="Q10")
fig10.update_yaxes(range=[0, max(fdf10.runtime)*1.1])
fig10.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf11 = df[(df.querynum == "Q11") & (df.para == "autoparallel")]
fig11 = px.scatter(fdf11, x="date", y="runtime", color="org", symbol="para", title="Q11")
fig11.update_yaxes(range=[0, max(fdf11.runtime)*1.1])
fig11.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf12 = df[(df.querynum == "Q12") & (df.para == "autoparallel")]
fig12 = px.scatter(fdf12, x="date", y="runtime", color="org", symbol="para", title="Q12")
fig12.update_yaxes(range=[0, max(fdf12.runtime)*1.1])
fig12.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf13 = df[(df.querynum == "Q13") & (df.para == "autoparallel")]
fig13 = px.scatter(fdf13, x="date", y="runtime", color="org", symbol="para", title="Q13")
fig13.update_yaxes(range=[0, max(fdf13.runtime)*1.1])
fig13.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf14 = df[(df.querynum == "Q14") & (df.para == "autoparallel")]
fig14 = px.scatter(fdf14, x="date", y="runtime", color="org", symbol="para", title="Q14")
fig14.update_yaxes(range=[0, max(fdf14.runtime)*1.1])
fig14.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf15 = df[(df.querynum == "Q15") & (df.para == "autoparallel")]
fig15 = px.scatter(fdf15, x="date", y="runtime", color="org", symbol="para", title="Q15")
fig15.update_yaxes(range=[0, max(fdf15.runtime)*1.1])
fig15.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf16 = df[(df.querynum == "Q16") & (df.para == "autoparallel")]
fig16 = px.scatter(fdf16, x="date", y="runtime", color="org", symbol="para", title="Q16")
fig16.update_yaxes(range=[0, max(fdf16.runtime)*1.1])
fig16.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf17 = df[(df.querynum == "Q17") & (df.para == "autoparallel")]
fig17 = px.scatter(fdf17, x="date", y="runtime", color="org", symbol="para", title="Q17")
fig17.update_yaxes(range=[0, max(fdf17.runtime)*1.1])
fig17.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf19 = df[(df.querynum == "Q19") & (df.para == "autoparallel")]
fig19 = px.scatter(fdf19, x="date", y="runtime", color="org", symbol="para", title="Q19")
fig19.update_yaxes(range=[0, max(fdf19.runtime)*1.1])
fig19.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf20 = df[(df.querynum == "Q20") & (df.para == "autoparallel")]
fig20 = px.scatter(fdf20, x="date", y="runtime", color="org", symbol="para", title="Q20")
fig20.update_yaxes(range=[0, max(fdf20.runtime)*1.1])
fig20.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf22 = df[(df.querynum == "Q22") & (df.para == "autoparallel")]
fig22 = px.scatter(fdf22, x="date", y="runtime", color="org", symbol="para", title="Q22")
fig22.update_yaxes(range=[0, max(fdf22.runtime)*1.1])
fig22.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

app.layout = html.Div(style={'backgroundColor': colors['background']}, children=[
html.H1(
children='TPCH Dashboard',
style={
'textAlign': 'center',
'color': colors['text']
}
),
    dcc.Graph(
    id='dash-tpch01',
    figure=fig01
),
    dcc.Graph(
    id='dash-tpch02',
    figure=fig02
),
    dcc.Graph(
    id='dash-tpch03',
    figure=fig03
),
    dcc.Graph(
    id='dash-tpch04',
    figure=fig04
),
    dcc.Graph(
    id='dash-tpch05',
    figure=fig05
),
    dcc.Graph(
    id='dash-tpch06',
    figure=fig06
),
    dcc.Graph(
    id='dash-tpch07',
    figure=fig07
),
    dcc.Graph(
    id='dash-tpch08',
    figure=fig08
),
    dcc.Graph(
    id='dash-tpch09',
    figure=fig09
),
    dcc.Graph(
    id='dash-tpch10',
    figure=fig10
),
    dcc.Graph(
    id='dash-tpch11',
    figure=fig11
),
    dcc.Graph(
    id='dash-tpch12',
    figure=fig12
),
    dcc.Graph(
    id='dash-tpch13',
    figure=fig13
),
    dcc.Graph(
    id='dash-tpch14',
    figure=fig14
),
    dcc.Graph(
    id='dash-tpch15',
    figure=fig15
),
    dcc.Graph(
    id='dash-tpch16',
    figure=fig16
),
    dcc.Graph(
    id='dash-tpch17',
    figure=fig17
),
    dcc.Graph(
    id='dash-tpch19',
    figure=fig19
),
    dcc.Graph(
    id='dash-tpch20',
    figure=fig20
),
    dcc.Graph(
    id='dash-tpch22',
    figure=fig22
    )
])
if __name__ == '__main__':
    app.run_server(debug=True)
