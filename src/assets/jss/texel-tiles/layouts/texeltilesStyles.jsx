import {
  drawerWidth,
  transition,
  container
} from "../../texel-tiles";

const texeltilesStyles = theme => ({
  wrapper: {
    position: "relative",
    top: "0",
    height: "100vh"
  },
  mainPanel: {
    backgroundColor:"#E4F3C",
    [theme.breakpoints.up("md")]: {
      width: `calc(100% - ${drawerWidth}px)`
    },
    overflow: "auto",
    position: "relative",
    float: "right",
    ...transition,
    maxHeight: "100%",
    width: "100%",
    overflowScrolling: "touch"
    
  },
  content: {
    backgroundColor:"#E4F3C",
    marginTop: "70px",
    padding: "30px 15px",
    minHeight: "calc(100vh - 123px)"
  },
  container,
  map: {
    marginTop: "70px",
    backgroundColor:"#E4F3C"
  }
});

export default texeltilesStyles;
