Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC31DFF0
	for <rcu@vger.kernel.org>; Sat,  2 May 2026 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687071; cv=none; b=Qg8QZuh4d9ZAu1kPO4WKwS0m/SclIpGHG76SDTwyVpJ/EJuW4UtU4Sd+J9XR96ylTqFTHFr2q2cftDWrYa8vuQN8SYWYH2ya7CReeo9yqk4ZD0BRBMo+J/68dtpJ20TtstMIruUp+c3stChtjXDegqYpUK88xYtAn4bXWjJoSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687071; c=relaxed/simple;
	bh=e9NjJ2oTOBWTL04lWPefy0o983m0hca5FLJ7xqfmxUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6c+XgebbkJrIki+dniSMGpDFW5nUYDed+FJZgEhDnHRgSYP6SYUYLzGQlNxyMlk7nvB2tqxgH6nv5QjBlHQE7fvlsHJT+UcCfkLBg99NLZvl+QlzJR72qwT2qpzbzG+nWulWkoctL6bHkSAoaGZx9C8N1E8Xhaj0RnDdYQOIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4Q6bUUPr; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4Q6bUUPr"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g6rdp2Pksz1XM6Jb;
	Sat,  2 May 2026 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1777687066; x=1780279067; bh=WtzAX03o/GtbuXK0+1Um2KP58Zgbhc6FxmB
	YsUsrElc=; b=4Q6bUUPrlhHFbqVCxzudfwqcnCoP4ZuRHPvnPOQuJKlLZ5QIxnO
	RO+ihc4UZVDcd7HtkpL1vWj4BaoB69ACrPgU7TfHRGKxUCEXZ4fNgmVKzsTEGuYn
	UCYM6c9Puuyt9M8+j3N0JUSFXOjtZbjKD9WIbw8Ii5R0xeQ1fWAuk8m/LcWp3mmV
	+w+H+lq3SI/gBp5Ul2VuCODevJ8NXuAlIpzYKD2ker2jS31oO+OgUoHnUH3nK/kF
	IAOnREINh0xdcnKkAIFtyPJUXm544QWtekkKKZS6raLfqRv04vW5+O8fX4SsLGaQ
	QlLJFG3ob3RbiPeOFl3viXywBuTDa6XLaWw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2z6cdI156qDg; Sat,  2 May 2026 01:57:46 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [216.9.110.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g6rdg2M3gz1XM6J4;
	Sat,  2 May 2026 01:57:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>,
	rcu@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH] srcu: Remove check from srcu_dereference_check()
Date: Fri,  1 May 2026 18:57:32 -0700
Message-ID: <20260502015733.431424-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Users of srcu_dereference_check() must hold either an SRCU reader lock
or hold the update-side lock. __srcu_read_lock_must_hold() checks
whether the SRCU reader lock is held. Since that check is too strict,
remove it.

Fixes: f0b7ce22d718 ("srcu: Support Clang's context analysis")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/srcu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5..51864281164b 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -235,7 +235,6 @@ static inline void __srcu_read_lock_must_hold(const s=
truct srcu_struct *ssp) __m
  */
 #define srcu_dereference_check(p, ssp, c)					\
 ({										\
-	__srcu_read_lock_must_hold(ssp);					\
 	__acquire_shared_ctx_lock(RCU);					\
 	__auto_type __v =3D __rcu_dereference_check((p), __UNIQUE_ID(rcu),	\
 				(c) || srcu_read_lock_held(ssp), __rcu);	\
