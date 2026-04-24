Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75932C0F69;
	Fri, 24 Apr 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052942; cv=none; b=kr9zieINd+NLsvh/GquAy/Vjhi3gyoWvhYSV87U2qZmidAgw8ZQ1Kj8FWdt3evnFCy4rNVSBIGTIfIMnKB/akUBbYtpswLv4iWipT240Emyqtoz1A4Ccb1fQ8MxuoW/edntqrvlk1Vijj6y8l6SYugJgkomqw0ik6EhQMAL4bQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052942; c=relaxed/simple;
	bh=kQpXIVgVCV4fISNoHIQtgbvP1EXllhQ2T3mIJ8cRNro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSJ9dKqfE7EBozwjIOKaNeHveC5IyTT39T0IH/Jo9Ao5NqgpxFrkjv+hyJJRyPLZ6inY+L62N4o+kaAyUMjQsvSh2mCE9Cba4koP4Z2xOtNxepIuTBYIByoIVd6QikRQdC/BdsRkkyMpKgSa3r6IjC3nCL5NnHZ3HpeHX7H2DlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sA7gH+Fn; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SK+D8ac0; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sA7gH+Fn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SK+D8ac0"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g2L6x6Bt3z9spW;
	Fri, 24 Apr 2026 19:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777052937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kQpXIVgVCV4fISNoHIQtgbvP1EXllhQ2T3mIJ8cRNro=;
	b=sA7gH+FngvczjarD1Tbb6PMFak20PWNxDbkqseniXZs+8QP3xpEuvgwReAG4J+PFdNl5GM
	b89YykHJSGUcM7lC+lgj6zlTdRk54bZRiaxpMbW7DfWoR7XLIuq9ezyqo70QE4X05H8N4z
	WK3gK4WK+HuJzJMh4Wsr86QsWnQUjLJr9+Mcic5BtOsW4+6zZbQfElWpmmVd19Rup6BxOF
	G4826WZgodQbSmk/vi7l8Sg1c1N7JG8djJPql/xtRH8aG84T4s1lkwHWLo/U7Tw1GGzEDi
	WrEamYqbj+UuOgCSj4UgnRkTId/5WRPnlzuuiHdKcMtwwz15Jpba+rHJbYgsvg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777052935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kQpXIVgVCV4fISNoHIQtgbvP1EXllhQ2T3mIJ8cRNro=;
	b=SK+D8ac0yLSSdvohGV7owNyki6lMVoJQIzG6m1Nt3gyrX9dzmoQMlO2EsYgDh2KvmlR/3G
	Ky/jgJTC6EvnCq3j41LrqGLzTORmrqq3+msayHySfXLGg4ZAEccf05anBIXzoeEf+uMT/1
	fTzT7buEyY6zSICe5vhyLmnhOzFcr1WZJeI6x/8o9SiWSuGNcD/x9FmqjOuo1N2h9d2MRg
	Y7QJHh2AYZ6wOFgZHJ3e5gYExnb6+Z+GH/P6nPvev2FoJvAFxlcpuGJAtAvvj4BetjDjNp
	SGyH1RzYojU/NuSKy2z12Cm/2dklgBHerrwsnQqQ6kISt9SM9rxgx+2NLNL9cw==
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
Subject: [PATCH v3 0/3] Documentation: adopt new coding style of type-aware kmalloc-family
Date: Fri, 24 Apr 2026 19:47:44 +0200
Message-ID: <20260424174743.257951-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fzthp35po1ukxbt6fwqeub7xbmjx4tas
X-MBO-RS-ID: ce45d6f12d0da57349b

Update the documentation to reflect new type-aware kmalloc-family as
suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

On Tue, 2026-04-21 at 19:55 +0200, Manuel Ebner wrote:
> I have also thought about adding a few cases to checkpatch.pl, but this
> will take me more time, and i want to get this series finished.
I can't do it, i don't have the knowledge in Perl and Regex.

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
