Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085048;
	b=vrnPwYFOLGFAynkTx96BekB2EzCAVYZ3MV1M4v2FMRYYcsqM/9IRL5LHQSuiQiHbirG1
	 toY5OWIcE3In12VnoKVGCL28icmcyBtiJT/2r0HEdzDUYJZGB6+yaMUHYphRCLIj3revR
	 8GVqQ9tGNPr1WGu4wMfmwh6f3varT88XIuXaDWcMfo7aCnl7Zxdf1aN+YPHD8Rm3AI7kh
	 y54uBVT1IOd4xQvPePFKSk0/3UpvZO56Uq6LqqwVs1sSCPFBRJU7FPOar55FQ4ksGQfRd
	 fAJD/FVfK3I3z8S38riLVsqHoOG6zVum4F3s2xT6xNKUypAG0A8xSf71xAIeAqmchKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s86LnAWFmWP59VgheQcHJpguzX26fuGNoKB7W+R3clE=;
	b=YMtdxljRrd7p7ttnCyaA/edCYABIIeY/rPeK4S8lPjgo/cNtyFV/abkT+uFBh2ljUMeB
	 bhfJLvuhHJteSe3S2QXa8yiIZl8Dl9HtGHJezfeU4AJDbbGmdmGUzw+/ymytC0ltY++UZ
	 GU5aHBhSLmxptaoqBvXAzlKXY8MwCHa/wXnLw5VlYs/mQDZ6XE2nX97V3uo87UyT0Ta1c
	 VX+69mC8S9ST0IAoODP6LKsH4+KsrO79K12CwBzP+ejLVCwNYq57rlCWxk9INaWTRj5Iw
	 LUe8WT19Qx1ATC/khkzQI68tUygVwiZBHtnwnD4jKklFToib5Dmh3HkzFUhQaF1/gSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DWAEdlFC;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27A606A31A
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C27A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DWAEdlFC
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso2308252b3a.1
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085048; x=1793689848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s86LnAWFmWP59VgheQcHJpguzX26fuGNoKB7W+R3clE=;
        b=DWAEdlFC3+yN2oI9TavrfsZxuJTSD12sq+7ZpsG+Gs7zHAGEe82AvbQTGBQvDK4PJK
         Lsuz+xxHVk+6NC+QsqQrqjUmDKGPJa/MLocM69v1lXQDeZZ1ulMmcJQSQ3YsY4rTiQ5o
         vGdBUmnP4UyH/hxj9OlnRfGmd9eqKwgzd6bBksPiU5xoeGpuKeiGfvsnzBdfjBZD8vjN
         sp8CW8cmgnI44qdfr0JPNNH4c67Xmhp6o3AoGxjI0Kkvj9Qq3gAS8r3UQFNGaUIUilDv
         rLxiXVRvHg8jGIXQoB/+0W3Djuaasc83juJbNm5T31TBxNHnHu09w6GCg1ZUbUd9Hino
         NUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085048; x=1793689848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s86LnAWFmWP59VgheQcHJpguzX26fuGNoKB7W+R3clE=;
        b=UgkO2EgRjyJon6sGY/ocPBcNLeJUuYfUeWBpmktuEso0V+ICdWrFmgBeF9umGSSW33
         V+YMRV8lXNEiii5nVYtvmY0aI+GAFm2YW+TGwYVKfovh8F5OwXTmPlZc5/OBO/j4YuoI
         RGGUryWC+eS/wXrc4Hb4YHtarh0HFC5Y7JuWNIDpkZnIlCyhM1/GctVFEp1oY/yC1zAd
         jZJT1XEToT32rroya3apdAD3el359esrVNu7k8bWxG6KAg9QjDJnJHi+7vA5CXzN+gji
         HUbaw0wKoMwABQGha/UP+6U7QdeIukk50YkOXZaK+m43GIiKPE/2ZrLqBArBvUQUrZSR
         WBEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOeQifkE3YS6hB4IY3kVYBhpUYYbFj3g+1WCgLP/XmSMjzu4yhD06hKuGMslRP7VwXtKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJu42niMlRQQGxWWQjtpYArDR4ss2aKrH6MwvQ6gB9sEqTv43w8
	A0N87ZdrrfSCgKwaSP8T5Pr50LtuegbALh9AvtJqLAk6jACw4f41gy3r
X-Gm-Gg: AYBFou07Ji2gy0nmlQM4qZGk/Iuwep8v2M0WWnnsQwCZIyId9PrpjbUNdTT/leWv+Ef
	OG5bfhO2/IyWMjSxiI/SckgebuWOQRa0MIy9wlzZ0YmvjEqBM+nljW6LmUikq099Mr7z0JW6C0D
	nOg5mb029PwZUWBrM9MPOK0i48WphqAs0kbVu9LbBvn80jkFvuSsl6mK5y3Xp1OW79BPyWQ88z9
	2LsbI+sF/I4kY4uCemK0HMFLc+ydpbxFQGGu12mE7TCq/QjARCtNY9wnVrCvHHvlvX1rcBRtLC2
	WuFMvdrXM5lavVRh6lNQnBZo4a+AzEiM4Fg/XZjgeT4DEat1xPO9H9E6vI53QQUp24FvRYYqPSV
	0Xh/k6Umkd7bvZxygANpMdb2AlF4JrMZ4UFX/nBfXuWxU20/dcYQregsuqTKx/9BHoGJvIIZ+1d
	gR73HlaaGGJME423dqtOOYOuyaqnnimr2UrYdkdWmSry0hDQHWoBSk2mbMAf1bayPG3LblS7hvt
	hpOjOCW8b6tpajP5/i8csOsCS5eg0fzkLn2jI1KtUSwfy3ws7K1ndQtL0axUQ/qqJDm0Gx3hg==
X-Received: by 2002:a05:6300:2786:20b0:3e8:d18d:c68c with SMTP id adf61e73a8af0-3e8d18dc748mr2680636637.62.1793085047559;
        Tue, 27 Oct 2026 00:10:47 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:10:47 -0700 (PDT)
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
Subject: [PATCH v2 05/10] rcu: Validate callback arguments in Tiny RCU
Date: Tue, 27 Oct 2026 15:09:18 +0800
Message-ID: <20261027070923.3054462-6-kunwu.chan@gmail.com>
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
functions in Tiny RCU's call_rcu() path.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tiny.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index bd22fa43108d..ef0b0474f207 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -252,6 +252,13 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(head);
 
-- 
2.43.0

