# Import required libraries
import pandas as pd
import dash
import dash_html_components as html
import dash_core_components as dcc
from dash.dependencies import Input, Output
import plotly.express as px

# Read the airline data into pandas dataframe
spacex_df = pd.read_csv("spacex_launch_dash.csv")
max_payload = spacex_df['Payload Mass (kg)'].max()
min_payload = spacex_df['Payload Mass (kg)'].min()

# Create a dash application
app = dash.Dash(__name__)

site_options = []
site_options.append({'label': 'All Sites', 'value': 'All Sites'})
for i in spacex_df['Launch Site'].unique().tolist():
    site_options.append({'label': i, 'value': i})

# Create an app layout
app.layout = html.Div(children=[html.H1('SpaceX Launch Records Dashboard',
                                        style={'textAlign': 'center', 'color': '#503D36',
                                               'font-size': 40}),
                                # TASK 1: Add a dropdown list to enable Launch Site selection
                                # The default select value is for ALL sites
                                dcc.Dropdown(id='site_dropdown',
                                options=site_options,
                                value='All Sites',
                                placeholder='Select a Launch Site',
                                searchable=True),

                                html.Br(),

                                # TASK 2: Add a pie chart to show the total successful launches count for all sites
                                # If a specific launch site was selected, show the Success vs. Failed counts for the site
                                html.Div(dcc.Graph(id='success-pie-chart')),
                                html.Br(),

                                html.P("Payload range (Kg):"),
                                # TASK 3: Add a slider to select payload range
                                dcc.RangeSlider(id='payload_slider',
                                                min=0, max=10000, step=1000,
                                                marks = {0: '0 kg',
                                                        1000: '1000 kg',
                                                        2000: '2000 kg',
                                                        3000: '3000 kg',
                                                        4000: '4000 kg',
                                                        5000: '5000 kg',
                                                        6000: '6000 kg',
                                                        7000: '7000 kg',
                                                        8000: '8000 kg',
                                                        9000: '9000 kg',
                                                        10000: '10000 kg'},
                                                value = [min_payload, max_payload]
                                ),

                                # TASK 4: Add a scatter chart to show the correlation between payload and launch success
                                html.Div(dcc.Graph(id='success-payload-scatter-chart')),
                                ])

# TASK 2:
# Add a callback function for `site-dropdown` as input, `success-pie-chart` as output
# Function decorator to specify function input and output
@app.callback(Output(component_id='success-pie-chart', component_property='figure'),
              Input(component_id='site_dropdown', component_property='value'))

def get_pie_chart(site_dropdown):
    #we select the values with class= 1
    if site_dropdown == 'All Sites':
        success_df = spacex_df[spacex_df['class'] == 1]
        fig = px.pie(success_df, values='class', 
        names='Launch Site', 
        title='Total Success Launches')
        return fig
    else:
        df = spacex_df[spacex_df['Launch Site'] == site_dropdown]
        fig = px.pie(df,
        names='class',
        title='Total Success Launches in '+ site_dropdown)
        return fig

# TASK 4:
# Add a callback function for `site-dropdown` and `payload-slider` as inputs, `success-payload-scatter-chart` as output
@app.callback(Output(component_id='success-payload-scatter-chart', component_property='figure'),
              [Input(component_id='site_dropdown', component_property='value'),
              Input(component_id='payload_slider', component_property='value')]
              )

def get_scatter_graph(site_dropdown, payload_slider):
    min_mass, max_mass = payload_slider
    df = spacex_df[(spacex_df['Payload Mass (kg)'] > min_mass) & (spacex_df['Payload Mass (kg)'] < max_mass)]

    if site_dropdown == 'All Sites':
        fig = px.scatter(df,
                         x='Payload Mass (kg)', y='class',
                         color='Booster Version Category')
        return fig
    else:
        df2 = df[df['Launch Site'] == site_dropdown]
        fig = px.scatter(df2,
                         x='Payload Mass (kg)', y='class',
                         color='Booster Version Category')
        return fig

# Other parts of your code remain unchanged


# Run the app
if __name__ == '__main__':
    app.run_server()