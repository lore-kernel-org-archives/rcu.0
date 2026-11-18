Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991941;
	b=gQBtI74QqQAG6zK5jC0bCjN2voUjO4ZeuTBFAlmQK1d/4GyBYq4w54kmlkNDFh0Cts8k
	 DFsUhhTlvEbbIS00HLFIY+8VOxqZm1rWOkv8JqxCAgRQSyzOY8rj6b09hc3IzPeB3nMu7
	 Op9w+bEyKYWiaykD/ETg2Rcz5c4ZuYfIv8t8bdkcNnIfc6UyhSObNZTx8TU88zCUEhkhF
	 i2oZbiINXM/IFjDyjZyE6w52wrSMxgw+OBYfSOEVwFdjFXlBtF2QWwXKZF4vdo1I3VzSx
	 d08Usw74uhWqeeHyisnMtu4zGlrS/JIP+VS+IOlwobX6OeauIlWoQ5BMDghZbPprr4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MH6h5yZLan++n11pZrmjLLjasWeBnmoXNM7NAKKbaGg=;
	b=28+IRB8jbfHlg13vUhWxI0Z6T03NsmBeoWJhlzx5iW3XUVHfmGTCn0IVw1em0OxRvRE/
	 BG1E6s4LYf3Y3K7xY3791vomHS/9BkoZWo7RcjvEsmgTX3yJo49g2RxkDFAoWWbULNnhb
	 i2ws2Cjk0EOxwYo1ReQvOlwBCKs5ozoCYzjAj6FOjulBTBIz7exQZV0K+rzD9u/OtNQYq
	 Ej476K8HNvhN5ELZCk7hwlhs89snf24VOlHk8NhMw6JnqwHCl6Tbg17R1aiaZHwODkTl9
	 ZFtSkP+htByOxvUWXNirWCCyT4IMgfvmYTeRBH8CBGTwpl1QqW5s0kbGqfUVWBmF7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6r+HdZK;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DA606A335
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672DA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6r+HdZK
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5118deebcfso36124066b.1
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991940; x=1795596740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MH6h5yZLan++n11pZrmjLLjasWeBnmoXNM7NAKKbaGg=;
        b=p6r+HdZK1xiYYCINoTCEtmLiP+rz7k4S332McHIJfs1CCJXMQUw6o5YRLByHzygS9o
         zjjtU3mxlZAw53bLKM0o71tFlYck9QdDrym6Zuz3dBMgNMocTROoaT17lpFWBqQGT+EO
         xoixsFZhBKW7J1UDXpVt9deYJPGNhtQCBxH0VO+pR+Sb7JgYq+EVoW+fvJheE3H+QkFI
         rzQUBkegB/X1SMfSdSy7sRomzhXVc4WLZW7KTlT4doajipjrBtzCsAVO5lSUGpNdV5e6
         8FyGUkt596p9GjYOMNKUopSxhSG7k8KW3mAjIaq/Dn7neUjMbB2S6zFYWuelshQzoz0/
         iLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991940; x=1795596740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MH6h5yZLan++n11pZrmjLLjasWeBnmoXNM7NAKKbaGg=;
        b=gk1j9fCVUbwnUf2ZrBRfMHMsZV0yQD/0vQaIh1ie8aH5f1E1btsh2RCrguv9OYQB5a
         uioVGESAB4ZSsnUafLGqc5MmwcygLAMsTTU6vjrfOvGOOlV4siqvMzCCa9ovkILxUlp4
         HWJSbUTnoNBUDxC8BScWCIaKxuCjZI79dlRmGgTVScK0fG18mw3uqhqtluv39tGQV4ZF
         l78l0GBPJHKyZVCrl1Y1m/RnFMOMv+mQ+nkaWSlMq88Tu1/XLZzyMvXGRNSlFV+LduIw
         Flyjr9YHMXUNKJL1pPYm+TNjiKmmDpdhHwNEfmNNRRTU0BV0qpBo4ncQpFz/tWbBqsK3
         pLrw==
X-Forwarded-Encrypted: i=1; AL+hErGQkXSlR1gUKBk5WgPUC9O8/HKJeXyR89csz/ScszqasXcg1OkuGkTvmPS71YxrvAbyYvU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zfSLiqey2l5jFA9dJS5njkxNP/wfEHoWGBpdz6shlGAP8hr37
	O/FLJktqb2ryYaXt0//zq+CkrvgZDjtutFm8TMaVecu2hL/8GEC32Uvu
X-Gm-Gg: AYBFou1j4VMpydX7adXaBjQo0fRymY/DDkGfVZM3LOTUo0daCdDS37SR0tFuEdPylMU
	RihhWuCyB2NN3Y9jxeAWeBQQhh9rVRc8VCtUrYGaxzyKtpcXIDNW9umCzFx7GIzIKI8C+/68G+0
	8Fp3D6LIjTIiIhjZc1rrB9efCi61KQ5KooNtScciCZ0BIVCCRE1MDG6yZVwj3sb/atwNxIriZ6H
	xyI0iriW6qZyo4Y9bYPgCSaSn1QRzClk8HZ6lJAgbPQXE9xgapL2rereKssBIDnnDGVDYFXZfVB
	GVZLs2/MG66FXdww+jO7ZVpAxZ6Gx9WQUFaElHOJZBSWwOUMulEnnNBLeVw8oGj+IORLgk0w0TB
	KfL/t91KhUZIxb0MD0Y5u+gwMhuPaPY+UG6AA4wzExzJco/MA8ARN9icSEm2h9DIYFLqugY3IMF
	ZmfSVYII6/yQuV2RUq2HUZl7sMdoNssbrB2pdOLJJirV6clxlf2uKbWN1/JY06C0ilVU9G+Z/02
	PkoXapQha3r36ZE0feWFoo+Jzd3+W4a9Ky07CuwM7XCDoJ/cT2PAvd8VOGoY9ZDBoGaF2x9CQik
	7WTzIR12RCl5bc5QX1/fF4roiFTdBg73V+PF
X-Received: by 2002:a17:907:3d8b:b0:c50:5005:8ecf with SMTP id a640c23a62f3a-c510e0e8be4mr150691266b.8.1794991939176;
        Wed, 18 Nov 2026 00:52:19 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:18 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 1/7] rcu-tasks: Record callback enqueue stack
Date: Wed, 18 Nov 2026 16:51:41 +0800
Message-ID: <20261118085147.1668598-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
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

Tree RCU records the code path that enqueued a given callback via
kasan_record_aux_stack(), but Tasks RCU does not.  KASAN reports
involving Tasks RCU callbacks therefore lack any hint as to which
code path did the enqueueing.  This commit therefore invokes
kasan_record_aux_stack() in call_rcu_tasks_generic(), covering both
call_rcu_tasks() and call_rcu_tasks_rude().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a20db323612b6..fd43cd5d5a485 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/ratelimit.h>
 #include "rcu_segcblist.h"
@@ -366,6 +367,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (debug_rcu_head_queue(rhp)) {
 		if (__ratelimit(&rcu_tasks_dup_rs)) {
 			pr_err("%s(): Duplicate CB for %s, %p->%pS()\n",
-- 
2.43.0

