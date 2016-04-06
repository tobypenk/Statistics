$(document).ready(function(){
    
    var mtcars = [];
    
    // Would be super cool if this were sorted by mpg
    var mtCarsData = d3.csv("mtcars.csv")
        .row(function(datum) {return datum;})
        .get(function(error, rows) {
            console.log(rows.length);
            sortRows(rows,"mpg");
            sortRows(mtcars,"cyl");
            console.log(mtcars);
            makeBars(mtcars);
        });
        
    function sortRows(rows,factor) {
        
        mtcars = [];
        
        for (var i in rows) {
            
            var finished = false;
            
            if (mtcars.length === 0) {
                
                mtcars.push(rows[i]);
            } else {
                
                for (j in mtcars) {
                    
                    if (parseFloat(rows[i][factor]) <= parseFloat(mtcars[j][factor])) {
                        mtcars.splice(j,0,rows[i]);
                        finished = true;
                        break;
                    }
                }
                
                if (finished === false) {
                    mtcars.push(rows[i]);
                }
            }
        }
        mtcars = mtcars.reverse();
        console.log(mtcars);
    }
        
    var textHeight = "11px";

    function makeBars(rows) {
        // Makes bars of mpg for all entries in the mtcars data set
        
        var barWidth = 24;
        var width = (barWidth + 3) * rows.length;
        var padding = 20;
        var height = 200;
        var hCyl = 100;
        var hHp = 60;
        
        var x = d3.scale.linear()
            .domain([0,rows.length])
            .range([0,width]);
        
        var y = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.mpg;})])
            .rangeRound([0,height]);
            
        var yCyl = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.cyl;})])
            .range([0,hCyl]);
            
        var yHp = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.hp;})])
            .range([0,hHp]);
            
        var barDemo = d3.select("#chart1")
            .append("svg")
            .attr("class","canvas")
            .attr("width",width)
            .attr("height",height+padding)
            .attr("overflow","visible");
            
        barDemo.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("class","bar")
            .attr("data-factor","mpg")
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
            .attr("y", function(datum) { return height + padding - 6; })
            .attr("dx", -barWidth/2)
            .attr("dy", "-7px")
            .attr("text-anchor","middle")
            .text(function(datum) {return datum.mpg;})
            .attr("fill","tomato")
            .attr("font-size",textHeight)
            .attr("data-index", function(datum, index) { return index; });
        
        var barBottom = d3.select("#chart2")
            .append("svg")
            .attr("class","canvas2")
            .attr("width",width)
            .attr("height",hCyl+padding)
            
        barBottom.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("data-factor","cyl")
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
            .attr("y", function(datum) { return "2px"; })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","tomato")
            .text(function(datum) {return datum.cyl;})
            .attr("data-index", function(datum, index) { return index; });
            
        var barOrthogonalTop = d3.select("#chart4")
            .append("svg")
            .attr("class","canvas3")
            .attr("width",width)
            .attr("height",hCyl+padding);
            
        barOrthogonalTop.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("data-factor","gear")
            .attr("class","bar")
            .attr("x", function(datum,index) { return x(index); })
            .attr("y", function(datum) { return yCyl(datum); })
            .attr("height", function(datum) { return yCyl(datum.gear); })
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; });
            
        barOrthogonalTop.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) { return x(index) + barWidth; })
            .attr("y", function(datum) { return 2; })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","tomato")
            .text(function(datum) {return datum.gear;})
            .attr("data-index", function(datum, index) { return index; });
            
        var barOrthogonalBottom = d3.select("#chart3")
            .append("svg")
            .attr("class","canvas3")
            .attr("width",width)
            .attr("height",height+padding);
            
        barOrthogonalBottom.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("data-factor","hp")
            .attr("class","bar")
            .attr("x",function(datum,index) { return x(index); })
            .attr("y",function(datum) {return height - yHp(datum.hp) + padding; })
            .attr("height", function(datum) { return yHp(datum.hp); })
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; } );
            
        barOrthogonalBottom.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) { return x(index) + barWidth; })
            .attr("y", function(datum) { return height - padding + 6; })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","tomato")
            .text(function(datum) {return datum.hp;})
            .attr("data-index", function(datum, index) { return index; });
            
    }
    
    
    
    $(".flipButton").click(function() {
        $(".flipperWrapper").toggleClass("flipped");
    });
    
    $(document).on("click",".bar",function() {
        console.log($(this).attr("data-factor"));
        $(".chart").html("");
        sortRows(mtcars,$(this).attr("data-factor"));
        makeBars(mtcars);
        
        $(this).addClass("highlighted");
    });
    
    
    
    /*
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
        $(".barText").attr("fill","tomato");
        $(".barText").attr("font-size",textHeight);
    });
    */
});