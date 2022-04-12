
import React from 'react'
import {Routes, Route} from 'react-router-dom'
import Header from './components/Header'
import Dashboard from './components/Dashboard'
import ScientistDetail from './components/ScientistDetail'
// import './App.css';

function App() {
  return (
    <main>
      <Header />
      <Routes>
        <Route index element={<Dashboard/>} />
        <Route path="/scientists/:id/*" element={<ScientistDetail/>} />
      </Routes>
    
    </main>
  );
}

export default App;
