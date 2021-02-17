import React from 'react';
import './Input.css';
import { Input, InputLabel } from '@material-ui/core';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';

const input = ( props ) => {
  let inputElement = null;
  
  switch ( props.elementType ) {
      case ( 'input' ):
          inputElement = <Input
            //   className="InputElement"
              {...props.elementConfig}
              value={props.value}
              onChange={props.changed} />;
          break;
      case ( 'textarea' ):
          inputElement = <textarea
            //   className="InputElement"
              {...props.elementConfig}
              value={props.value}
              onChange={props.changed} />;
          break;
      case ( 'select' ):
          inputElement = (
              <select
                //   className="InputElement"
                  value={props.value}
                  onChange={props.changed}>
                  {props.elementConfig.options.map(option => (
                      <option key={option.value} value={option.value}>
                          {option.displayValue}
                      </option>
                  ))}
              </select>
          );
          break;
      case ('date'): 
      inputElement = (
          <label>
              <DatePicker
              selected={props.value}
              onChange={props.changed}
              className="myDatePicker"
              showTimeSelect
              dateFormat="dd/MM/yyyy HH:mm:ss"
              timeIntervals={15}
              timeCaption="time"
              />
          </label>
      );
      
           break;
      case ('double'):
      inputElement = (<div><input
              className="InputElement"
              {...props.elementConfig}
              value={props.value}
              onChange={props.changed} />
              
              <input
              className="InputElement"
              {...props.elementConfig}
              value={props.value}
            onChange={props.changed} /></div>);
    break;     
      default:
          inputElement = <input
              className="InputElement"
              {...props.elementConfig}
              value={props.value}
              onChange={props.changed} />;
  }

  return (
      <div>
        <InputLabel>{props.label}</InputLabel>
        {inputElement}
      </div>

      // <div className="Input">
      //     <label className="Label">{props.label}</label>
      //     {inputElement}
      // </div>
  );

};

export default input;