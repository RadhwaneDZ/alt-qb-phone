SetupMechanic = function(data) {
    $(".mechanic-list").html("");

    if (data.length > 0) {
        $.each(data, function(i, mechanics){
            var element = '<div class="mechanics-list" id="mechanicsid-'+i+'"> <div class="mechanics-list-firstletter">' + (mechanics.name).charAt(0).toUpperCase() + '</div> <div class="mechanics-list-fullname">' + mechanics.name + '</div> <div class="mechanics-list-call"><i class="fas fa-phone"></i></div> </div>'
            $(".mechanic-list").append(element);
            $("#mechanicsid-"+i).data('mechanicsData', mechanics);
        });
    } else {
        var element = '<div class="mechanics-list"><div class="no-mechanic">There are no mechanic available.</div></div>'
        $(".mechanic-list").append(element);
    }
}

$(document).on('click', '.mechanics-list-call', function(e){
    e.preventDefault();

    var mechanicsData = $(this).parent().data('mechanicsData');
    
    var cData = {
        number: mechanicsData.phone,
        name: mechanicsData.name
    }

    $.post('http://qb-phone/CallContact', JSON.stringify({
        ContactData: cData,
        Anonymous: RL.Phone.Data.AnonymousCall,
    }), function(status){
        if (cData.number !== RL.Phone.Data.PlayerData.charinfo.phone) {
            if (status.IsOnline) {
                if (status.CanCall) {
                    if (!status.InCall) {
                        if (RL.Phone.Data.AnonymousCall) {
                            RL.Phone.Notifications.Add("fas fa-phone", "Phone", "You have started an anonymous call!");
                        }
                        $(".phone-call-outgoing").css({"display":"block"});
                        $(".phone-call-incoming").css({"display":"none"});
                        $(".phone-call-ongoing").css({"display":"none"});
                        $(".phone-call-outgoing-caller").html(cData.name);
                        RL.Phone.Functions.HeaderTextColor("white", 400);
                        RL.Phone.Animations.TopSlideUp('.phone-application-container', 400, -160);
                        setTimeout(function(){
                            $(".mechanic-app").css({"display":"none"});
                            RL.Phone.Animations.TopSlideDown('.phone-application-container', 400, 0);
                            RL.Phone.Functions.ToggleApp("phone-call", "block");
                        }, 450);
    
                        CallData.name = cData.name;
                        CallData.number = cData.number;
                    
                        RL.Phone.Data.currentApplication = "phone-call";
                    } else {
                        RL.Phone.Notifications.Add("fas fa-phone", "Phone", "You are already busy!");
                    }
                } else {
                    RL.Phone.Notifications.Add("fas fa-phone", "Phone", "This person is talking!");
                }
            } else {
                RL.Phone.Notifications.Add("fas fa-phone", "Phone", "This person is not available!");
            }
        } else {
            RL.Phone.Notifications.Add("fas fa-phone", "Phone", "You cannot call your own number!");
        }
    });
});