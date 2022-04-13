import React, {Suspense, useState, useEffect} from 'react'
import ScientistCard from './ScientistCard'
import ScientistForm from './ScientistForm'
import GridLoader from 'react-spinners/GridLoader'

function Dashboard() {

  const [scientists, setScientists] = useState([])

  useEffect(() => {
    const fetchScientists = async () => {
      const response = await fetch('/scientists')
      const sciArr = await response.json()
      setScientists(sciArr)
    }
    fetchScientists()
      .catch(console.error)
    
  }, [])

  function handleAddScientist(newSci){
    setScientists(scientists => [...scientists, newSci])
  }

  function handleDeleteScientist(id){
    fetch(`/scientists/${id}`, {method: "DELETE"})
    .then(r => {
      if (r.ok) {
        setScientists(scientists => scientists.filter(sci => sci.id != id))
      }
    })
  }

  let sciCards = scientists.map(sci => <ScientistCard key={sci.id} scientist={sci} onDelete={handleDeleteScientist}/>)
  
  return (
    <div>
      <Suspense fallback={<GridLoader />}>
        <h2>Scientists</h2>
        <div className="sciList">
          {sciCards}

        </div>
      </Suspense>
      <hr />
      <ScientistForm onScientistRequest={handleAddScientist} edit={false} />
    </div>
  )
}

export default Dashboard
