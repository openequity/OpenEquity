// @material-ui/icons
import Dashboard from "@material-ui/icons/Dashboard";

import Assignment from "@material-ui/icons/Assignment";
// core components/views


import LibraryBooks from "@material-ui/icons/LibraryBooks";

import HistoryContainer from "../views/History/HistoryContainer";
import CoinContainer from "../views/CoinCreation/CoinContainer";

const routes = [
  
  {
    path: "/transaction-history",
    sidebarName: "History",
    navbarName: "History",
    icon: LibraryBooks,
    component: HistoryContainer
  },
  {
    path: "/CreateCoin",
    sidebarName: "Coin Creation",
    navbarName: "Coin Creation",
    icon: LibraryBooks,
    component: CoinContainer
  },
  { redirect: true, path: "/", to: "/home", navbarName: "Redirect" }
];

export default routes;
