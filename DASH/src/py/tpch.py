import dash
from dash import Dash, dcc, html
import plotly.express as px
import pandas as pd
app = Dash(__name__)
colors = {
'background': '#111111',
'text': '#FFFFFF'
}
df = pd.read_csv('file://localhost/Users/marmorri/csv_nfs/nyt')
df['date'] = pd.to_datetime(df['date'])
df = df.sort_values(by=['date'])
fdf11 = df[(df.querynum == "Q11") & (df.org == "ddl-row")]
fig11 = px.scatter(fdf11, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q11")
fig11.update_yaxes(range=[0, max(fdf11.runtime)*1.1])
fig11.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf12 = df[(df.querynum == "Q12") & (df.org == "ddl-row")]
fig12 = px.scatter(fdf12, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q12")
fig12.update_yaxes(range=[0, max(fdf12.runtime)*1.1])
fig12.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf13 = df[(df.querynum == "Q13") & (df.org == "ddl-row")]
fig13 = px.scatter(fdf13, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q13")
fig13.update_yaxes(range=[0, max(fdf13.runtime)*1.1])
fig13.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf14 = df[(df.querynum == "Q14") & (df.org == "ddl-row")]
fig14 = px.scatter(fdf14, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q14")
fig14.update_yaxes(range=[0, max(fdf14.runtime)*1.1])
fig14.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf15 = df[(df.querynum == "Q15") & (df.org == "ddl-row")]
fig15 = px.scatter(fdf15, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q15")
fig15.update_yaxes(range=[0, max(fdf15.runtime)*1.1])
fig15.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf16 = df[(df.querynum == "Q16") & (df.org == "ddl-row")]
fig16 = px.scatter(fdf16, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q16")
fig16.update_yaxes(range=[0, max(fdf16.runtime)*1.1])
fig16.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf17 = df[(df.querynum == "Q17") & (df.org == "ddl-row")]
fig17 = px.scatter(fdf17, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q17")
fig17.update_yaxes(range=[0, max(fdf17.runtime)*1.1])
fig17.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf18 = df[(df.querynum == "Q18") & (df.org == "ddl-row")]
fig18 = px.scatter(fdf18, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q18")
fig18.update_yaxes(range=[0, max(fdf18.runtime)*1.1])
fig18.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf19 = df[(df.querynum == "Q19") & (df.org == "ddl-row")]
fig19 = px.scatter(fdf19, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q19")
fig19.update_yaxes(range=[0, max(fdf19.runtime)*1.1])
fig19.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

fdf20 = df[(df.querynum == "Q20") & (df.org == "ddl-row")]
fig20 = px.scatter(fdf20, x="date", y="runtime", color="para", color_discrete_map={"%NOPARALLEL": "red", "autoparallel": "#00FE35", "%PARALLEL": "#1E90FF"}, symbol="org", title="Q20")
fig20.update_yaxes(range=[0, max(fdf20.runtime)*1.1])
fig20.update_layout(
plot_bgcolor=colors['background'],
paper_bgcolor=colors['background'],
font_color=colors['text'],
legend=dict( yanchor="top", y=1.1, xanchor="auto", orientation="h")
)

app.layout = html.Div(style={'backgroundColor': colors['background']}, children=[
html.H1(
children='NY Taxi Dashboard',
style={
'textAlign': 'center',
'color': colors['text']
}
),
    dcc.Graph(
    id='dash-nyt11',
    figure=fig11
),
    dcc.Graph(
    id='dash-nyt12',
    figure=fig12
),
    dcc.Graph(
    id='dash-nyt13',
    figure=fig13
),
    dcc.Graph(
    id='dash-nyt14',
    figure=fig14
),
    dcc.Graph(
    id='dash-nyt15',
    figure=fig15
),
    dcc.Graph(
    id='dash-nyt16',
    figure=fig16
),
    dcc.Graph(
    id='dash-nyt17',
    figure=fig17
),
    dcc.Graph(
    id='dash-nyt18',
    figure=fig18
),
    dcc.Graph(
    id='dash-nyt19',
    figure=fig19
),
    dcc.Graph(
    id='dash-nyt20',
    figure=fig20
    )
])
if __name__ == '__main__':
    app.run_server(debug=True)
