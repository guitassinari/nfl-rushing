// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { Layout } from 'antd';
import PlayerRushings from './pages/player-rushings'
import 'antd/dist/antd.css';
const { Header, Footer, Content } = Layout;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Layout>
      <Header></Header>
      <Content>
        <PlayerRushings />
      </Content>
      <Footer></Footer>
    </Layout>,
    document.body.appendChild(document.createElement('div')),
  )
})
