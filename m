Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A24028F2
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767973; cv=none; b=m0YWLrwKpvygd00Bx36CRWauP5xPRcBx4PzWswwBfc+4GR/QGjiT7FyS5LSK9SRp3G9/sDFEcKuaZA1ADPt8z1UOuZM6TDVT1yO8BiowhI4MZ+Wv4yp8OoSmf6wk+20vTzftBz0NDb2lMcNWbARsClYATcWSYMfDB+JBlcjxy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767973; c=relaxed/simple;
	bh=uQx14bVi1sWpKlGObq7Zs2CltXZjAT2cZVhLEUWzylo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir5nABpXoAq+o9ZFB0cV6pf4GeYUzCqJr/fLbGlcg1QImzK3DU7zSet0RgzUMZr+DDGjJJXfNxtp4on1hQpjAvrxxwbMqL2CSaDTRKvzErA+cLHLVtmWgTkTuXT751jRjp+7LuPpCdoZ0LWmhdhc+jBGtE0U5hvnKugPINm80gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBs9gmtf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBs9gmtf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d560775ca2so21971105ad.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767971; x=1789372771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pmdmw98hxU+ikwRZNh3C3CJu0WUlu7q2qMzon9en28o=;
        b=tBs9gmtfPfGvOxO2rtLMEH7PzNnPbDBpXTRWq3mQRHOe6K1AJfu8t1jTzSiarOKQjc
         srPeWs9xCbsMy5c2MYxWpgxptbxeUaYTmOOGhHWWhJf9lWY3T7wAfqYK1Deyzb3OY7HS
         Bvr4n5Cha3Q7PrVMMPP3BOR+O6CvzA9FR23xYUnrWIEV5kgwVomxm6F6kpgJrIabBi98
         kZv5Grnb6RDiieh6TkcYLxDYPKXN5vfd8L6wACfoaCJivuVLufXLQJct78MQ74ZZDCmb
         okB0iuXycr4h3Qq4TjocI8KLBFF3TggwYlc7agCvmi7GUDmck2qsNZY8XsR3PEQtHqUu
         9vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767971; x=1789372771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pmdmw98hxU+ikwRZNh3C3CJu0WUlu7q2qMzon9en28o=;
        b=ROTt3+a+QPeKlrfvtAn/TBH7+IMISMOugkXj2OCjhjbE+k9bHPkNfdhucZl1sOnI3H
         m7SE7wHbUNepwgKrwJUPZNqAQzr4SQCXMfg3toJaXbq9q86js7VGagQlE0kJTT8/4u9J
         wKiHsTMMdIiuwCWQ9BNZTpPg0JA/2JCKA3baIJFBgvORujp3fp2V7s1OFHnGEgx7GIE1
         QVW+0AolqUpBmHF3eB6ffq36iSlP3vgk6x8fIyPQfx+ttDgE+6AbJ8VMibDrRZDg5JnS
         7PFAqJyhe5QvIqy6HfJ2L+isw7tkN3DO+DEwAI7NuE4q1EdhbCQrdipvNwmtTf+3+Dl0
         seTA==
X-Forwarded-Encrypted: i=1; AKwUvBzb982ycyVph4quigxpe2UkzNiiH3UC2i0vU3f+YBBB2+Hridk70Mbc+KnI5l1hoWM0JSo=@vger.kernel.org
X-Gm-Message-State: AFuF++mqdSSJpCtyG8orGMEaKkOFzxVSU9jqH5+FAS9tP///ltwBJue/
	6jhUDDOo8rbiOftbxqHOqzQtW+wo1NqOSJWyD0zzC6kEGxYoTKx+E65G
X-Gm-Gg: AYBFou0/rXaO4ZX7bLfYd8CEOPXOTAqC/FqVgvVe3a4HxgUAj4svkjv42K7PJUjwLVo
	cGphRxZRyGrIRJfkX00AXPgOG6rXateT9q9VXiWEeNxpdDYMHenAUlMXPyHVOCzyAg9XhqWZPtC
	gqS47GWqdEEwd/J+SpLLfpDOqlC1AOkpX/sRkjzMKdeqOXwWwaLWA089lwU6Q/TQKxyT9gFNKtd
	Y7297R/UCnJjyCtKFCwQE0mnfjBYrXvrxJ6h9adsdVzCNF152wOQEBLa1pSEEkJYax5k1Le1JC0
	eAedGGRsI5eIrH2Biu6Usqspmf4Qt3srEPuaGo6AGLaQ4DYFAMfC1CD4CbBnj5rJtlaErU+7CN1
	B4NFve/wt5z2ToRccJLfRnGlARub/FwoX9FRnaTrajSodJ+3Af0KWpIkAgHIyNkNBmQeD0bbt0G
	tjirGG/20WD7gBuvUCQfN3vbql7GymnIys6vGeL8LI2NV3fYDSfhIqQ4eG0l2oqFB5+NGYiOFP7
	qTKWgU=
X-Received: by 2002:a17:903:40c9:b0:2d6:f6ba:263d with SMTP id d9443c01a7336-2db124b451cmr295656785ad.7.1788767970456;
        Mon, 07 Sep 2026 00:59:30 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:30 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 13/13] srcu: Restrict atomic-SRCU non_block annotation to task context
Date: Mon,  7 Sep 2026 15:58:29 +0800
Message-ID: <20260907075829.2073224-14-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

srcu_read_lock_atomic() and srcu_read_unlock_atomic() arm and disarm
might_sleep() checks via non_block_start()/non_block_end(), skipping
hardirq so the update does not land on the interrupted task's
->non_block_count.

Inline softirqs run on the interrupted task's stack as well, so a
timer callback running atomic-SRCU readers races with the interrupted
task's own ->non_block_count updates, as KCSAN reports:

	BUG: KCSAN: data-race in srcu_torture_read_lock / srcu_torture_read_unlock

	write to 0xffffa00f818ea418 of 4 bytes by interrupt on cpu 0:
		srcu_torture_read_lock+0x422/0x470
		rcutorture_one_extend+0xdc/0x600
		rcu_torture_one_read+0xd1/0x330
		rcu_torture_timer+0x75/0x140
		call_timer_fn+0xe6/0x2f0
		...
		run_timer_softirq+0xb7/0x130
		handle_softirqs+0xfc/0x3f0
		__irq_exit_rcu+0x8e/0x100

Use in_task() so the annotation is applied only in task context; it
is redundant elsewhere because might_sleep() already warns about
sleeping from atomic context.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/srcu.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 0de21155abc1..403fbe57ab15 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -346,11 +346,13 @@ static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
 	/*
 	 * Arm might_sleep() to catch even a *potentially* sleeping call
 	 * in the section, not just an actual schedule: the atomic-domain
-	 * promise must hold on every path, contended or not. In hardirq
-	 * the annotation would land on the interrupted task; it is also
+	 * promise must hold on every path, contended or not. In hardirq,
+	 * softirq, or NMI the annotation would land on the interrupted
+	 * task, and can also result in data races against that task's
+	 * own non_block_start()/non_block_end() invocations; it is also
 	 * redundant there, so skip it.
 	 */
-	if (!in_hardirq())
+	if (in_task())
 		non_block_start();
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	retval = __srcu_read_lock(ssp);
@@ -562,7 +564,7 @@ static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
-	if (!in_hardirq())
+	if (in_task())
 		non_block_end();
 	preempt_enable();
 }
-- 
2.43.0

