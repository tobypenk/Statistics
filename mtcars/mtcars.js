$(document).ready(function(){
    
    var loggingMousePosition = false;
    var mouseDownY = 0;
    var pxChange = 0;
    
    $(document).mousedown(function(e){
        loggingMousePosition = true;
        mouseDownY = e.pageY;
    });
    
    $(document).mouseup(function() {
        loggingMousePosition = false;
        mouseDownY = 0;
        pxChange = 0;
    })
    
    var canvas1RotateX = 0;
    var canvas2RotateX = 90;
    
    $(document).mousemove(function(e) {
        if (loggingMousePosition) {
            pxChange = mouseDownY - e.pageY;
            canvas1RotateX += pxChange;
            canvas2RotateX += pxChange;
            
            if (canvas1RotateX <= -90) {
                canvas1RotateX = -90;
                canvas2RotateX = 0;
            }
            if (canvas1RotateX >= 0) {
                canvas1RotateX = 0;
                canvas2RotateX = 90;
            }
            
            var newVal1 = "rotateX("+canvas1RotateX+"deg)";
            var newVal2 = "rotateX("+canvas2RotateX+"deg)";
            $(".canvas1").css({
                transform:newVal1
            });
            $(".canvas2").css({
                transform:newVal2
            });
            mouseDownY = e.pageY;
        }
    });
    
    var mtcars = [];
    
    d3.csv("mtcars.csv")
        .row(function(datum) {return datum;})
        .get(function(error, rows) {
            rows = parseNums(rows);
            console.log(rows);
            sortRows(rows,"mpg");
            sortRows(mtcars,"cyl");
            console.log(mtcars);
            makeBars(mtcars);
        });
        
    function parseNums(rows) {
        for (var i in rows) {
            rows[i]["hp"] = parseFloat(rows[i]["hp"]);
            rows[i]["mpg"] = parseFloat(rows[i]["mpg"]);
            rows[i]["cyl"] = parseInt(rows[i]["cyl"]);
            rows[i]["gear"] = parseInt(rows[i]["gear"]);
        }
        return(rows);
    }
        
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
    }
    
    var textHeight = "11px";
    
    function makeBars(rows) {
        
        var width = 800;
        var barSpace = 2
        var barWidth = (width - barSpace*rows.length + barSpace)/rows.length;
        var height = 150;
        
        var x = d3.scale.linear()
            .domain([0,rows.length])
            .range([0,width]);
        
        var y = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.mpg;})])
            .rangeRound([0,height]);
            
        var yCyl = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.cyl;})])
            .rangeRound([0,height]);
            
        var yGear = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.gear;})])
            .rangeRound([0,height]);
            
        var yHp = d3.scale.linear()
            .domain([0,d3.max(rows,function(datum) {return datum.hp;})])
            .rangeRound([0,height]);
            
        var barTop = d3.select(".chart1")
            .append("svg")
            .attr("class","svg")
            .attr("width",width)
            .attr("height",height);
            
        barTop.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("class","bar")
            .attr("data-factor","mpg")
            .attr("x", function(datum,index) {return x(index);})
            .attr("y", function(datum) {return height - y(datum.mpg);})
            .attr("height", function(datum) { return y(datum.mpg);})
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; })
            .style("stroke", "tomato")
       		.style("stroke-width", 1);
            
        barTop.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) {return x(index) + barWidth;})
            .attr("y", function(datum) { return height - 6; })
            .attr("dx", -barWidth/2)
            .attr("dy", "-7px")
            .attr("text-anchor","middle")
            .text(function(datum) {return datum.mpg;})
            .attr("fill","tomato")
            .attr("font-size",textHeight)
            .attr("data-index", function(datum, index) { return index; });
            
        var barBottom = d3.select(".chart2")
            .append("svg")
            .attr("class","svg")
            .attr("width",width)
            .attr("height",height)
            
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
            .attr("data-index", function(datum, index) { return index; })
            .style("stroke", "tomato")
       		.style("stroke-width", 1);
            
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
            
        var barOrthogonalTop = d3.select(".chart3")
            .append("svg")
            .attr("class","svg")
            .attr("width",width)
            .attr("height",height);
            
        barOrthogonalTop.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("data-factor","gear")
            .attr("class","bar")
            .attr("x", function(datum,index) { return x(index); })
            .attr("y", function(datum) { return height - yGear(datum.gear); })
            .attr("height", function(datum) { return yGear(datum.gear); })
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; })
            .style("stroke", "tomato")
       		.style("stroke-width", 1);
            
        barOrthogonalTop.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) { return x(index) + barWidth; })
            .attr("y", function(datum) { return height-25; })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","tomato")
            .text(function(datum) {return datum.gear;})
            .attr("data-index", function(datum, index) { return index; });
            
        var barOrthogonalBottom = d3.select(".chart4")
            .append("svg")
            .attr("class","svg")
            .attr("width",width)
            .attr("height",height);
            
        barOrthogonalBottom.selectAll("rect")
            .data(rows)
            .enter()
            .append("svg:rect")
            .attr("data-factor","hp")
            .attr("class","bar")
            .attr("x",function(datum,index) { return x(index); })
            .attr("y",function(datum) {return 0; })
            .attr("height", function(datum) { return yHp(datum.hp); })
            .attr("width", barWidth)
            .attr("fill","#000000")
            .attr("data-index", function(datum, index) { return index; } )
            .style("stroke", "tomato")
       		.style("stroke-width", 1);
            
        barOrthogonalBottom.selectAll("text")
            .data(rows)
            .enter()
            .append("svg:text")
            .attr("class","barText")
            .attr("x", function(datum,index) { return x(index) + barWidth; })
            .attr("y", function(datum) { return 6; })
            .attr("text-anchor","middle")
            .attr("font-size",textHeight)
            .attr("dx",-barWidth/2)
            .attr("dy","15px")
            .attr("fill","tomato")
            .text(function(datum) {return datum.hp;})
            .attr("data-index", function(datum, index) { return index; });
            
    }
    
    $(document).on("mouseenter",".bar, .barText",function() {
        
        $("rect").attr("fill","black");
        
        var thisIndex = $(this).attr("data-index");
        $("rect[data-index="+thisIndex+"]").attr("fill","white");
        $("text[data-index="+thisIndex+"]");
        
    });
    
    $(document).on("mouseleave",".bar",function() {
        
        $("rect").attr("fill","black");
    });
    
    $(document).on("click",".sorter",function() {
        var thisFactor = $(this).parent().attr("data-factor");
        
        sortRows(mtcars,thisFactor);
        
        $(".chart").html("<section class='sorter'></section>");
        
        makeBars(mtcars);
    });
    
});