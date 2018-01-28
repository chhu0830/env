import React from "react"
import {
  BrowserRouter,
  Route,
  Switch,
  Redirect
} from "react-router-dom"

import Index from "./Pages/Index"

class Router extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <div>
          <Route exact path="/" component={ Index } />
        </div>
      </BrowserRouter>
    )
  }
}

export default Router
