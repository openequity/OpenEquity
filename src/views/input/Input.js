import React from 'react';
import DatePicker from 'react-datepicker';
import moment from 'moment';
import 'react-datepicker/dist/react-datepicker.css';
import  './Input.css';

const input = ( props ) => {
    let inputElement = null;
    
    switch ( props.elementType ) {
        case ( 'input' ):
            inputElement = <input
                className="InputElement"
                {...props.elementConfig}
                value={props.value}
                onChange={props.changed} />;
            break;
        case ( 'textarea' ):
            inputElement = <textarea
                className="InputElement"
                {...props.elementConfig}
                value={props.value}
                onChange={props.changed} />;
            break;
        case ( 'select' ):
            inputElement = (
                <select
                    className="InputElement"
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
                timeFormat="HH:mm"
                timeIntervals={15}
                dateFormat="LLL"
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
        <div className="Input">
            <label className="Label">{props.label}</label>
            {inputElement}
            
        </div>
    );

};

export default input;