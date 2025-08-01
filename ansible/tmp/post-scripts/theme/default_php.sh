#!/bin/bash

CUR_DIR=$PWD
cd $DRIVE_DIR

mkdir themes/$THEME_NAME
rm -f themes/example/core/img/*
cp -r themes/example/* themes/$THEME_NAME

echo "##Setting default theme"
sudo -u www-data php occ config:system:set theme --value=$THEME_NAME
cat > themes/$THEME_NAME/defaults.php << EOF
<?php
/**
 * @author Björn Schießle <schiessle@owncloud.com>
 * @author Jan-Christoph Borchardt, http://jancborchardt.net
 * @copyright Copyright (c) 2016, ownCloud, Inc.
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

class OC_Theme {

	/**
	 * Returns the base URL
	 * @return string URL
	 */
	public function getBaseUrl() {
		return 'https://nextcloud.com';
	}

	/**
	 * Returns the documentation URL
	 * @return string URL
	 */
	public function getDocBaseUrl() {
		return 'https://docs.nextcloud.com';
	}

	/**
	 * Returns the title
	 * @return string title
	 */
	public function getTitle() {
		return 'Irex Drive';
	}

	/**
	 * Returns the short name of the software
	 * @return string title
	 */
	public function getName() {
		return 'Irex Drive';
	}

	/**
	 * Returns the short name of the software containing HTML strings
	 * @return string title
	 */
	public function getHTMLName() {
		return 'Irex Drive';
	}

	/**
	 * Returns entity (e.g. company name) - used for footer, copyright
	 * @return string entity name
	 */
	public function getEntity() {
		return 'Irex';
	}

	/**
	 * Returns slogan
	 * @return string slogan
	 */
	public function getSlogan() {
		return 'Your irex drive, personalized for you!';
	}

	/**
	 * Returns logo claim
	 * @return string logo claim
	 * @deprecated 13.0.0 not used anymore
	 */
	public function getLogoClaim() {
		return '';
	}

	/**
	 * Returns short version of the footer
	 * @return string short footer
	 */
	public function getShortFooter() {
		\$footer = '© ' . date('Y') . ' <a href="' . \$this->getBaseUrl() . '" target="_blank">' . \$this->getEntity() . '</a>' .
			'<br/>' . \$this->getSlogan();

		return \$footer;
	}

	/**
	 * Returns long version of the footer
	 * @return string long footer
	 */
	public function getLongFooter() {
		\$footer = '© ' . date('Y') . ' <a href="' . \$this->getBaseUrl() . '" target="_blank">' . \$this->getEntity() . '</a>' .
			'<br/>' . \$this->getSlogan();

		return \$footer;
	}

	/**
	 * Generate a documentation link for a given key
	 * @return string documentation link
	 */
	public function buildDocLinkToKey(\$key) {
		return \$this->getDocBaseUrl() . '/server/15/go.php?to=' . \$key;
	}


	/**
	 * Returns mail header color
	 * @return string
	 */
	public function getColorPrimary() {
		return '#745bca';
	}

	/**
	 * Returns variables to overload defaults from core/css/variables.scss
	 * @return array
	 */
	public function getScssVariables() {
		return [
			'color-primary' => '#745bca'
		];
	}
}
EOF
cd $CUR_DIR
