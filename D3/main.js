$(document).ready(function(){
        
    var mtCarsData = d3.csv("mtcars.csv")
        .row(function(datum) {return datum;})
        .get(function(error, rows) {makeBars(rows);});

    function makeBars(rows) {
        // Makes bars of mpg for all entries in the mtcars data set
        
        var barWidth = 30;
        var width = (barWidth + 6) * rows.length;
        var height = 300;
        
        var x = d3.scale.linear()
            .domain([0,rows.length])
            .range([0,width]);
        
        var y = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.mpg;})])
            .rangeRound([0,height]);
            
        var barDemo = d3.select("#chart")
            .append("svg")
            .attr("width",width)
            .attr("height",height);
            
        barDemo.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("x", function(datum,index) {return x(index);})
            .attr("y", function(datum) {return height - y(datum.mpg);})
            .attr("height", function(datum) { return y(datum.mpg);})
            .attr("width", barWidth)
            .attr("fill","#000000");
            
        barDemo.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("x", function(datum,index) {return x(index) + barWidth;})
            .attr("y", function(datum) { return height - y(datum.mpg); })
            .attr("dx", -barWidth/2)
            .attr("dy", "1.2em")
            .attr("text-anchor","middle")
            .text(function(datum) {return datum.mpg;})
            .attr("fill","red")
            .attr("transform",function(datum,index) {
                
                var x0 = x(index);
                var y0 = height - y(datum.mpg);
                return "rotate(-90,"+x0+","+y0+")"});
            
        
    }
});