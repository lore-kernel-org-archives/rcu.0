Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86FC433FE
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiKWOCX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbiKWOCB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 09:02:01 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D956450
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:05 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so17382076pfz.6
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoUggZl+Oa5NqrF+uLpglO5wF50cmi6tsX38yMVbO3E=;
        b=ILt6dTIA547h28Yj15g0Y/sKxXoGVj5M7+zN2pyrk5KNRl3A898noDHYKpLBvAW5o8
         FLlIF84aUj1fuLzV3zpeha4evQIOCWZJ0cMgbfNkvBMH/n3EAK8m6XO4jfcC6WNj6zRI
         J13hkrJ0amr7MM+O+DbXuCO8AyYHll4S6I5LID22xCpN8L/2UNidd3SZgeHmT3ibDnxs
         end542+dcYkc3hPu81nN5LBxkjtud3oomI+KCTqN2L4gXlGSKjHFIPl7DwLTOgD3Wl8r
         YMitso8ONaBXv6kTyyWfVJxSi0HiGwvybDTCi/YnZ7e/2ALVuEcP93a/ZouNLq3uWCVG
         V0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoUggZl+Oa5NqrF+uLpglO5wF50cmi6tsX38yMVbO3E=;
        b=wIDsZbhQD1riwuo5By9SbNHUBkfXOIeZdhai46sEizuudmiocSFxecqxO2/V2FuBKB
         kgCldBZTysn2VZyS/dOzte8c7LGa7JNmCrjWUE+/ftiTpp/xpx7UKojaf1GTIPmW50CP
         XCx5vgK5N6ikr46G8W5CS0j5uu8hqEKh1/G2T2zL2X0qrDY4H/0Ug8ysTik5azFeVd2F
         onR9l7xciW3Pqc5OXj7cvn2ysN9wSPFA7S3pVh97SMhwRMw0JYr3VyOnGrfU4M9ghPz2
         5dqJa83P+YcwECiCed2N1SbVqGuBfylkvQcvnHEMsG/9YrBgEDue6sjy6vA4Cr0D7T+w
         rr+A==
X-Gm-Message-State: ANoB5pn9dvLwH2EIdMqdBYTipaH57nxEeAzu0yM9AIKqTGwRBauaW6pj
        oowK0j2cb5yVBmNvdOavGbrRivR40g==
X-Google-Smtp-Source: AA0mqf5yxtbSdbfLYbHfKFMCvKkDc3EnizBjuE2ocq8LqmArFQW8Nh7zrCqvKlse1M+DvzuSnQmNrQ==
X-Received: by 2002:a63:e444:0:b0:477:6a3a:e614 with SMTP id i4-20020a63e444000000b004776a3ae614mr8636562pgk.81.1669211824273;
        Wed, 23 Nov 2022 05:57:04 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-20020a63d34b000000b0047048c201e3sm10895996pgi.33.2022.11.23.05.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:57:03 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCHv2 1/2] srcu: Remove needless rcu_seq_done() check while holding read lock
Date:   Wed, 23 Nov 2022 21:56:37 +0800
Message-Id: <20221123135638.79021-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221123135638.79021-1-kernelfans@gmail.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

As the code changes, now, srcu_gp_start_if_needed() holds the srcu read
lock, gets the gp_seq snap and call srcu_funnel_gp_start() passing that
snap value.

As the rcu_seq_snap() promises "a full grace period has elapsed since
the current time".  In srcu_funnel_gp_start(), the statement
  rcu_seq_done(&ssp->srcu_gp_seq, s)
always return false.

The same condition stands for srcu_funnel_exp_start(). Hence removing
all the checks of rcu_seq_done().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..2fc0e775ade4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -851,8 +851,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
 			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
+			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
 			sgsne = snp->srcu_gp_seq_needed_exp;
@@ -878,6 +877,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
  *
  * Note that this function also does the work of srcu_funnel_exp_start(),
  * in some cases by directly invoking it.
+ *
+ * The srcu read lock should be hold around this function. And s is a seq snap
+ * after holding that lock.
  */
 static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 				 unsigned long s, bool do_norm)
@@ -895,11 +897,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	else
 		snp_leaf = sdp->mynode;
 
+	BUG_ON(!srcu_read_lock_held(ssp));
+	WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s));
+
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
-				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
 			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
@@ -935,9 +938,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 
-	/* If grace period not already done and none in progress, start it. */
-	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
-	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
+	/* If grace period not already in progress, start it. */
+	if (rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
-- 
2.31.1

