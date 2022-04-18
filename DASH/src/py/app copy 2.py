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

df = pd.read_csv('file://localhost/Users/marmorri/tmp/nyt')
df = df.sort_values(by=['date'])

app.layout = html.Div([
    # could not label column 'query' because that is a keyword. This column should therefore be labeled querynum.
    dcc.RadioItems(sorted(df.querynum.unique()), sorted(df.querynum.unique())[0], inline=True, id='query-radio'),
    dcc.RadioItems(df.org.unique(), df.org.unique()[0], inline=True, id='org-radio'),
    dcc.RadioItems(df.para.unique(), df.para.unique()[0], inline=True, id='para-radio'),
    dcc.RadioItems(df.idx.unique(), df.idx.unique()[0], inline=True, id='idx-radio'),
    dcc.Graph(
        id='dash-nyt',
        #figure=fig
    )
])

@app.callback(
    Output('dash-nyt', 'figure'),
    Input('query-radio', 'value'),
    Input('org-radio', 'value'),
    Input('idx-radio', 'value'),
    Input('para-radio', 'value')
    )

def update_figure(selected_query, selected_org, selected_idx, selected_para):
    filtered_df = df[(df.querynum == selected_query) & (df.org == selected_org) & (df.idx == selected_idx)  & (df.para == selected_para)]

    fig = px.scatter(filtered_df, x="date", y="runtime", color="org", symbol="para")

    fig.update_layout(transition_duration=500)

    return fig


if __name__ == '__main__':
    app.run_server(debug=True)
