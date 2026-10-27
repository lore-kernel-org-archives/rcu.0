Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085005;
	b=LXTC7ZKjJxFGicdbqGKTv3XJNnoh0lr3GL5fjUxlxyaZmxKd4UZRN3XX2aQi+urgMDwX
	 6FfpB0OhvC1cIfxHYl79ajpEdLbkpk+iOAf6lSsUPfjPspTlqao9JFyIewqfa90I0GD7l
	 05bHTuojaeDiJJTnuoEPjxbKdvN90zo+nhj1PVd3puXTl7MAXX92WXM974Q1RXiCXVJP1
	 Tk78/3ix5FJGNIKzHSQiy3h3a2UpeozG+Z1FollihbqsXl+tWJ4rWI09+2qPJEFePZIrI
	 8dBASWLtJoLwESQHvrFgeI93x5wKi79jFrUJJwwqP6SUtBW4wC5J9u50vw9WbhPOElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
	b=Z+i4PJ2utA9iR/L9spipA74olFC8Cll/vxcBcaxFqjTD+uH1M37Z1Sf7VLbZB+Ojcsu7
	 T8ujKvoBW38KrXUtM+PRd93D4gUBbOzGy9ArqcXlEOsxRZyZdminhSvtLgJIdFEFx54vV
	 EtUcBUF5h6JQ1wX36u6WyexXxtA5ynHNDgKEl+QSRdUprUviSCNgQlm1jR/veRiRAHHYW
	 tQZ2ZcE2ftV7Z3fmv5AXIHq0pBhIUooHeWICM2ZxPsp2ZtSCCgdYCQMfN526gjO06Fdfb
	 5hcNn6wfQoMMmMfn7rGCCmTJvktfrhucbtEhQuwkNdAoWy5+QhXVJFmmDQYqW6glV5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ckAg0cTw;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357E606A31B
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7357E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ckAg0cTw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2488203a91.2
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085005; x=1793689805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
        b=ckAg0cTwq47FgYTxX87XDEs3fE4xRTf7VVWlgSVrBnEVt87UBJOTv6tOgt1KZv5br6
         t87WjH1iSFvnT9Udd+8Kg3ZuhbkioEr37gdcaopXk1qy4vGIn49PIS0F8rKNn2n3fpdd
         A/YmdsWAs+6bFHUObcqSMQtoQscIu0bT8ZMkUBJz+806qHsO/tc4KT/gYxCCTFKrp5CG
         ysghmOBqns5MJFzd52KjwTZtHdeo1V4DyxkkxEldr6ikZzdTVZStX39BuyJBVZ0Lqh2q
         I5LY4wr2/vz6QYvTFXZrQhEfIYYMfoTaFfzxdguDNMEjDO4L2JhqASmFLZnUvvRpom3o
         VW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085005; x=1793689805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EtqIIM3bW6NOeXuYxzInv9x9RXwFgInG15ngZwHQesg=;
        b=b9KX/VTs+a9cR1Uxq7tUCKGeA0fcOeWbKC2eOjl1xSrImzr0Cf9HvrvRKy/WLCUHtc
         M6gEXeYN5G9zxUg1mjkbidVnfeezjqPiW+5Ules2kBEV/n+XDwQS7O1DgPZ1gkdU+495
         cUj64zpW0YFsPqVw1eWC9yhhK+7pCWeXpd6oNZS7cxZPchbmN2afqZK9vEiBg5KUycB9
         Sf6zS0aFwqjzF8CWCRiHKvaiE3cxPZaIacZi/G+iFhQnw6zunPNYsWwmchuhdRP80XLv
         sHXPKUaxAYlP9d0Sk9YyKWOVMcEgYNu/lktpGAt44Lv0bcpyVOy9OVCC+SuSMmGuf9nd
         MM5A==
X-Forwarded-Encrypted: i=1; AKwUvBwgznRrDji3NOjjQW7WfjKFy1Mh4GaW7oci0M6M0Qzvy7BPE0j9GwQ1tAWowMZcoAiK45U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpxmQpNpjEvI5Hh1N4F+MbApeu/VkdU7s8DOlzHhigWX3V0dsG
	jJXLaYBDV9akXxHm5R/EViXTWFFs28EBioXA/+JY9nLdm9b36ZUKzqM6
X-Gm-Gg: AYBFou2BjyNpu74fIvPLd8XQS6r26nNXm93Ad2/6DBvec1xQw7R7sQjyzVY6AonRWNl
	Zxo6B+A5+Q2uswPIT7lVNTOEkeEcpDolu2Gs6i8zmJ0hrXOc22xb7jr8r5+xu8H9ZpNAO1g9GMf
	Yi9ZCNCw511CDv2E2/cQrIGpkUOTWSA2+9xEAfy7qOvckLEYryMHV1SPbZZ6jhVHm2d0ik/Hjql
	RIMqqPDje62K9Z0GaPjogZF3Du/bCdU8YFvCTcJMYo98IfN2VgQWH79Hz0dBIPSu/FbcjK8Mb62
	vYbh5LJWPc5ixYaIgdinHjOGouWdKHhDvLFn3Zq+v9BCAp22C4/tv/m1brV27+xGbQThbhWxvVL
	Zq3JarPgzAJ5acWRtDTXQnDw4UZQQAlIRpiCGB2iu3cB79WN+CFZIsEHlq6apT0lFbe38BVwJjl
	oJ469O87orPNqsgxUMYmoIcxKSv+zmbR9kXXhvjDP+uQaxIcfIA4RGORBkEZjsBGant5KKSdk2B
	jTmHdak55oY9QMsUv8HyoWwl5S85aN5IpzhRslrlbtXOPjXzC2gXrAlUpl71UxeIG07Uqfw8L8=
X-Received: by 2002:a17:90b:56cf:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3adeae80e3fmr7279552a91.58.1793085004664;
        Tue, 27 Oct 2026 00:10:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:03 -0700 (PDT)
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
Subject: [PATCH v2 01/10] srcu: Record callback registration stack for KASAN
Date: Tue, 27 Oct 2026 15:09:14 +0800
Message-ID: <20261027070923.3054462-2-kunwu.chan@gmail.com>
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

Record the callback registration stack in __call_srcu()
for KASAN diagnostics involving SRCU callbacks.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2c18..46fe2f0cef85 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/irq_work.h>
+#include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
@@ -1530,6 +1531,10 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 {
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
+
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (should_rcu_defer()) {
 		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
 		struct srcu_data *sdp;
-- 
2.43.0

