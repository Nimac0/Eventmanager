<?php
class DataHandler
{
    public function createEvent($param)
    {
        require_once('dbaccess.php');
            $con = new mysqli($host, $user, $password, $database);
        if ($con->connect_errno) {
            echo "Failed to connect to MySQL: " . $con->connect_error;
            exit();
        }
        $stmt = $con->prepare("INSERT INTO event (eventName, creator, place, description, dueDate) VALUES (?, ?, ?, ?, ?);");
        $stmt->bind_param("sssss", $param["eventName"], $param["creator"], $param["place"], $param["description"], $param["dueDate"]);
        $stmt->execute();
        $id = $stmt->insert_id;

        if (!isset($param["appointment"]))
            return $this->getEventDetails($id);
        foreach($param["appointment"] as $appointment)
        {
            $this->createAppointment($appointment, $id, $con);
        }
        return $this->getEventDetails($id);
    }

    public function createAppointment($date, $id, $con)
    {
        $stmt = $con->prepare("INSERT INTO appointment (date, eventId) VALUES (?, ?)");
        $stmt->bind_param("si", $date, $id);
        $stmt->execute();
    }

    public function addVote($param)
    {
        require_once('dbaccess.php');
        $con = new mysqli($host, $user, $password, $database);
        if ($con->connect_errno) {
            echo "Failed to connect to MySQL: " . $con->connect_error;
            exit();
        }
        $userId = $this->createUser($param["username"], $con);
        $appointmentId = $param["appointmentId"];
        $stmt = $con->prepare("INSERT INTO uservote (available, appointmentId, userId) VALUES (?, ?, ?)");
        $stmt->bind_param("iii", $param["available"], $appointmentId, $userId);
        $stmt->execute();
        $eventId = $con->query("SELECT eventId FROM appointment WHERE id = $appointmentId");
        $this->addComment($param["comment"], $userId, $eventId, $con);
    }

    public function createUser($username, $con)
    {
        $stmt = $con->prepare("INSERT INTO user (username) VALUES (?)");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $id = $stmt->insert_id;
        return $id;
    }

    public function addComment($comment, $userId, $eventId, $con)
    {
        $stmt = $con->prepare("INSERT INTO comment (comment, userId, EventId) VALUES (?, ?, ?)");
        $stmt->bind_param("sii", $comment, $userId, $eventId);
        $stmt->execute();
    }

    public function getEvents()
    {
        require_once('dbaccess.php');
        $con = new mysqli($host, $user, $password, $database);
        if ($con->connect_errno) {
            echo "Failed to connect to MySQL: " . $con->connect_error;
            exit();
        }
        
        $result = $con->query("SELECT * FROM event");

        $array = array();
        while($row = $result->fetch_assoc()) {
            $array[] = $row;
        }
        return $array;
    }

    public function getEventDetails($eventId)
    {
        require('dbaccess.php');
        $con = new mysqli($host, $user, $password, $database);
        if ($con->connect_errno) {
            echo "Failed to connect to MySQL: " . $con->connect_error;
            exit();
        }
        $result = $con->query("SELECT * FROM event WHERE id = '$eventId'");
        $appointments = $con->query("SELECT * FROM appointment WHERE eventId = '$eventId'");
        $comments =  $con->query("SELECT comment FROM comment WHERE eventId = '$eventId'");
        $appointmentArray = array();
        $commentArray = array();
        while($row = $appointments->fetch_assoc()) {
            $appointmentArray[] = $row;
        }
        while($row = $comments->fetch_assoc()) {
            $commentArray[] = $row;
        }
        $eventDetails = $result->fetch_assoc();
        $eventDetails['appointments'] = $appointmentArray;
        $eventDetails['comments'] = $commentArray;
        return $eventDetails;
    }
}




