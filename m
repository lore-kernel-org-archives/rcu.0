Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750753;
	b=Vk/S4z032E6oEqQQo/UtyzzE4UsVIWy5QPj8NyfQHaBkjaMdekXEHf7BQ1xXA9KKCrlL
	 Z3ekrMUV8LCR8NwQXjVeAFva5+snkRbZYEUIYHBW56xU53GvwHnTdVmD4lDZ8XSABHazg
	 exddz8rJJxKvVuxPED19qapJ0a2U7/bYHMxrppJPXqV523vVDLpABcPA4VoH1o+gOz6hi
	 dRycDV/Q6FYQJMB0LkdrQNBoSxA9PYQNvthYKlyV+yCWBKYr61wHdVmGh0Ed3mNfTWMBM
	 t6qbhpZ0Ck7Cv7YfP5wMAsNEA1u7iL/kGaejGWQszB+ze0nhEOHP6XgbdfIs0W71LHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
	b=phd2LO9TkCPXmeHCMgbOO7Q/PrGc3ozr6fY2hJYHbCirAA0k4nKUtvAeaHzhKaKbXUqA
	 PmqWN0ZiJWkeZBRR/eoJFZa7qLF8FSf5pITWE4BgPRGfyKpne+cAcjqwLZF8Xh0a5WtNE
	 x6xg7t/qoscvYCye3OsXX0UNBbwxHoS2pyv+V/ngftRuP5oxzHMD/DzkdhXD/hAx5z9gf
	 9hURdsVXPnpc9Kl0CHtcq+5WFUNw7GZMVT9MT2qdZ7cXDSx5lJD5t/08ltmKx14g1oMr6
	 jhu9nDsed3NSwi72oYN5/W6Eb/8OVFBg4bJS6hGqdJgvUHdcNxvAR/QZlzeHRntB01Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f99j3Bds;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B2606A31B
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f99j3Bds
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35b2c599f43so1722144eec.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750752; x=1793355552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
        b=f99j3BdssGlXPzRkM3T6A3GFImg3v1XmiVjOD8r+27nY/0ZI45AakS7nUy1hUBfB0+
         uAb0P+RlPRaCt9DFTl2PdY6heEm2m2o6LzYIwKS3+lOwdYomSiXLVi4nC29DHKKC2ONR
         wZe2uqWfPajLfET+mm9zyMrK3ZrZHKLGkXwubTBEw9n7S4JNXsCq7kDv5X+9I2G/M3la
         vFrSepOMGEces1F3cUlyCLybqf6y5GCvu/vysk8IvEhkwM8y5938r3Z2SaxiK7AIelqE
         3GTHzrNU+NvObn64gFNXzBrxWU+hwu1PeSONyAcP/KTImJ9wJIXfjOBR2rLfmMY/F1C6
         bJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750752; x=1793355552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
        b=pRgnuzsY3DSlT/t38VhbaLhCY/O1/YrSc6wLzAz7EtkCLFzerp7lNPtAauroTBZK2k
         bR0RtZfgi4kgN5dayLKHWlWHhbasSRsU40URP1afdopSltNkgG/qrgP71mloaJr/RDQP
         FJof77yGpyqu2P351niEad5X1XjP+N5VmM/D6DYKTpYBxaXIYm4MToR7pluF6XojeaPw
         rsz1B2W9/qAPJY5/Fcq3IagA51f5fFg1utuYzc2fC/mklxdqeSQySwwg5vX6mKHPLFdq
         /+qPEqWkRSWAaNjCa9djcMivFKJ0cGVg6EjMGiuqeulUOQ3CIp7sZlxNwc5r2Fy3uiPi
         YQnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR7HN5R+waN5BHX+aQZAH83NkrYQQ2XG9J144NEbDtFR/7WWxK+qfl29Ma7oYsQfk+/ds=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdMfQowoMQY1Lv50Vbf7Sx2FmOQHKPAYgJYqHtqU1rKzk6Nc1D
	BNjg9c5qxxgF+7ZNlK2fr+TASQBmNmBDlRSjcxSi9lmU31mRtexS5UTU
X-Gm-Gg: AYBFou2tfTruyhzvnqkvWY0n2owlCkGIT/IkLZd5/hD4iWQLtJZeccxBMuYaVH4xDIF
	5l9qeytzgCRkjLvfj1pNS6TMfg2EoVIjjIYmqlG4nsTeNicvFaja9dP0pNHz0r1A9q0iT3+1T5A
	Shuz6q6z05FA9taR9XYUwI5ZCUT2uOO+1Zzr8Ai1yCThb4C1OXfaWIfUTtGoYn97cQRLdzvXtjj
	qpnAjBUY3HxvtI9L4eFWlwM3TgJT4UpaWnIUys/P3HPHiWZqgybs3h3xpGWdNPeRfkn38ZrCJ3X
	U+WugI0NDdtefwgHblcY0hhk2YkFIFL3I301kKYkCEdMUvU71kmPXcg4wRzlAwN5+o4fz6gqPz4
	VX8YftIfaDkkLSUjQuTiKtbNJVrAp5Q5V/X1nFo3WH2u55PxUhNa/WP/4mzSdsVWdaZ7MkjE90X
	xgo+SxChN+1p+cbG6plywxgXpvODyIBMGrUmBZqC7nGZLZke8mrXPlyXfDJ2iYyww46b1sHPikl
	m8qTnX/cIPDnXMWKsJZBuNzelRC/HFnD0LMwMXYLadqwG0ilnYXrgPcLzpm9rEtN1j/OE16+w==
X-Received: by 2002:a05:7300:f14b:b0:35e:a117:8fd8 with SMTP id 5a478bee46e88-369d975d6a0mr2732844eec.17.1792750752248;
        Fri, 23 Oct 2026 03:19:12 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:11 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 2/9] srcutiny: Record callback registration stack for KASAN
Date: Fri, 23 Oct 2026 18:18:34 +0800
Message-ID: <20261023101841.2910719-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record the callback registration stack in call_srcu()
for KASAN diagnostics involving Tiny SRCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutiny.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 63a3f0a8bc53..3ee28885b96f 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -10,6 +10,7 @@
 
 #include <linux/export.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
@@ -290,6 +291,9 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (should_rcu_defer()) {
 		/* A re-entrant call_srcu() during the drain would livelock it. */
 		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
-- 
2.43.0

