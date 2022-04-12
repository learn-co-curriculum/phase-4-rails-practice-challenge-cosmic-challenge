import React from 'react'
import { Link } from 'react-router-dom'

function ScientistCard({scientist: {id, name, avatar}, onDelete}) {
  return (
    <div className="scicard">
        <img src={avatar} alt={name} />
        <h3>{name}</h3>
        <Link to={`/scientists/${id}`}>View Missions</Link>
        <button onClick={()=>onDelete(id)}>X</button>
    </div>
  )
}

export default ScientistCard