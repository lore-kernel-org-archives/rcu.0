Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFF3469F5;
	Tue, 21 Apr 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794262; cv=none; b=Xj4LBdDfr5ZCRUK0+B00AAtiA5kt/J8F6R7KkDpTFsUIZM6vGegEDD5fp0FmdUAD6EOT2ArvmeCIcAhydjP77OHcwmLj+BB93npZOhx4JEpRSU/H1ORRqTMbH+twxoS4PcasJVw+WL9wHzr2f+/clwChDkwAb6q2uBuRWvporIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794262; c=relaxed/simple;
	bh=P1cosrmngf7+WjRm9EyXXEt+hBtvjPWN22h4oPz+Gvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFnRGpkKjV7kzjOY0n14a/XC6EHqNbEeYVrBkaWaqtNQc6Hgt6/mJoq6J0DYYuVeWdCJFxDliZyvlefQvE9o9NhXUG4CU3YdkPm5Sv2UGlVe07HBHS5ZMCKpUhvQeGeCy43gKcBIhZCifpwEM+bfB7pe/zr2S7BhakMgw+NUX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=njXWkc9j; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NWQIm0vI; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="njXWkc9j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NWQIm0vI"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g0VSD24hZz9spj;
	Tue, 21 Apr 2026 19:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776794252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P1cosrmngf7+WjRm9EyXXEt+hBtvjPWN22h4oPz+Gvc=;
	b=njXWkc9jAkM5jZ59AUR4gQVLYOVjJagjMJ5Lrn5W56oWZcUCQ+3j88HqMhV4mt4KogUZxQ
	VUF+jT2k+yPCzq4JFrSOuSQxRBkx9jOlII5wfcg68b7f2UdzfdO91yfq5aP8+PcNhZuxVB
	l15RB5/ZYS94dVvPKL2020MbLiCV+F+ldtlV+olmazypFmP4FLHW5QZK+HvpakC+JtuMKw
	fTEvE3yMxGZVn2XF2MsA/y9QAzKUY09dIaKgVVUhbnDCLe9EesQMguycQ79Yu4pkFshq3R
	EbRA3xP4Z7mOW6P8G7KjS1Zeyer31kd/0t68IIx/pcGaphUjLSBtjTyKJ0yJIw==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776794250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P1cosrmngf7+WjRm9EyXXEt+hBtvjPWN22h4oPz+Gvc=;
	b=NWQIm0vIqaoSev3jG2aolu1f5mBvsYdMnI5s3yM6bcbZ04i8BCAL1xrjc7V+46F9b4dYhf
	VpN/ppOgCTIlLMGz7fEIDh/nWcPQTPbFXnYUTYvnNmZ9W4ZljJHgHv9iBLFpewivoYE6Tk
	TrGyv+bib1cY7iqiuoyPaa0BrFchHoUDvdcWZAtytIhNSB2b6jEK/SprFpDjllMnm/vt/M
	dVsiQWApqbeL4xCfZUJzKoatTGvoMWm1fwQk/1W0BhnVry+/BsEWctFHryV/3XIgUKrnZI
	3mBOrbQupshp7zqLgP1888kg3GgeOXtkuHP8+30yApMWMTxsFOSB0Mk8PC8p+g==
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-media@vger.kernel.org,
	Manuel Ebner <manuelebner@mailbox.org>
Subject: [PATCH v2 0/3] Documentation: adopt new coding style of type-aware kmalloc-family
Date: Tue, 21 Apr 2026 19:55:17 +0200
Message-ID: <20260421175516.224960-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1cc28d171c1f478f232
X-MBO-RS-META: 1qp5s87d34fpqkjtcjrxj7si3uinr1if

Update the documentation to reflect new type-aware kmalloc-family as
suggested in commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")

I have also thought about adding a few cases to checkpatch.pl, but this
will take me some time, and i don't know if i can do it.

 [v1] -> [v2]:
put RCU/* in a seperate patch [Patch 2/3]
Omit optional argument (GFP_KERNEL) as suggested by https://lwn.net/Articles/1062856/
deprecated.rst: change the argument gfp to optional [Patch 3/3]

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
