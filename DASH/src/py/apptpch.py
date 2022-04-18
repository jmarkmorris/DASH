# Run this app with `python3 apptpch.py` and
# visit http://127.0.0.1:8050/ in your web browser.
# Note that I needed to reinstall the following for the above and I don't know why.
# pip3 install dash
# pip3 install pandas

import dash
from dash import Dash, dcc, html, Input, Output
import plotly.express as px
import pandas as pd


app = Dash(__name__)

# The local accesses work :
# df = pd.read_csv('file://localhost/Users/marmorri/tmp/tpch')
# df = pd.read_csv('//Users/marmorri/tmp/tpch')
# The following fail :
# df = pd.read_csv('smb://netapp/nethome/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('smb://nethome/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('file://localhost/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('smb://localhost/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('//marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('//nethome/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('file://nethome/marmorri/DASHBOARD/data/new/tpch')
# df = pd.read_csv('file://marmorri/DASHBOARD/data/new/tpch')

# the following mount point will disappear on a laptop reboot - but at least this saves a step of moving the files to the laptop
# sudo bash
# sudo mount -t nfs -o vers=3 kits-nas:/export/home/marmorri/DASHBOARD/data/new csv_nfs
df = pd.read_csv('file://localhost/Users/marmorri/csv_nfs/tpch')

df['date'] = pd.to_datetime(df['date'])

df = df.sort_values(by=['date'])

app.layout = html.Div([
    # could not label column 'query' because that is a keyword. This column should therefore be labeled querynum.
    dcc.RadioItems(sorted(df.querynum.unique()), sorted(df.querynum.unique())[0], inline=True, id='query-radio'),
    dcc.RadioItems(df.org.unique(), df.org.unique()[0], inline=True, id='org-radio'),
    dcc.RadioItems(df.para.unique(), df.para.unique()[0], inline=True, id='para-radio'),
    dcc.RadioItems(df.idx.unique(), df.idx.unique()[0], inline=True, id='idx-radio'),
    dcc.Graph(
        id='dash-tpch',
        #figure=fig
    ),
    dcc.Graph(
        id='dash-tpch2',
        #figure=fig
    )
])

@app.callback(
    Output('dash-tpch', 'figure'),
    Input('query-radio', 'value'),
    Input('org-radio', 'value'),
    Input('idx-radio', 'value'),
    Input('para-radio', 'value')
    )

def update_figure(selected_query, selected_org, selected_idx, selected_para):
    filtered_df = df[(df.querynum == selected_query) & (df.org == selected_org) & (df.idx == selected_idx)  & (df.para == selected_para)]

    fig = px.scatter(filtered_df, x="date", y="runtime", color="org", symbol="para")
    fig.update_yaxes(range=[0, max(filtered_df.runtime)*1.1])

    fig2 = px.scatter(filtered_df, x="date", y="runtime", color="org", symbol="para")



    fig.update_layout(transition_duration=500)
    # fig2.update_layout(transition_duration=500)

    return fig


if __name__ == '__main__':
    app.run_server(debug=True)
