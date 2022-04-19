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
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf02 = df[(df.querynum == "Q02") & (df.para == "autoparallel")]
fig02 = px.scatter(fdf02, x="date", y="runtime", color="org", symbol="para", title="Q02")
fig02.update_yaxes(range=[0, max(fdf02.runtime)*1.1])
fig02.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf03 = df[(df.querynum == "Q03") & (df.para == "autoparallel")]
fig03 = px.scatter(fdf03, x="date", y="runtime", color="org", symbol="para", title="Q03")
fig03.update_yaxes(range=[0, max(fdf03.runtime)*1.1])
fig03.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf04 = df[(df.querynum == "Q04") & (df.para == "autoparallel")]
fig04 = px.scatter(fdf04, x="date", y="runtime", color="org", symbol="para", title="Q04")
fig04.update_yaxes(range=[0, max(fdf04.runtime)*1.1])
fig04.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf05 = df[(df.querynum == "Q05") & (df.para == "autoparallel")]
fig05 = px.scatter(fdf05, x="date", y="runtime", color="org", symbol="para", title="Q05")
fig05.update_yaxes(range=[0, max(fdf05.runtime)*1.1])
fig05.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf06 = df[(df.querynum == "Q06") & (df.para == "autoparallel")]
fig06 = px.scatter(fdf06, x="date", y="runtime", color="org", symbol="para", title="Q06")
fig06.update_yaxes(range=[0, max(fdf06.runtime)*1.1])
fig06.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf07 = df[(df.querynum == "Q07") & (df.para == "autoparallel")]
fig07 = px.scatter(fdf07, x="date", y="runtime", color="org", symbol="para", title="Q07")
fig07.update_yaxes(range=[0, max(fdf07.runtime)*1.1])
fig07.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf08 = df[(df.querynum == "Q08") & (df.para == "autoparallel")]
fig08 = px.scatter(fdf08, x="date", y="runtime", color="org", symbol="para", title="Q08")
fig08.update_yaxes(range=[0, max(fdf08.runtime)*1.1])
fig08.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf09 = df[(df.querynum == "Q09") & (df.para == "autoparallel")]
fig09 = px.scatter(fdf09, x="date", y="runtime", color="org", symbol="para", title="Q09")
fig09.update_yaxes(range=[0, max(fdf09.runtime)*1.1])
fig09.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf10 = df[(df.querynum == "Q10") & (df.para == "autoparallel")]
fig10 = px.scatter(fdf10, x="date", y="runtime", color="org", symbol="para", title="Q10")
fig10.update_yaxes(range=[0, max(fdf10.runtime)*1.1])
fig10.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf11 = df[(df.querynum == "Q11") & (df.para == "autoparallel")]
fig11 = px.scatter(fdf11, x="date", y="runtime", color="org", symbol="para", title="Q11")
fig11.update_yaxes(range=[0, max(fdf11.runtime)*1.1])
fig11.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf12 = df[(df.querynum == "Q12") & (df.para == "autoparallel")]
fig12 = px.scatter(fdf12, x="date", y="runtime", color="org", symbol="para", title="Q12")
fig12.update_yaxes(range=[0, max(fdf12.runtime)*1.1])
fig12.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf13 = df[(df.querynum == "Q13") & (df.para == "autoparallel")]
fig13 = px.scatter(fdf13, x="date", y="runtime", color="org", symbol="para", title="Q13")
fig13.update_yaxes(range=[0, max(fdf13.runtime)*1.1])
fig13.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf14 = df[(df.querynum == "Q14") & (df.para == "autoparallel")]
fig14 = px.scatter(fdf14, x="date", y="runtime", color="org", symbol="para", title="Q14")
fig14.update_yaxes(range=[0, max(fdf14.runtime)*1.1])
fig14.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf15 = df[(df.querynum == "Q15") & (df.para == "autoparallel")]
fig15 = px.scatter(fdf15, x="date", y="runtime", color="org", symbol="para", title="Q15")
fig15.update_yaxes(range=[0, max(fdf15.runtime)*1.1])
fig15.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf16 = df[(df.querynum == "Q16") & (df.para == "autoparallel")]
fig16 = px.scatter(fdf16, x="date", y="runtime", color="org", symbol="para", title="Q16")
fig16.update_yaxes(range=[0, max(fdf16.runtime)*1.1])
fig16.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf17 = df[(df.querynum == "Q17") & (df.para == "autoparallel")]
fig17 = px.scatter(fdf17, x="date", y="runtime", color="org", symbol="para", title="Q17")
fig17.update_yaxes(range=[0, max(fdf17.runtime)*1.1])
fig17.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf19 = df[(df.querynum == "Q19") & (df.para == "autoparallel")]
fig19 = px.scatter(fdf19, x="date", y="runtime", color="org", symbol="para", title="Q19")
fig19.update_yaxes(range=[0, max(fdf19.runtime)*1.1])
fig19.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf20 = df[(df.querynum == "Q20") & (df.para == "autoparallel")]
fig20 = px.scatter(fdf20, x="date", y="runtime", color="org", symbol="para", title="Q20")
fig20.update_yaxes(range=[0, max(fdf20.runtime)*1.1])
fig20.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf22 = df[(df.querynum == "Q22") & (df.para == "autoparallel")]
fig22 = px.scatter(fdf22, x="date", y="runtime", color="org", symbol="para", title="Q22")
fig22.update_yaxes(range=[0, max(fdf22.runtime)*1.1])
fig22.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB1 = df[(df.querynum == "QLB1") & (df.para == "autoparallel")]
figLB1 = px.scatter(fdfLB1, x="date", y="runtime", color="org", symbol="para", title="QLB1")
figLB1.update_yaxes(range=[0, max(fdfLB1.runtime)*1.1])
figLB1.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB2 = df[(df.querynum == "QLB2") & (df.para == "autoparallel")]
figLB2 = px.scatter(fdfLB2, x="date", y="runtime", color="org", symbol="para", title="QLB2")
figLB2.update_yaxes(range=[0, max(fdfLB2.runtime)*1.1])
figLB2.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB3 = df[(df.querynum == "QLB3") & (df.para == "autoparallel")]
figLB3 = px.scatter(fdfLB3, x="date", y="runtime", color="org", symbol="para", title="QLB3")
figLB3.update_yaxes(range=[0, max(fdfLB3.runtime)*1.1])
figLB3.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB4 = df[(df.querynum == "QLB4") & (df.para == "autoparallel")]
figLB4 = px.scatter(fdfLB4, x="date", y="runtime", color="org", symbol="para", title="QLB4")
figLB4.update_yaxes(range=[0, max(fdfLB4.runtime)*1.1])
figLB4.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB5 = df[(df.querynum == "QLB5") & (df.para == "autoparallel")]
figLB5 = px.scatter(fdfLB5, x="date", y="runtime", color="org", symbol="para", title="QLB5")
figLB5.update_yaxes(range=[0, max(fdfLB5.runtime)*1.1])
figLB5.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB6 = df[(df.querynum == "QLB6") & (df.para == "autoparallel")]
figLB6 = px.scatter(fdfLB6, x="date", y="runtime", color="org", symbol="para", title="QLB6")
figLB6.update_yaxes(range=[0, max(fdfLB6.runtime)*1.1])
figLB6.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB7 = df[(df.querynum == "QLB7") & (df.para == "autoparallel")]
figLB7 = px.scatter(fdfLB7, x="date", y="runtime", color="org", symbol="para", title="QLB7")
figLB7.update_yaxes(range=[0, max(fdfLB7.runtime)*1.1])
figLB7.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB8 = df[(df.querynum == "QLB8") & (df.para == "autoparallel")]
figLB8 = px.scatter(fdfLB8, x="date", y="runtime", color="org", symbol="para", title="QLB8")
figLB8.update_yaxes(range=[0, max(fdfLB8.runtime)*1.1])
figLB8.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdfLB9 = df[(df.querynum == "QLB9") & (df.para == "autoparallel")]
figLB9 = px.scatter(fdfLB9, x="date", y="runtime", color="org", symbol="para", title="QLB9")
figLB9.update_yaxes(range=[0, max(fdfLB9.runtime)*1.1])
figLB9.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf06b = df[(df.querynum == "Q06b") & (df.para == "autoparallel")]
fig06b = px.scatter(fdf06b, x="date", y="runtime", color="org", symbol="para", title="Q06b")
fig06b.update_yaxes(range=[0, max(fdf06b.runtime)*1.1])
fig06b.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf06c = df[(df.querynum == "Q06c") & (df.para == "autoparallel")]
fig06c = px.scatter(fdf06c, x="date", y="runtime", color="org", symbol="para", title="Q06c")
fig06c.update_yaxes(range=[0, max(fdf06c.runtime)*1.1])
fig06c.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
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
),
    dcc.Graph(
    id='dash-tpchLB1',
    figure=figLB1
),
    dcc.Graph(
    id='dash-tpchLB2',
    figure=figLB2
),
    dcc.Graph(
    id='dash-tpchLB3',
    figure=figLB3
),
    dcc.Graph(
    id='dash-tpchLB4',
    figure=figLB4
),
    dcc.Graph(
    id='dash-tpchLB5',
    figure=figLB5
),
    dcc.Graph(
    id='dash-tpchLB6',
    figure=figLB6
),
    dcc.Graph(
    id='dash-tpchLB7',
    figure=figLB7
),
    dcc.Graph(
    id='dash-tpchLB8',
    figure=figLB8
),
    dcc.Graph(
    id='dash-tpchLB9',
    figure=figLB9
),
    dcc.Graph(
    id='dash-tpch06b',
    figure=fig06b
),
    dcc.Graph(
    id='dash-tpch06c',
    figure=fig06c
    )
])
if __name__ == '__main__':
    app.run_server(debug=True)
