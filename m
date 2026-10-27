Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085022;
	b=d9vUxnzd8v2jmViivad1wl4F0CBINnWJFtj+fx4IIX5zjncZ/oc52X67eUdPIxfwEuM7
	 JWg+V3oTcaFb7cXAtD/bXmH/BJvOadiwhi7vAx9Wu6SKfl1xJyMn8wziMWVbLLVK1RZHT
	 Thzg1YFQxTffFdWIj0nS+bj1c/6GcOA51wldwP8IzoU9vyC40WgSLfUhHohD7g6IWweer
	 oXYaDluL5AVEon0h4hfl+hvHA+SSMXzdRJ1rSKII7zVbNXZl8MeIGBF0wq2uEiDgNfE00
	 rO/jS3TBoHfjb5tW8CB7N/WUybwkvlGjVlVhQHE93V7I7RxLKhs4FdIOBf/mkZIGaIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
	b=nKYgt91H0l5+s7nLaCm+899c+1x7Bpii5IZrYo1qy65kbfYhcsfw7BQpleRovbKi0t2S
	 XL+sge9ZoHf1tldC4uyyT/oHEwuCpEnhepjv78QWXZi16Tv5CrRcDpygQHzViTFZygQp0
	 wEYQKtuM1YvIjP9BmG8cfZ1vn5OHM22ckOipeMLRdE4LUfOKHTzvkOvuojBixqB6JjsRJ
	 8GVhMrRIDFApFoZgG/wr1yJakvdywqNreN5OMII/0LlKwaQZsztZRgrPkdE61/7c+DBYF
	 /JuXAkw5z+3YB4LHmr8VipkwiEv5nL/pnEiZgc2dIVJ2gQPOuaOga0wYpdwqTI2yEhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MP7dcyUu;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78668606A31B
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78668606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MP7dcyUu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso1237726b3a.0
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085022; x=1793689822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
        b=MP7dcyUuR/CsLPEGJnMAwlBC0l9Ey9m8yHP+/5XVCmXHJjEpBP/FirJHePk2scnegw
         69ewc14JYqKDWEiUGB7BnikTVinxRqSwME9MfL/QqlK6ZfGNs0d9yfomDk8ll8Y2iUZQ
         7rHkMfk6qMivvSmJL7/w855ApT2qWVF+PHNAZDY5gVQzMcx1vm/KjQ4jCgMJhiftIOrD
         orhsYyCnlGo+1NpyMCV6V5NFjieMw1BDuK6Gk7qAorUP0Vv3tv1sZk0OTZoG/ciVdtSi
         AHiYfZNHThaQ7pBViic8d+EOfk5sL5OJ2i4+tNguAJaDoXa/8Tgs8IcsoYotPoEMvifY
         DQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085022; x=1793689822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccfSLrgWT8yZZMCQWDheXOVMnyMH2wrHGPHQpEmc4TY=;
        b=uVEv7lguwpmmEPswCXaUR/HiYBhkJsbCS/rzu2LtRHVFwD/TJoqJx2Fd4fHUkf1FRi
         a2erfhzAaBDguwPXNQaPawsDjzd+nlazoAdJBk64mqkbPaXqylyreYLtwkIrCIAJO/rl
         Xzb7WKFdiV6dBkDsn/O3M9TR5kL+4P6dPEqMNT9eDt35wcaJDO1IMIUTE9U8eEVnTY7I
         QHM9VmO/ZkrsL0/jKbsooJVl8RWSeJSTGdILY/+TrpIpjLQ46luM6ze6pDayN6ry7/ai
         dLoj9O8D8wmBudVx1oGmCCWpebgnlo+xYqfr/vMhr6dUKxXjiQqPhb6hX3Qq4jqcerJT
         3tLw==
X-Forwarded-Encrypted: i=1; AKwUvBwiIwH/xxJLvjJan7eOd9gOjGMsC8UhmKN1ApivxB7DPdcjPxBB4/uOcgR2mQ6s9SUlZGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGhu1DfMoA3JxVBo4EEqlS3eKXx2NQWoV6WrW97GVq5dqR3j1I
	j2vEE2q1HJgLsGRfEor6uaVQtXkeGwSc1mFTFB0iZO0ywXQbbeRvJRQW
X-Gm-Gg: AYBFou3AVwUDgTXmoouReRceox+GktsTlKEt1V72vyRU6NU2thTTsDDzO2J3X5PCCsD
	/7+gJMde3ImqzfQixQRanPtJFEFaXyHpFDRNBXCw2Ypva9KmTyliO+nJM7Dcsbu9RxBKeY3z+tQ
	iq+L9m55ELhmNdcwtvPDQMaI+TqcKDB5PtpFj5zwB9JCpcvV/Pscxp9XaHS79GRlg3gftgA+mLR
	FFud2KbADcqDi8PaVddwGeyjrDhBG6UQF0eWFvtZHz3y/FRXJSGu+WRzrTYwW9LwN2fwJAH+u+B
	0JjpxDeZUq19rGyY7wpzYD4kktyZ9ejvaNzNsVjdCo0BXppo067SHYTPfrsMDwBWgn8nb4lUkLi
	42B83x5pJCzVDpNYzvJ9OxUrmhRKmcBVAmyWT+fMzDP+0LWGmAWEj7OMyhb4xbVSbPtwR3ct+SP
	AU0OSjcIL7jkKAFCOTAwzwWmb459sdBMNa3X6M/oPSaXKVtx/PGvvzd8dfm6n1ZVXX4LT+Xp9ki
	U4tY2Xm8KJxZvexoIK5HUamV/YS+NVu5KR6M7qdiVP4ulF+L2oRmJNCXYrRy7mSGVzHJM3KB6Q=
X-Received: by 2002:a05:6a21:a91:b0:3de:1b92:a4dd with SMTP id adf61e73a8af0-3e7bfac2b12mr7185377637.18.1793085021537;
        Tue, 27 Oct 2026 00:10:21 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:20 -0700 (PDT)
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
Subject: [PATCH v2 02/10] srcutiny: Record callback registration stack for KASAN
Date: Tue, 27 Oct 2026 15:09:15 +0800
Message-ID: <20261027070923.3054462-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
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

