import { Controller } from '@hotwired/stimulus';
  

  export default class extends Controller {
  	static targets = ['source'];
  

  	connect() {
  		document.addEventListener(
  			'DOMContentLoaded',
  			this.applyFormattingToPreBlocks()
  		);
  	}
 
  	applyFormattingToPreBlocks = () => {
  		const trixElements = document.querySelectorAll('.trix-content');
  		trixElements.forEach((trixElement) => {
  			const preElements = trixElement.querySelectorAll('pre');
  			preElements.forEach((preElement) => {
  				if (preElement.length !== 0) {
  					const regex = /(?!lang\-\\w\*)lang-\w*\W*/gm;
  					const codeElement = document.createElement('code');
  					if (preElement.childNodes.length > 1) {
  						console.error(
  							'<pre> element contained nested inline elements (probably styling) and could not be processed. Please remove them and try again.'
  						);
  					}
  					let preElementTextNode = preElement.removeChild(
  						preElement.firstChild
  					);
  					let language = preElementTextNode.textContent.match(regex);
  					if (language) {
  						language = language[0].toString().trim();
  						preElementTextNode.textContent =
  							preElementTextNode.textContent.replace(language, '');
							if (language === "lang-bash"){
								codeElement.classList.add(language);
							} else {
								codeElement.classList.add(language, 'line-numbers');
							}
  						
  					}
  					codeElement.append(preElementTextNode);
  					preElement.append(codeElement);
  				}
  			});
 		});
  	};
  }