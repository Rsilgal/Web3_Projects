import reactLogo from "../assets/react.svg";
import "./Header.css";

export const Header = () => {
    return(
        <div className="header">
            <img src={reactLogo}></img>
            <ul>
                <li>Home</li>
                <li>Contact</li>
                <li>About Us</li>
            </ul>
        </div>
    )
}