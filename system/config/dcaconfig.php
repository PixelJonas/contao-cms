<?php

// HTML in Überschriften
$GLOBALS['TL_DCA']['tl_content']['fields']['headline']['eval']['allowHtml'] = true;

// Module
$GLOBALS['TL_DCA']['tl_module']['fields']['headline']['eval']['allowHtml'] = true;

// Bildunterschriften
$GLOBALS['TL_DCA']['tl_content']['fields']['caption']['eval']['allowHtml'] = true;

// in News-Archiv-Titel
$GLOBALS['TL_DCA']['tl_news_archive']['fields']['title']['eval']['allowHtml'] = true;

$GLOBALS['TL_DCA']['tl_form_field']['fields']['label']['eval']['allowHtml'] = true;
$GLOBALS['TL_DCA']['tl_form_field']['fields']['label']['eval']['maxlength'] = 800;
$GLOBALS['TL_DCA']['tl_form_field']['fields']['label']['sql'] = "varchar(800) NOT NULL default ''";


// Bildunterschrift mehr Zeichen
$GLOBALS['TL_DCA']['tl_content']['fields']['caption']['sql']="varchar(800) NOT NULL default ''";
$GLOBALS['TL_DCA']['tl_content']['fields']['caption']['eval']['maxlength'] = 800;


// Meta-Felder Zeichenanzahl hochsetzen
$GLOBALS['TL_DCA']['tl_files']['fields']['meta']['eval']['metaFields']['title'] = 'maxlength="1000"';
$GLOBALS['TL_DCA']['tl_files']['fields']['meta']['eval']['metaFields']['alt'] = 'maxlength="1000"';
$GLOBALS['TL_DCA']['tl_files']['fields']['meta']['eval']['metaFields']['caption'] = 'maxlength="1000"';
