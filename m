Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD6423E93
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767961; cv=none; b=N64YECF8nROWrWExq5NnWrYRWPxdgf2ulhk/7fbBjciepP/HbwYRy09KF+pks5/Js4daltqXsOSpDmQY9fTfLh5S+pjt/LMMhh/7tqoivXLk7WDxU9BmfKjtTEQ2tEjBm8zLFNod3sY8P06s88WJc9gb4lU/mRmx3X3ELCd25P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767961; c=relaxed/simple;
	bh=RzK7kMbyNX0ub/uYwf0yfYkwe5IMNl40/Xs6NO4qP68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAIrsaSrO8SVUIB5Iq2jSPqAkV5IIHsPe9f98lVhSxbuuXrt58uCsEB1t0oBwNr6Lhr12e1OiVqRxK7LzxFlJ09p7ox5CZfzSr/IHW8PxngX4+gMMQhFqDYsJ2Vcv89MXiRdBAXUFNlpWFuJbVVWcfGZ5Wjxuv23LZLQ/vu7Q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjoTBF35; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjoTBF35"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ceab75934dso31011875ad.2
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767960; x=1789372760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKFw3PpfzfMC3bCjGChjW74mzAGePmhCsoG4uFIYkwk=;
        b=DjoTBF35k8pJoY/itnQ8weDS5Uya4GAjLz5kc5MU6G6/RELaAPf+poWX0MjouRCgMM
         RMEPIeoPXXeHtJis8HbZZ3cVDTzGQ377RBrafGgece9eUR5oWDj+fot7YH5yOUl6ZzIK
         Gq0Zdy+cuXzRYnGMMJYVqnRIgixD6n/StoNU13J8oiUdVTCP5XCv/2meiMAMaNxL0fPp
         sg2HXmU0d19sWhn22FTMmk8yuQPVz+UT0fWRo+z0wcKJMvCJEqwQTKCaLn/GL1+aYvER
         emVF37/ZpJzfvuKdoKo6fqY0QoSMcxFpFRSbs/aFL2wqFbWEWsfT0A4jG+myytNsqGeZ
         ZH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767960; x=1789372760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKFw3PpfzfMC3bCjGChjW74mzAGePmhCsoG4uFIYkwk=;
        b=pYuqAE115mL/X+YmLwgimJv1HWnslFILQlhXZA6opF03DnC9m496vcWmc6hMaESAv6
         gVBiKltv1gT2VWuLQvXWASdJGpxLAx1QQJ3QpBsCIvACl0CL980ZQ6yqCiELI237I+AT
         G2HOz/vEnOZBVKsep8KUBR6uXNI5D0DyT3Mlxp4LRhJrog62LLNIByX5fgi/HWWXQYLH
         Vgfjfng1wk7ZBuxJMKp1oiBxgAytWCePLB0+Ta7dcK/dd/ouQSFpd6rC4SxJ4QB4ABgi
         svmlnNWbn/2OSKv+CoIby3+hAXMPNiNANeOqqLZxVg1LvrNVC+p2bft9tzT3gLbEG/Zo
         bViw==
X-Forwarded-Encrypted: i=1; AKwUvBw1Jul0RfTZpiXBMm0ZihAnqdO3KgBiAStRMVKgTMuFhukYj0bDXbYpJ1ZM6VLHo8J/FwY=@vger.kernel.org
X-Gm-Message-State: AFuF++knhemT8pCGgaaiKDa8+jZvJiS53o9fNXxA5cb4FO6/ha1DAliB
	gGeFnzUfBI7q7tPYOqEo0cb52DUvRYl0PLLf4u8+UcXcebCxawY3M6WX
X-Gm-Gg: AYBFou09Vb+ohpFbsRyZ99t4VtexPrrtv+/FeOYjns/dyhjN+mAkaS5pOCUZDLeRfFe
	HcDRsaxaIHOucYN6mwFt0BJ3/G/KWNWE10mgwnz2n1uVlyzfMsmxU7c+EgzQHW9rEdIJoZFAcAu
	y5CNeRGbsonx3rEtgJGroCIzPgkL6oJ2K7eoMeBec/lZHFqLZqVv6GglfeOpT4N3tSeTAID2WNU
	hek8MFwjce/uA6LX5RqFG5Ra22oG/SfC6D9OsYkIZpSwrtMb1W6TVNPLQaRNigt/EyJXva5Oji4
	Y2UoQf8uSAsflnu1lm5Pp0GHCrRW6gSi7KCqTRBa//8kmnUb4QaaQoiCB7w/+iyhG+tHGLDEaXr
	wL0gswYzWDVM+rJEbvhTcdFpM0LI8o0I8/xmlReGsquBq7r8Z2jd0EGOd4uOoRGPffNTUHsEwYK
	EIkLSrSbfwKs5fN4dmm9QBX0VUhUMU6pCnDF3Yc52nNvf1FM/D5Rhc0MtCbAW+sPGUK4g9J93l1
	Hlyku8=
X-Received: by 2002:a17:903:1acc:b0:2d8:d4d0:7931 with SMTP id d9443c01a7336-2db128bde59mr303579055ad.21.1788767959527;
        Mon, 07 Sep 2026 00:59:19 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:19 -0700 (PDT)
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
Subject: [PATCH 10/13] srcutree: Skip callback scheduling for atomic SRCU grace periods
Date: Mon,  7 Sep 2026 15:58:26 +0800
Message-ID: <20260907075829.2073224-11-kunwu.chan@linux.dev>
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

call_srcu() is forbidden on atomic srcu_struct, so srcu_gp_end() never
has callbacks to invoke for them.  Yet it schedules callback invocation,
which for atomic SRCU's SRCU_SIZE_SMALL state arms the boot CPU's
->delay_work timer every grace period, only for srcu_invoke_callbacks()
to find nothing to do.

Skip this for atomic SRCU.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2d2a12f86115..c19f59725706 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1018,10 +1018,10 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 
 	/* Initiate callback invocation as needed. */
 	ss_state = smp_load_acquire(&sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
+	if (!is_atomic && ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
 					cbdelay);
-	} else {
+	} else if (!is_atomic) {
 		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
 		srcu_for_each_node_breadth_first(ssp, snp) {
 			raw_spin_lock_irq_rcu_node(snp);
-- 
2.43.0

