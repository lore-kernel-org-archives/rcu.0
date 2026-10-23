Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750766;
	b=R2E41IiKWKMeDYOe061V/2CLu+SqgmM9Nt58ZQa0xN5RceDI9IdXByLFewPb2uO0dPfQ
	 QkZ0/YBI21PsI27we/jTSIqZgFXkQ3VKedAgmSQs+xMmhMmppHw97+YWfom6SriN1eoQQ
	 LIirYkr3HZrztBbMJ1HxV2qeg4b0gah3LrAECQCCxrqDdACJzNrpGK/dyJYE3fXm8AnBR
	 PbaYAGJIpxfa4Blq/zvJgH2R+32jYMTc5qID9UbgdYGXP+6HIn4BrCF+W5Z3GjKZ+a/lc
	 bnVkTBvlNtOHDv7JaxodoX43slcf/msRelRg2g+FTw7NqLSgV0ofbTXPcU9RuOvoBag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BYJPXc+YDbxsGoRWSqtP/HKIWWRHUzZIapmesZ/NvQs=;
	b=KCZbpzZeI5dhtZQvRDh+iqsH0Tv5XnI1r8X5zpekhsLjI2gKPMVoHeky2vLwPUj3YojE
	 YjJLkHlYRUxR16yPNtnVio7EBzQPj116lQTnPzI2nfBPtWULT+XzFJVxc9qXQnp+N47xR
	 yKVSDMeFJ1Y8kZOMm/E7c8TDZLtk7AsnkTdflrXk8l5C++HI2W/MQaZZrLVwZRyoOMW6i
	 wxQHFxH+17iZ7sxc4YsgcdT1IBXt/XuKe8WvpLVQs7+SUZUQJchE2jtNhdhmxzqXS42L2
	 CQNfrsNj1p5g+lED0dapmzcTKwxg11dPTlhrWyyUVrpLRMAg1vIpXe4l7ESU9G93zpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e2OSohK7;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB43606A324
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB43606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e2OSohK7
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1151198eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750766; x=1793355566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYJPXc+YDbxsGoRWSqtP/HKIWWRHUzZIapmesZ/NvQs=;
        b=e2OSohK7cttTvuEXSEqc+hUVErL+2Xh5npnbSuKKkV07uKAJ7c5vJtSgPow6aActFu
         Cmyp/RcrHntwA4CfQIWOw5raN70BeqvFaMoy4HdJjOzstdZFKaalHgSVWe79o5T2or2n
         2SYfO96y4so/EWoG8kG4aZU9twxlAfFQdkH3v2mY3/FjQechXZb32ocQLQ1KFyx2cPw0
         EwzftDLLA4BK1NGxg4fWH9uWMSeq+nAanIqQcJLmRrlzFbdpdY35O/cjWx4+ojY00rU8
         zR6PW9vrhTjcSpF6x1/o5mOmDHH4/0e/HUE8n/HsqRdMSDJx37Ri1f1xTzu9AYyATbhS
         2/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750766; x=1793355566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYJPXc+YDbxsGoRWSqtP/HKIWWRHUzZIapmesZ/NvQs=;
        b=wQIUsfnoGgVR2F10qK+Y+ap7a65ChZor/zcTT2/IJc7D1gsmVts52bTUhlOs2k/0SZ
         UNPSvclFFPpxGPlhVYVihcTrUScwXMeiS7jeVwWXj2bVdOTmdID9ClQHhw55JG9bO7MY
         CHX/zaPpmhoBIzFMy+bBe1ascDE6qiDk/Dv7mfv564sWMF3DcQ/XOW+iW8nmpm3H/mYv
         oWuZT8wTF5ebGN3OCiwe0yPB3T8bC2q6DOGJEuNkU78DH3q6Dx2OKZ6v8PcQ+BmSYD42
         R0tBGc1+Q9Uy5SHABMxyzcZEQy5TgMrvc59dwddJC8nyAGcSUjcEwa2yp4oPNTBaL/Np
         xkBg==
X-Forwarded-Encrypted: i=1; AKwUvByOr4rC15OjziC1B99nUbQWs5vuudJgS5IA2/wWs0safF05lyzGJVeKyzI+h0Ug1QW1zCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMqmRMoW8WV5/kWAvBBqhp4r5EzX11lmGVtMATZvQOLug9NA3+
	Wh0DFFaTa1orQrJEF6EQVbkI4pINO+zpPIi6w/pHrOkzeTB2jqFAhCVJ
X-Gm-Gg: AYBFou2Lg4Nva1dxJq8UdJcMKTTFVo3tI1PfH0uun0SiRNo+UsPx+/wFsp6Ybb42ibO
	I539lp83qW6X1fvEtlNZVMcQ5J2GZbVLtnhcZNlgOap1byNX5maspPeAYcnOiJUhqD/f4m37RTJ
	+6Pz9Uufad5QPLPTMts8v+YUtRdh+YMRy5OwzdFi/KEpqi7u062zOrAZVBgRgoeyScY3hM/HodD
	QguNGRrhcCxFZWidLFQiPWrjdMn+5dcoLYRyF+zi2fr1MFUVmKR4Ur4SnrTKco0vsOomICfT5j2
	bX8VnAfLmHqwggaVOSKOEwTKzaMMMy7StNeg4UE0r2Wg1ICwiw1DasjleIyS89GV68SdtuuA20F
	ytkIrvbef5fuHqUUO0IwsCLjpHhGAVe0NyalNvfZt+1OgPwjH0Ag/vo7VU2xJVF9eDEr+svfyjY
	AV0/KZ2jYuvBXYhWU9r7DsPzjklpX6xBw7JyWZ10YYtzTeTfG4HCZFGsI/jDpt9dF6K9BMu6riS
	P1p/3FX5scPhUQtVseTVCdnJtAvhedURWjlSUEKcabQjLsXUBfVs7etfw/L9MxpZJYEYjBzPg==
X-Received: by 2002:a05:693c:894c:20b0:368:5750:9869 with SMTP id 5a478bee46e88-369d96dd67bmr2226866eec.8.1792750765447;
        Fri, 23 Oct 2026 03:19:25 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:24 -0700 (PDT)
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
Subject: [PATCH 4/9] srcu: Validate callback arguments
Date: Fri, 23 Oct 2026 18:18:36 +0800
Message-ID: <20261023101841.2910719-5-kunwu.chan@gmail.com>
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

Check callback-head alignment and reject NULL callback
functions in the SRCU callback registration paths.

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

