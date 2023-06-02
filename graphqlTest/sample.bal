import ballerina/graphql;

# A service representing a network-accessible GraphQL API
@display {
    label: "graphqlTest",
    id: "graphqlTest-97d1a1c0-2ab7-479c-a775-981e2bf658eb"
}
service / on new graphql:Listener(8090) {
    private string[] names;
    function init() {
        // Initialize the array.
        self.names = ["Walter White", "Jesse Pinkman", "Skyler White"];
    }

    # A resource for generating greetings
    # Example query:
    # query GreetWorld{ 
    # greeting(name: "World") 
    # }
    # Curl command: 
    # curl -X POST -H "Content-Type: application/json" -d '{"query": "query GreetWorld{ greeting(name:\"World\") }"}' http://localhost:8090
    #
    # + name - the input string name
    # + return - string name with greeting message or error
    resource function get greeting(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }

    remote function createUser(string name) returns string|error {
        if name is "" {
            return error("name should not be empty!");
        }
        return "User created with name: " + name;
    }

    resource function subscribe subscribe() returns stream<string> {
            return self.names.toStream();
    }
}
