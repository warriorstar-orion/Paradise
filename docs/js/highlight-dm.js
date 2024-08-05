// This is a grammar for highlight.js used by mdbook.
//
// - Guide on writing highlighters: https://highlightjs.readthedocs.io/en/latest/language-guide.html
// - possible values for `scope`/`className`: https://highlightjs.readthedocs.io/en/latest/css-classes-reference.html

hljs.registerLanguage('Dream Maker', (hljs) => ({
	name: 'dm',
	aliases: ['DM', 'dm'],
	keywords: {
		keyword:
			'sleep spawn break continue do else for goto if return switch while try catch throw'
			+ 'const var proc return break stop input'
			+ 'while break continue '
			+ 'switch case default list',
		literal: 'TRUE FALSE null DM_BUILD DM_VERSION __FILE__ __LINE__ __MAIN__ DEBUG FILE_DIR',
		built_in: 'usr world src args vars',
	},
	contains: [
		hljs.QUOTE_STRING_MODE,
		hljs.C_NUMBER_MODE,
		hljs.C_BLOCK_COMMENT_MODE,
		hljs.C_LINE_COMMENT_MODE,
		{
			className: 'operator',
			begin: /\bin\b|\bas\b|\bto\b/,
		},
		{
			className: 'string',
			begin: '\'',
			end: '\'',
			contains: [hljs.BACKSLASH_ESCAPE],
			relevance: 0
		},
		{
			className: 'meta',
			begin: /^\s*#\s*[a-z]+\b/,
			end: /$/,
			keywords: {
				keyword: 'if else elif endif define undef warning error line ifdef ifndef include'
			}
		},
		{
			className: 'built_in',
			beginKeywords: 'datum obj atom area movable mob turf',
			end: /[\/\s]/,
			excludeEnd: true,
		}
	]
}));

hljs.initHighlightingOnLoad();
