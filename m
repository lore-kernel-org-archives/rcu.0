Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682570;
	b=QeXl/kzzWhujIXbHM5UpiH1peVT4P0AqUhw3lewYEC9vdh2Z6Nx+GUscoUV6e+41mO+Y
	 LuTSqpNdyKqE2YxUU03mfLdLE0bPx1IR8wERnL2JGxpbVWRzuuojQI2RYabxCW266Z5sv
	 hLTmOdGgQFuKPplfXjW6lb6QWzM1/3TNpsCXxWuTXkggt2KlOn93H2AWJdO/vwfngE9t0
	 8zOUL/tbhPWj190eawTLp84zrBIIPTRqgiaTcXZKq7A9gh920kZ15zHJUPsXBOsEYCbhH
	 ghYnYlu4iQwLPOcQ5kKpKR1lQS0R9HbxcL4+ZpnRI/uthPXH+LC19rm7xdR2PcwHkdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682570;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer;
	bh=MjH0Z6kQLPK5sPMY16E6rXD+UzsUK45+8CsKuxvqnZ4=;
	b=Qb5noJwotBRDFEUjYxvpQMjFD1JkxejdXwfr2zsfvElIsJa43vmjKGZLTWCbyae2VVrx
	 8o7R1Kt7WigX6Xalfk9zX1RoexMfPorD+dtZG43hWEJNw4+v5HvLluoMKzsv/m7i+sK3A
	 PzVc/nGB5M+4eVOnugney0wnwr9AqqOb/kAhs90vAJ6dIwd+bBtqVTt+lWPO8510mHz+w
	 RaF3Yaxs8q8L1U0Y169H42M2JGCH5ahXgZsIC92UCvGz7PBcy+hhG7g/zK/yjC38/8v2E
	 42HFvG4+7rNPgopD3G12JuMkdPaFRdNxcmzo5MyL7PAM3hvndvPC2Z9WMtg76BvVMIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vbN+wzOD;
	arc=none smtp.remote-ip=91.218.175.190
Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D34606A323
	for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 08:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D34606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vbN+wzOD
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XaEhST+oEIzBrFxx9h882AD02VM5YYh6v+mbwtIXDL8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795682567; v=1; x=1796287367;
 b=vbN+wzODXOasUq9KWBDw5C1DmGDv6hKV8rCpDXcdiItXf+ZG5wVq3BaEkxQug+CsQWtfLl9Z
 c9iPqlwoDOY3Yh+84Fgb/YGyzOuFDk+u0QLO/5G7aiss287FE4jLhkS4GU9MK6suQLec3hXqGiG
 txfbUoSUjMAo5LiRtb8fvaEQ=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 496823f3f271d93d;
	Thu, 26 Nov 2026 08:42:47 +0000
X-Mizu-Trace-ID: 496823f3f271d93d
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Fix comments for srcu_dereference_check()/srcu_dereference()
Date: Thu, 26 Nov 2026 16:42:41 +0800
Message-Id: <20261126084241.17569-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list

These are SRCU-specific primitives and their checks are against
SRCU read-side critical sections. this commit therefore fix comments
"outside of an RCU read-side critical section" to "outside of an
SRCU read-side critical section".

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 include/linux/srcu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 380b5964fcb4..87e5535556c6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -294,7 +294,7 @@ static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __m
  *	really are in an SRCU read-side critical section.
  * @c: condition to check for update-side use
  *
- * If PROVE_RCU is enabled, invoking this outside of an RCU read-side
+ * If PROVE_RCU is enabled, invoking this outside of an SRCU read-side
  * critical section will result in an RCU-lockdep splat, unless @c evaluates
  * to 1.  The @c argument will normally be a logical expression containing
  * lockdep_is_held() calls.
@@ -317,7 +317,7 @@ static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __m
  *	really are in an SRCU read-side critical section.
  *
  * Makes rcu_dereference_check() do the dirty work.  If PROVE_RCU
- * is enabled, invoking this outside of an RCU read-side critical
+ * is enabled, invoking this outside of an SRCU read-side critical
  * section will result in an RCU-lockdep splat.
  */
 #define srcu_dereference(p, ssp) srcu_dereference_check((p), (ssp), 0)
-- 
2.17.1

