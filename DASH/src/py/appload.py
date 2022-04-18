# Run this app with `python3 app.py` and
# visit http://127.0.0.1:8050/ in your web browser.
# Note that I needed to reinstall the following for the above and I don't know why.
# pip3 install dash
# pip3 install pandas

import dash
from dash import Dash, dcc, html, Input, Output
import plotly.express as px
import pandas as pd


app = Dash(__name__)

df = pd.read_csv('file://localhost/Users/marmorri/tmp/load')
#df = pd.read_csv('file://colobench10/nethome/marmorri/DASHBOARD/data/good/nyt')
df['date'] = pd.to_datetime(df['date'])

df = df.sort_values(by=['date'])

app.layout = html.Div([
    dcc.RadioItems(sorted(df.operation.unique()), sorted(df.operation.unique())[0], inline=True, id='query-radio'),
    dcc.RadioItems(df.org.unique(), df.org.unique()[0], inline=True, id='org-radio'),
    dcc.RadioItems(df.suite.unique(), df.suite.unique()[0], inline=True, id='suite-radio'),
    dcc.RadioItems(df.idx.unique(), df.idx.unique()[0], inline=True, id='idx-radio'),
    dcc.Graph(
        id='dash-load',
        #figure=fig
    )
])

@app.callback(
    Output('dash-load', 'figure'),
    Input('query-radio', 'value'),
    Input('org-radio', 'value'),
    Input('idx-radio', 'value'),
    Input('suite-radio', 'value')
    )

def update_figure(selected_query, selected_org, selected_idx, selected_suite):
    filtered_df = df[(df.operation == selected_query) & (df.org == selected_org) & (df.idx == selected_idx)  & (df.suite == selected_suite)]

    fig = px.scatter(filtered_df, x="date", y="runtime", color="org", symbol="suite")
    fig.update_yaxes(range=[0, max(filtered_df.runtime)*1.1])


    fig.update_layout(transition_duration=500)

    return fig


if __name__ == '__main__':
    app.run_server(debug=True)
