
" Only lint JS with Eslint to avoid running unnecessary linters and getting
" misleading errors.
let b:ale_linters = ['eslint']

" Have eslint ignore current line.
nnoremap <buffer> <leader>i mzO// eslint-disable-next-line<esc>`z
