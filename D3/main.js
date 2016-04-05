$(document).ready(function(){
        
    var mtCarsData = d3.csv("mtcars.csv")
        .row(function(datum) {return datum;})
        .get(function(error, rows) {makeBars(rows);});
        
    var textHeight = "12px";

    function makeBars(rows) {
        // Makes bars of mpg for all entries in the mtcars data set
        
        var barWidth = 24;
        var width = (barWidth + 5) * rows.length;
        var padding = 20;
        var height = 200;
        var hCyl = 100;
        
        var x = d3.scale.linear()
            .domain([0,rows.length])
            .range([0,width]);
        
        var y = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.mpg;})])
            .rangeRound([0,height]);
            
        var yCyl = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.cyl;})])
            .range([0,hCyl]);
            
        var barDemo = d3.select("#chart")
            .append("svg")
            .attr("class","canvas")
            .attr("width",width)
            .attr("height",height+padding);
            
        barDemo.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("class","bar")
            .attr("x", function(datum,index) {return x(index);})
            .attr("y", function(datum) {return height - y(datum.mpg) + padding;})
            .attr("height", function(datum) { return y(datum.mpg);})
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; });
            
        barDemo.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) {return x(index) + barWidth;})
            .attr("y", function(datum) { return height - y(datum.mpg) + padding; })
            .attr("dx", -barWidth/2)
            .attr("dy", "-7px")
            .attr("text-anchor","middle")
            .text(function(datum) {return datum.mpg;})
            .attr("fill","red")
            .attr("font-size",textHeight)
            .attr("data-index", function(datum, index) { return index; });
        
        var barBottom = d3.select("#chart2")
            .append("svg")
            .attr("class","canvas2")
            .attr("width",width)
            .attr("height",height+padding)
            
        barBottom.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("class","bar")
            .attr("x", function(datum,index) { return x(index); })
            .attr("y", function(datum) { return yCyl(datum); })
            .attr("height", function(datum) { return yCyl(datum.cyl); })
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; });
            
        barBottom.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) { return x(index) + barWidth; })
            .attr("y", function(datum) { return yCyl(datum.cyl); })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","red")
            .text(function(datum) {return datum.cyl;})
            .attr("data-index", function(datum, index) { return index; });
    }
    
    $(document).on("mouseenter",".bar",function(){
        
        var thisIndex = $(this).attr("data-index");
        
        $("[data-index="+thisIndex+"]").each(function(){
            $(this).attr("fill","tomato");
            $(this).attr("font-size","20px");
            $(this).siblings("."+$(this).attr("class")).each(function() {
                $(this).attr("fill","#888888");
                $(this).attr("font-size",textHeight);
            });
        });
    });
    
    $(".chartContainer").mouseleave(function(){
        $(".bar").attr("fill","black");
        $(".barText").attr("fill","red");
    });
});