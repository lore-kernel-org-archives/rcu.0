Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479423D410B
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303426; cv=none; b=ri9KxzVNyEyQde8WQvezueGXqu443NyKd7mpYyhVDpPZ3p3XQ7ZbVvLRGZTqHXZCyjBRmIAwHg9G7Uaq3e/SdKOP+yrSStXncAHU1CGQB8158E9zgNa8wTKSVQOnPodTDgYeyhloPwVb0dl1j49Yk+/x0FlHHA4dx5ALsdhxwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303426; c=relaxed/simple;
	bh=gZ3n+Kgll3kq73yQeqlls7ZLOEc1Z5XF5nmxX3h3XHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVmKMM5AcA7JZ/y1sNl6gjZlHmP/YPlnde4QHz8tDLt4P/nGZTmRdI2EiG2N7fgppW2JYwFAn8gywwo8LeW1X2BVVwSkMvuFiFS4p9QONYCDS3MJOHrWPWsfhmuAJxNXXF+ai9GxDF+bda0NiaY5jFs1mt481bLVA5wKofWv0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jyrBBV/D; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jyrBBV/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Tk22QqNBn2VJgu
	UCN3Zcaq5q3QspvH22rdnYl/88cck=; b=jyrBBV/DMGN01Wd5a/F5omJ2FWgbw1
	weaFtqhnusNjTTTZbQ0ncC60SWDrP0XrAM4cAKxnashzfku5bRSgkFA5/aMlVryt
	EBb41SnOw71yXENsuyLk2Pmg21ya5VnZ7dTIOTs9+7oO2HM7h8v5bXr1ZgNORSLR
	Vdkn8Ud1eM+Zn+ry6UgSoS07pBwrBAj02pl7TelP97KASowfg1ZMaVUX+vTxz7MJ
	dFOEg/NmM5EiNv7SqZ9O6SGmD/cQ2KIxiYIxQaTJ3nzR1ZPiGKmDmxgjmcKucK8Y
	fBzbTaySOKqEVDUAaCpP3V73kjWcfRjPJWILs98U7DmaaCXssKwheusA==
Received: (qmail 2665323 invoked from network); 13 Jun 2026 00:30:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2026 00:30:18 +0200
X-UD-Smtp-Session: l3s3148p1@WydzBRZUBoAujnsK
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: rcu@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH] hwspinlock: annotate slot pointer as RCU sensitive
Date: Sat, 13 Jun 2026 00:27:21 +0200
Message-ID: <20260612223002.13121-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because 'slot' is used within an RCU read-lock, it must not be accessed
directly but with RCU helpers. Annotate the pointer to enforce checking
this. Sparse confirms the missing annotation:

drivers/hwspinlock/hwspinlock_core.c:392:9: warning: incorrect type in assignment (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:392:9:    expected void **slot
drivers/hwspinlock/hwspinlock_core.c:392:9:    got void [noderef] __rcu **
drivers/hwspinlock/hwspinlock_core.c:392:9: warning: incorrect type in assignment (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:392:9:    expected void **slot
drivers/hwspinlock/hwspinlock_core.c:392:9:    got void [noderef] __rcu **
drivers/hwspinlock/hwspinlock_core.c:393:48: warning: incorrect type in argument 1 (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:393:48:    expected void [noderef] __rcu **slot
drivers/hwspinlock/hwspinlock_core.c:393:48:    got void **slot
drivers/hwspinlock/hwspinlock_core.c:397:30: warning: incorrect type in assignment (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:397:30:    expected void **slot
drivers/hwspinlock/hwspinlock_core.c:397:30:    got void [noderef] __rcu **
drivers/hwspinlock/hwspinlock_core.c:392:9: warning: incorrect type in argument 1 (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:392:9:    expected void [noderef] __rcu **slot
drivers/hwspinlock/hwspinlock_core.c:392:9:    got void **slot
drivers/hwspinlock/hwspinlock_core.c:392:9: warning: incorrect type in assignment (different address spaces)
drivers/hwspinlock/hwspinlock_core.c:392:9:    expected void **slot
drivers/hwspinlock/hwspinlock_core.c:392:9:    got void [noderef] __rcu **

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Just dived into the topic of __rcu annotations. I hope the commit
description makes sense.

 drivers/hwspinlock/hwspinlock_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index cc8e952a6772..50a875b2353f 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -372,7 +372,7 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
 	struct of_phandle_args args;
 	struct hwspinlock *hwlock;
 	struct radix_tree_iter iter;
-	void **slot;
+	void __rcu **slot;
 	int id;
 	int ret;
 
-- 
2.51.0

