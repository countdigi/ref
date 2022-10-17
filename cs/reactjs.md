# reactjs

## Create React App

Make new project directory, cd into it, and install:

```bash
npx create-react-app .
```

Start the development server:
```
npm start
```

## Standard Folder Structure

- public
  - index.html  - anchor for React App `<div id="root"></div>`
  - manifest.json
- src
  - index.js `<--- this is the starting point that binds to the root element that imports App.js`
  - index.css
  - App.js `<--- main entry point for the app`
  - App.css
  - App.test.js
  - logo.svg


## Example

App.js
```jsx
import React, { Component } from 'react';
import './App.css';
import Person from './Person/Person';

class App extends Component {
  render() {
    return (
      <div className="App">
      <h1>Hi, I'm a react App</h1>
      <Person name="Max" age="28" />
      <Person name="Manu" age="29" >My Hobbies: Racing</Person>
      <Person name="Stephanie" age="26"/>
      </div>
    );
  }
}

export default App;
```

Person/Person.js
```jsx
import React from 'react';

const person = (props) => {
  return <p>I'm {props.name} and I am {props.age} years old!</p>
}

export default person;
```


