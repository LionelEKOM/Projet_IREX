#!/bin/bash
source conf.defaults
echo "##Setting $THEME_NAME theme css"

cp $PWD/post-scripts/theme/img/* $DRIVE_DIR/themes/$THEME_NAME/core/img
cat > $DRIVE_DIR/themes/$THEME_NAME/core/css/server.css << EOF
/**
 * @author Jan-Christoph Borchardt, http://jancborchardt.net
 * @copyright Copyright (c) 2015, ownCloud, Inc.
 * @license AGPL-3.0
 *
 * This code is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License, version 3,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License, version 3,
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */


/* header color */
/* this is the main brand color */
#body-user #header,
#body-settings #header,
#body-public #header {
	background-color: #745bca;
}

/* log in screen background color */
/* gradient of the header color and a brighter shade */
/* can also be a flat color or an image */
#body-login {
	background: #745bca; /* Old browsers */
	background: -moz-linear-gradient(top, #947bea 0%, #745bca 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#947bea), color-stop(100%,#745bca)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, #947bea 0%,#745bca 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, #947bea 0%,#745bca 100%); /* Opera11.10+ */
	background: -ms-linear-gradient(top, #947bea 0%,#745bca 100%); /* IE10+ */
	background: linear-gradient(top, #947bea 0%,#745bca 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#947bea', endColorstr='#745bca',GradientType=0 ); /* IE6-9 */
}

/* primary action button, use sparingly */
/* header color as border, brighter shade again, here as background */
.primary,
input[type="submit"].primary,
input[type="button"].primary,
button.primary,
.button.primary,
.primary:active,
input[type="submit"].primary:active,
input[type="button"].primary:active,
button.primary:active,
.button.primary:active {
	border-color: #745bca;
	background-color: #947bea;
}
.primary:hover,
input[type="submit"].primary:hover,
input[type="button"].primary:hover,
button.primary:hover,
.button.primary:hover,
.primary:focus,
input[type="submit"].primary:focus,
input[type="button"].primary:focus,
button.primary:focus,
.button.primary:focus {
	background-color: #8b75e4;
}
.primary:active, input[type="submit"].primary:active, input[type="button"].primary:active, button.primary:active, .button.primary:active,
.primary:disabled, input[type="submit"].primary:disabled, input[type="button"].primary:disabled, button.primary:disabled, .button.primary:disabled,
.primary:disabled:hover, input[type="submit"].primary:disabled:hover, input[type="button"].primary:disabled:hover, button.primary:disabled:hover, .button.primary:disabled:hover,
.primary:disabled:focus, input[type="submit"].primary:disabled:focus, input[type="button"].primary:disabled:focus, button.primary:disabled:focus, .button.primary:disabled:focus {
	background-color: #745bca;
}

/* use logos from theme */
#header .logo,
#firstrunwizard .logo {
	background-image: url('../img/logo-64.png') !important;
	width: 256px !important;
	height: 128px !important;
}
#header .logo-icon {
	background-image: url('../img/logo-64.png') !important;
	width: 62px !important;
	height: 34px !important;
}
EOF
