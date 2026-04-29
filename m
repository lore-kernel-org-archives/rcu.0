Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6142287259;
	Wed, 29 Apr 2026 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446581; cv=none; b=CVZRQeXA/vWsiBwPymJz7ZtL6DWkjWyNfmDD+sUhGD9gwDBO0O1hE5SrhlCO1VYdugi3d0fMsa2GSm3MZAV/Hte51esJQe0zhvjzB2c7Of0kIAzOMM7S7EpCdXNJHN8W3ABqZ8vGjZ79KRZNj/5LiWBYYIUnWPnj0hHDNAGg0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446581; c=relaxed/simple;
	bh=EJhBkHEX7NcpQ00immYDqBnfdLu+6YEZWr1kaPs/oBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s16ZAZcYx53ipeSzkf3+AmEMbw3ZkhFFooCws/l7zWUYW2XGyAg8Kog95Wg4LswDT4JbQbZggjPxAsKn9Z8wOBETM/wd2KcILDJzSt/6EAdVj/77Kciv2gC3mYRZEp0K1NJVSLkWRolB634W7pLhZcVzRcfZTbAw31EP59qWn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cm1UrNK2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=awKvtRvn; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cm1UrNK2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="awKvtRvn"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g57hn301Bz9v19;
	Wed, 29 Apr 2026 09:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777446569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJhBkHEX7NcpQ00immYDqBnfdLu+6YEZWr1kaPs/oBk=;
	b=cm1UrNK2iMJJFxNbNY7XoMX39vrgS0PKId/qR2ZO21EQgEKS397JDUze1GLzI6WzrsLvRO
	CuY3Bn4nWyDbLoluvOzqLLfVA6owWezodPuaSaGMI4OuqM/PDU3EKxGQ/V4y+diYzDbMMZ
	+l1sYNCUe5KPLh6Gta7dLnQe5VdTbOdguiq4T9L2A3xWRrmnA9r0xMxTtH/Y4NFGF1yVi/
	R6hOHDqAZ9AWml7xrpLGjrzRnJF2ZPZJhRhJ3Wws5Ii73UNWhE2p4FXVzngQP1cT9ow4f6
	LvQqsEWN8ENm6Gii6Dm6aLG2+Rc7ASsSPscIA1NjvhFH/b36cmzPX/P8EGKIDg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777446567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJhBkHEX7NcpQ00immYDqBnfdLu+6YEZWr1kaPs/oBk=;
	b=awKvtRvnhsBSywBXCFoyYO2QzqYzTvKe4xYMLRo60eBqjHRNpOfqxu6y0KVHrWQCk8hdCU
	zvl21II5s2BbwlWKnpaXL5Ltwr1hNoygRA3yVBQp4EII6O/JxFOehCjR0FTamsy7ruodtx
	uDkaXTs4CLvuqiTNc28DY6Su3OHBxM+ugjYqQzoeVNyBNe0048beVS3gZ7je3y7cRKWhpJ
	qrvvq4qfVcGThU54TELoLj3fJzvpjbylNqFmVfb9zaMcEus6CGhKpeserV3+BbmmjvSPBy
	XpojvX9HfPZr0QsPWfstowzWWDgsx1y9qBG3VkzvQjstebue6wEKw0bhrolgqQ==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mm@kvack.org,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v4 0/3] Documentation: adopt new coding style of type-aware kmalloc-family
Date: Wed, 29 Apr 2026 09:08:01 +0200
Message-ID: <20260429070759.309110-3-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 214930e8f274b4c9e15
X-MBO-RS-META: y7dqgagn76jnut9fzikn837x4rxj8e6i

Update the documentation to reflect new type-aware kmalloc-family as
suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

 [v3] -> [v4]:
state the default argument in deprecated.rst [3/3]

 [v2] -> [v3]:
remove obvious wrong replacements in [1/3]
add Acked-by: Paul E. McKenney in [2/3]
change how to mark the optional argument in [3/3]
add recipants
 --cc="linux-mm@kvack.org"
 --to="Kees Cook"
 --cc="Geert Uytterhoeven"

 [v1] -> [v2]:
put RCU/* in a seperate patch [Patch 2/3]
Omit optional argument (GFP_KERNEL) as suggested by https://lwn.net/Articles/1062856/
deprecated.rst: change the argument gfp to optional [Patch 3/3]

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
