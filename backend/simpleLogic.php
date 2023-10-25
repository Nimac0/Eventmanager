<?php
include("dataHandler.php");

class SimpleLogic
{
    private $dh;
    function __construct()
    {
        $this->dh = new DataHandler();
    }

    function handleRequest($method, $param)
    {
        switch ($method) {
            case "createEvent":
                $res = $this->dh->createEvent($param);
                break;
            case "addVote":
                $res = $this->dh->addVote($param);
                break;
            case "getEvents":
                $res = $this->dh->getEvents();
                break;
            case "getEventDetails":
                $res = $this->dh->getEventDetails($param);
                break;  
            default:
                $res = "test";
                break;
        }
        return $res;
    }
}
