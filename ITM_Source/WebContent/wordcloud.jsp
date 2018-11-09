<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet"  href="css/jqcloud.min.css" media="screen,projection">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/jquery-3.1.0.js"></script>
<script src="js/plotly-latest.min.js"></script>
<script src="js/websocket.js?id=#2ad$d"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.sessionTimeout.js"></script>
<script src="js/itm.js"></script>

</head>
<body>
<div id="jot-compile-content">

</div>


<script src="js/jqcloud.min.js"></script>
<script type="text/javascript">
console.log("inner iframe")

var problem  = window.parent.problem.replace(/<\/?.+?>/g,"")
var idea = window.parent.idea.replace(/<\/?.+?>/g,"")
var more =window.parent.more.replace(/<\/?.+?>/g,"")
console.log(problem)
console.log(idea)
console.log(more)
var pattern = /\w+/g, string = problem + idea + more;

					var matchedWords = string.match(pattern);
		
					var counts = matchedWords.reduce(function(stats, word) {
						if (stats.hasOwnProperty(word)) {
							stats[word] = stats[word] + 1;
						} else {
							stats[word] = 1;
						}
						return stats;
		
					}, {});
		
					stopwords = [ 'a', 'about', 'above', 'across', 'after', 'afterwards', 'again',
							'against', 'all', 'almost', 'alone', 'along', 'already', 'also',
							'although', 'always', 'am', 'among', 'amongst', 'amoungst', 'amount',
							'an', 'and', 'another', 'any', 'anyhow', 'anyone', 'anything',
							'anyway', 'anywhere', 'are', 'around', 'as', 'at', 'back', 'be',
							'became', 'because', 'become', 'becomes', 'becoming', 'been', 'before',
							'beforehand', 'behind', 'being', 'below', 'beside', 'besides',
							'between', 'beyond', 'bill', 'both', 'bottom', 'but', 'by', 'call',
							'can', 'cannot', 'cant', 'co', 'computer', 'con', 'could', 'couldnt',
							'cry', 'de', 'describe', 'detail', 'did', 'do', 'done', 'down', 'due',
							'during', 'each', 'eg', 'eight', 'either', 'eleven', 'else',
							'elsewhere', 'empty', 'enough', 'etc', 'even', 'ever', 'every',
							'everyone', 'everything', 'everywhere', 'except', 'few', 'fifteen',
							'fifty', 'fill', 'find', 'fire', 'first', 'five', 'for', 'former',
							'formerly', 'forty', 'found', 'four', 'from', 'front', 'full',
							'further', 'get', 'give', 'go', 'had', 'has', 'hasnt', 'have', 'he',
							'hence', 'her', 'here', 'hereafter', 'hereby', 'herein', 'hereupon',
							'hers', 'herself', 'him', 'himself', 'his', 'how', 'however',
							'hundred', 'i', 'ie', 'if', 'in', 'inc', 'indeed', 'interest', 'into',
							'is', 'it', 'its', 'itself', 'keep', 'last', 'latter', 'latterly',
							'least', 'less', 'ltd', 'made', 'many', 'may', 'me', 'meanwhile',
							'might', 'mill', 'mine', 'more', 'moreover', 'most', 'mostly', 'move',
							'much', 'must', 'my', 'myself', 'name', 'namely', 'neither', 'never',
							'nevertheless', 'next', 'nine', 'no', 'nobody', 'none', 'noone', 'nor',
							'not', 'nothing', 'now', 'nowhere', 'of', 'off', 'often', 'on', 'once',
							'one', 'only', 'onto', 'or', 'other', 'others', 'otherwise', 'our',
							'ours', 'ourselves', 'out', 'over', 'own', 'part', 'per', 'perhaps',
							'please', 'put', 'rather', 're', 's', 'same', 'see', 'seem', 'seemed',
							'seeming', 'seems', 'serious', 'several', 'she', 'should', 'show',
							'side', 'since', 'sincere', 'six', 'sixty', 'so', 'some', 'somehow',
							'someone', 'something', 'sometime', 'sometimes', 'somewhere', 'still',
							'such', 'system', 'take', 'ten', 'than', 'that', 'the', 'their',
							'them', 'themselves', 'then', 'thence', 'there', 'thereafter',
							'thereby', 'therefore', 'therein', 'thereupon', 'these', 'they',
							'thick', 'thin', 'third', 'this', 'those', 'though', 'three', 'three',
							'through', 'throughout', 'thru', 'thus', 'to', 'together', 'too',
							'top', 'toward', 'towards', 'twelve', 'twenty', 'two', 'un', 'under',
							'until', 'up', 'upon', 'us', 'very', 'via', 'was', 'we', 'well',
							'were', 'what', 'whatever', 'when', 'whence', 'whenever', 'where',
							'whereafter', 'whereas', 'whereby', 'wherein', 'whereupon', 'wherever',
							'whether', 'which', 'while', 'whither', 'who', 'whoever', 'whole',
							'whom', 'whose', 'why', 'will', 'with', 'within', 'without', 'would',
							'yet', 'you', 'your', 'yours', 'yourself', 'yourselves', 'yes' ]
		
					/* Now that `counts` has our object, we can log it. */
					stopwords.forEach(function(element) {
						delete counts[element];
					});
					
		
					for ( var key in counts) {
						if (key.slice(0, -1) in counts)
							delete counts[key];
						else if (key.slice(0, -2) in counts)
							delete counts[key];
					}
		
					var ttt = [];
					for ( var key in counts) {
						// ttt.push({text: words[j], weight: parseFloat(weights[j])*100});
						ttt.push({
							text : key,
							weight : counts[key]
						});
					}
					console.log(ttt);
					newdiv = $('<div class="center-align"></div>').jQCloud(ttt, {
						  width: window.parent.innerWidth-80,
						  height: window.parent.innerHeight-150
						});
					$("#jot-compile-content").append(newdiv);
					
			
</script>
</body>
</html>