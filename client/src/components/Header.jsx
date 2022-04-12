import React from 'react'
import {Link} from 'react-router-dom'

function Header() {
  return (
    <nav className="navbar">
        <h1><Link to="/">Cosmic Travel Agency</Link></h1>
    </nav>
  )


}

export default Header