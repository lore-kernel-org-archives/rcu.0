Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085042;
	b=L6lPUYww1Aq7ldbP/uVMOix2Z8WlDk9TOTn3ajcxiWyeNqe/ZxKvkiabqkTbEw6Jkas2
	 YTVPpASZCsTJYUqMmhpyNVM2t+aFbg6w0QdFo7UbN48X+1u2l0sQ5evUbroBANdpqryA+
	 olbdash0UrV+GK1MWdam+9mvvfZii294BqIYlzyZD6hNVc35zBSyq9Fd6xkeFMzT/erv3
	 AjRabAKGV2ahdT3Kn0h1P5S+LjkDZ3C8bbtJfaqVFYAfv8823HMEYhpgax+rjVQomcyOT
	 cbB8I75D9aYbZ8ZmouBiycu0A6LNFySujNXL13bhT7W/5doOwgQUkQXBpJkjEy5oFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OxH7CoGZzoMgyGL01lqgix9fdQuQFlpvLB0r4SdF5hI=;
	b=se2I8CmQs6f3ZXYcWRBD2Xw2YXkxPC0niBoaFzDSHI/izf+FI8fKmRqfOHrWLdFn5pP1
	 NrA8AyBg61kXAveLhgOMTAcxNtj2BxUIyc9bOmi3cwDOPvM/wTqkaT5P5FCAc/vY3GORy
	 fgU3gLR19+BoOTIduA+T4qrxANmxaHNIKOKzptMP0neSsHdrlh3pi2JWhUvrsQKdghvTI
	 WPuFcfh49gR3h/CQtJvXaRzj6JFa44+kpmZ23MVKYu4pOIcmqHMl3mSVLizBNjhs7oEpz
	 JQ88I4oqcodnmHZ19X7MCnMKua2mhld/TVU7H8koEoilMmQjHN76nwEBQRrxFVCeiLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0q55t24;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA1606A31E
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27FA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c0q55t24
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-881269371acso307588b3a.0
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085041; x=1793689841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxH7CoGZzoMgyGL01lqgix9fdQuQFlpvLB0r4SdF5hI=;
        b=c0q55t24VkuzSYewJ6och5i8auUNWEhK3q1xa+PLYTisR66TT0bivoRPCf3pZN/7pY
         xt+3AHssmHRuYvwg8TAfwD6P7ha6V3lLgBdiKzCvA69lv4TW3r2T4OjegSsGm6t9XXKp
         Z/XkvqJ+I9LZr/0wfmfHWbvV6bQv3GuNHuIezqebgHQAi5c9+6VhWAR/lXav9sk5VkbM
         8pD5cVGssrptTOB9k1iB4K9oFWphDkTGxCUA2KdqiqIfXkc+PNR3pPyRp14VdC1LxkmN
         a+aLsiygOzcKHr+bNdn1DNTHNc1JzOAwN8udVJ/cz96EwCKBKotuo5IzxmWBa4luCWgF
         20Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085041; x=1793689841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OxH7CoGZzoMgyGL01lqgix9fdQuQFlpvLB0r4SdF5hI=;
        b=F77m7IiKG5Dt1rKcm0DTD3A8FEFRJ5Q2MlrJ7FZ+VHSz6cgEDJIHc0UH3dYiaQqfRw
         ET8p0UWjyF5yHqfl1Pfr7fKAKLb7dC/dOpFrZ32PuJX0Zt5oretU7n96x33Wfb65iRBy
         Y7XZOwovr+VZi9RZYYMknrdU5N61PtKS97cnTNxUMHInkCqD/PmHwyTM3tE6+tjIcbDj
         TDmgb2mKXl8sx8y2NqTw1EP5MKz5W2i+KRaaFUONQKkwKJT86X2LPFqHY2xZBEMkCnwr
         GAgl1gMHU+pwjptLBwfXYl4uXz3zIzIPHKos4KyfvlX2vuHWRWcs4LomGVvTLtgk94Kx
         IKew==
X-Forwarded-Encrypted: i=1; AKwUvBx6DFmGAAsCSFDoA5MUSzdnrpITifjUO+HFfjKJ7LQzB2fr0uSXrJMuxiirRoyKnB6cSc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJYIzHL0slLVUTGg4VWjKK76UGPfjfAaoxBr1x6HvCpBAiv8TX
	KisW7jWDCLMUBymxdObrMH2MbqSzYyk1PFldNoA9jNcybFuVSLaMrSJL
X-Gm-Gg: AYBFou0s8U0/jjrHauCdiuLGRvEeI9CvkQO80AL+E2XJI3/9YR7kAgqVN7vEuwdyGnT
	Fxpv69Uzeyn4SflcRkMFVXnXowQgs7CQokjfuwIWeawJH/U382IqThVTJNsyY4FlKroSMtIX863
	U1xjMQ8hgM13FL7Mg9y1AbLpsYXCKNtxesRJmLQMTYXXuH51+viSr+vpRl1OjW4vMGzyTZpZVml
	5XYsccvY+wEfIdSprXZccrtm3D+56AJv/aO2EXLhBlVpIRUaiwvTSyMNs5aUQFpgFukPQEEVv9b
	bIATWyWR4/Fg8NzAl+z2UUj8i4GtV3B0y/nt5+NjlBgM/CFJV5pwDkkRUWG2bxB+eiIyWcQk+yb
	vgsi++u+81iNgO13Umyqbi9qs0fPL4tGIcsE8P2WCcs6d4oj+Whs8bl/OSQD/pvw29pBDo0CQOs
	arR+rSZdqP9hOMvcaIvEEUV6NXXuAOXVom919dsVys3/ZViaN9+/evBhRvpmjdkiQOKJGU9sL62
	xmzI9DlF5BZ8MVX2D6d1qLYC3UPLC/6DQAyTBQTZuR5vjyZP0CTG9XI40UOdHxDLJd0Rd0Kig==
X-Received: by 2002:a05:6a21:3b92:b0:3e2:78bf:63d6 with SMTP id adf61e73a8af0-3e8eae8a1c0mr1343122637.46.1793085041329;
        Tue, 27 Oct 2026 00:10:41 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:40 -0700 (PDT)
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
Subject: [PATCH v2 04/10] srcu: Validate callback arguments
Date: Tue, 27 Oct 2026 15:09:17 +0800
Message-ID: <20261027070923.3054462-5-kunwu.chan@gmail.com>
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

Check callback-head alignment and reject NULL callback
functions in the SRCU callback registration paths.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutiny.c | 7 +++++++
 kernel/rcu/srcutree.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 3ee28885b96f..98864977bed2 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -291,6 +291,13 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 46fe2f0cef85..1993ddbdb828 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1529,6 +1529,13 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
 
-- 
2.43.0

