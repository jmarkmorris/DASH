# Run this app with `python3 tpch.py` and
# visit http://127.0.0.1:8050/ in your web browser.
# Note that I needed to reinstall the following for the above and I don't know why.
# pip3 install dash
# pip3 install pandas

import dash
from dash import Dash, dcc, html
import plotly.express as px
import pandas as pd


app = Dash(__name__)
colors = {
    'background': '#111111',
    'text': '#FFFFFF'
}

# The local accesses work :
# df = pd.read_csv('file://localhost/Users/marmorri/tmp/tpch')
# df = pd.read_csv('//Users/marmorri/tmp/tpch')


# the following mount point will disappear on a laptop reboot - but at least this saves a step of moving the files to the laptop
# sudo bash
# sudo mkdir /Users/marmorri/csv_nfs
# sudo mount -t nfs -o vers=3 kits-nas:/export/home/marmorri/DASHBOARD/data/new /Users/marmorri/csv_nfs
df = pd.read_csv('file://localhost/Users/marmorri/csv_nfs/tpch')

df['date'] = pd.to_datetime(df['date'])

df = df.sort_values(by=['date'])

#& (df.org == selected_org) & (df.idx == selected_idx)  & (df.para == selected_para)]

fdf1 = df[(df.querynum == "Q01") & (df.para == "autoparallel")]
fig1 = px.scatter(fdf1, x="date", y="runtime", color="org", symbol="para")
fig1.update_yaxes(range=[0, max(fdf1.runtime)*1.1])
fig1.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

fdf2 = df[(df.querynum == "Q02") & (df.para == "autoparallel")]
fig2 = px.scatter(fdf2, x="date", y="runtime", color="org", symbol="para")
fig2.update_yaxes(range=[0, max(fdf2.runtime)*1.1])
fig2.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

fdf3 = df[(df.querynum == "Q03") & (df.para == "autoparallel")]
fig3 = px.scatter(fdf3, x="date", y="runtime", color="org", symbol="para")
fig3.update_yaxes(range=[0, max(fdf3.runtime)*1.1])
fig3.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

fdf4 = df[(df.querynum == "Q04") & (df.para == "autoparallel")]
fig4 = px.scatter(fdf4, x="date", y="runtime", color="org", symbol="para")
fig4.update_yaxes(range=[0, max(fdf4.runtime)*1.1])
fig4.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

