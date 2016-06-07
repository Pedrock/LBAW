var labels = [""];
var data_arr = [null];

for(var i = 0; i < purchases.length; i++) {
    var p = purchases[i];
    labels.push(p.month + "/" + p.year);
    data_arr.push(p.purchases);
}

labels.push("");
data_arr.push(null);

var data = {
    labels: labels,
    datasets: [
        {
            label: "Orders",
            fill: false,
            lineTension: 0,
            backgroundColor: "rgba(75,192,192,0.4)",
            borderColor: "rgba(75,192,192,1)",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "rgba(75,192,192,1)",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 5,
            pointHoverBackgroundColor: "rgba(75,192,192,1)",
            pointHoverBorderColor: "rgba(220,220,220,1)",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: data_arr,
        }
    ]
};

var myLineChart = new Chart($('canvas'), {
    type: 'line',
    data: data
});