fdf05 = df[(df.querynum == "Q05") & (df.para == "autoparallel")]
fig05 = px.scatter(fdf05, x="date", y="runtime", color="org", symbol="para")
fig05.update_yaxes(range=[0, max(fdf05.runtime)*1.1])
fig05.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf06 = df[(df.querynum == "Q06") & (df.para == "autoparallel")]
fig06 = px.scatter(fdf06, x="date", y="runtime", color="org", symbol="para")
fig06.update_yaxes(range=[0, max(fdf06.runtime)*1.1])
fig06.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf07 = df[(df.querynum == "Q07") & (df.para == "autoparallel")]
fig07 = px.scatter(fdf07, x="date", y="runtime", color="org", symbol="para")
fig07.update_yaxes(range=[0, max(fdf07.runtime)*1.1])
fig07.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf08 = df[(df.querynum == "Q08") & (df.para == "autoparallel")]
fig08 = px.scatter(fdf08, x="date", y="runtime", color="org", symbol="para")
fig08.update_yaxes(range=[0, max(fdf08.runtime)*1.1])
fig08.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf09 = df[(df.querynum == "Q09") & (df.para == "autoparallel")]
fig09 = px.scatter(fdf09, x="date", y="runtime", color="org", symbol="para")
fig09.update_yaxes(range=[0, max(fdf09.runtime)*1.1])
fig09.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf10 = df[(df.querynum == "Q10") & (df.para == "autoparallel")]
fig10 = px.scatter(fdf10, x="date", y="runtime", color="org", symbol="para")
fig10.update_yaxes(range=[0, max(fdf10.runtime)*1.1])
fig10.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf11 = df[(df.querynum == "Q11") & (df.para == "autoparallel")]
fig11 = px.scatter(fdf11, x="date", y="runtime", color="org", symbol="para")
fig11.update_yaxes(range=[0, max(fdf11.runtime)*1.1])
fig11.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf12 = df[(df.querynum == "Q12") & (df.para == "autoparallel")]
fig12 = px.scatter(fdf12, x="date", y="runtime", color="org", symbol="para")
fig12.update_yaxes(range=[0, max(fdf12.runtime)*1.1])
fig12.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf13 = df[(df.querynum == "Q13") & (df.para == "autoparallel")]
fig13 = px.scatter(fdf13, x="date", y="runtime", color="org", symbol="para")
fig13.update_yaxes(range=[0, max(fdf13.runtime)*1.1])
fig13.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf14 = df[(df.querynum == "Q14") & (df.para == "autoparallel")]
fig14 = px.scatter(fdf14, x="date", y="runtime", color="org", symbol="para")
fig14.update_yaxes(range=[0, max(fdf14.runtime)*1.1])
fig14.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf15 = df[(df.querynum == "Q15") & (df.para == "autoparallel")]
fig15 = px.scatter(fdf15, x="date", y="runtime", color="org", symbol="para")
fig15.update_yaxes(range=[0, max(fdf15.runtime)*1.1])
fig15.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf16 = df[(df.querynum == "Q16") & (df.para == "autoparallel")]
fig16 = px.scatter(fdf16, x="date", y="runtime", color="org", symbol="para")
fig16.update_yaxes(range=[0, max(fdf16.runtime)*1.1])
fig16.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf17 = df[(df.querynum == "Q17") & (df.para == "autoparallel")]
fig17 = px.scatter(fdf17, x="date", y="runtime", color="org", symbol="para")
fig17.update_yaxes(range=[0, max(fdf17.runtime)*1.1])
fig17.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf18 = df[(df.querynum == "Q18") & (df.para == "autoparallel")]
fig18 = px.scatter(fdf18, x="date", y="runtime", color="org", symbol="para")
fig18.update_yaxes(range=[0, max(fdf18.runtime)*1.1])
fig18.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf19 = df[(df.querynum == "Q19") & (df.para == "autoparallel")]
fig19 = px.scatter(fdf19, x="date", y="runtime", color="org", symbol="para")
fig19.update_yaxes(range=[0, max(fdf19.runtime)*1.1])
fig19.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf20 = df[(df.querynum == "Q20") & (df.para == "autoparallel")]
fig20 = px.scatter(fdf20, x="date", y="runtime", color="org", symbol="para")
fig20.update_yaxes(range=[0, max(fdf20.runtime)*1.1])
fig20.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf21 = df[(df.querynum == "Q21") & (df.para == "autoparallel")]
fig21 = px.scatter(fdf21, x="date", y="runtime", color="org", symbol="para")
fig21.update_yaxes(range=[0, max(fdf21.runtime)*1.1])
fig21.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)

fdf22 = df[(df.querynum == "Q22") & (df.para == "autoparallel")]
fig22 = px.scatter(fdf22, x="date", y="runtime", color="org", symbol="para")
fig22.update_yaxes(range=[0, max(fdf22.runtime)*1.1])
fig22.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text']
)



#fig2 = px.scatter(filtered_df, x="date", y="runtime", color="org", symbol="para")

app.layout = html.Div(style={'backgroundColor': colors['background']}, children=[
    # could not label column 'query' because that is a keyword. This column should therefore be labeled querynum.
    html.H1(
        children='TPCH Dashboard',
        style={
            'textAlign': 'center',
            'color': colors['text']
        }
    ),
    dcc.Graph(
        id='dash-tpch1',
        figure=fig1
    ),
    dcc.Graph(
        id='dash-tpch2',
        figure=fig2
    ),
    dcc.Graph(
        id='dash-tpch3',
        figure=fig3
    ),
    dcc.Graph(
        id='dash-tpch4',
        figure=fig4
    ),
    dcc.Graph(
        id='dash-tpch5',
        figure=fig05
    ),
    dcc.Graph(
        id='dash-tpch6',
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
    id='dash-tpch18',
    figure=fig18
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
    id='dash-tpch21',
    figure=fig21
    ),
    dcc.Graph(
    id='dash-tpch22',
    figure=fig22
    )

])






if __name__ == '__main__':
    app.run_server(debug=True)
