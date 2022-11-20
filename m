Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA2C4332F
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 03:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKTDkf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 19 Nov 2022 22:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTDke (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 19 Nov 2022 22:40:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F30A8C24
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:33 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p12so7820550plq.4
        for <rcu@vger.kernel.org>; Sat, 19 Nov 2022 19:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY1YP/yfTIErWUpERknfxBPt8SSGSNGDSkDLWbEyYCg=;
        b=b6330JsqAY/qj8cJ/m9McnCdEJKDano2X02R4XFkeSjwA+2uDS07r6ap6roOWS46GY
         zO71il5pzX/cvhdqrGTjui7NKbcOUiOb1V/zrsPD5J1JZudHsIWKUjMs3XNTQCf+zr4M
         E8WE2sSHNn1KFu9UYzPY/nuQ1rz3H2eOw0heAvoT7d4M0nU5+Tm2X0U6RfUaoys5E8jR
         iF26NEx0tRpOOfNNusXIBNDbgri0UrIHjCW41YTiXGY8Qw+sPc93RgGL6m88NKglB+Bz
         +BSHBtw0+fyU5WMIXQmwrmZDzoWVfktuASzL5KG6Clh0oW6nuCp06issFOUQqPqG4A1A
         QXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jY1YP/yfTIErWUpERknfxBPt8SSGSNGDSkDLWbEyYCg=;
        b=OOwrwmzKv2Xkk+MR51qP601NR6AwNWNynS+9TXpKLhU9u06VeBFs/nyljwjemU04GM
         9nxzABxefvFzjxEvo8DR1n7msFyNw/Xdd5Uc+0uMvRm7mIGXNKBsasLqG5twL3OEktr8
         4VSPOp4rBuYhrVWPdaxZnLhhWjksrcrzVrah1aFm9PGIZtcgQt4hn79y9oROkwhANcSU
         3XQDFqUyI1O11fw/gMfJg46C1JIklIEonl/wEdrg8T8VN5LKam8eL9A48MolvSmuGCzu
         2T3GnDMUzAYy0WHSz0kfUdgmzjgmPASj55EDs+bMZhvQez+gkIdFH1YawDK5StRm6jlb
         vZ3A==
X-Gm-Message-State: ANoB5pkV19yB0e2r24PfYCr2h+b7f91NyvdSkm/uu9/CSWYU1e+x3BCf
        0fJukTZ7AD4gLptwCsrBvVDf725BDQ==
X-Google-Smtp-Source: AA0mqf4OXD6+5bo0ImbI/KDamIa/SACamTO4Yx0a33h5wmFikXk9bYUAhJx4DJ5a+RczoylWyplecA==
X-Received: by 2002:a17:903:3295:b0:188:5dbc:9685 with SMTP id jh21-20020a170903329500b001885dbc9685mr6504960plb.48.1668915632575;
        Sat, 19 Nov 2022 19:40:32 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gq18-20020a17090b105200b0021864cf062dsm5297260pjb.21.2022.11.19.19.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:40:32 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while holding read lock
Date:   Sun, 20 Nov 2022 11:40:13 +0800
Message-Id: <20221120034014.7390-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120034014.7390-1-kernelfans@gmail.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
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

Test info:
  Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
without any failure.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..7df59fc8073e 100644
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
@@ -898,8 +900,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
-				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
 			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
@@ -935,9 +935,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
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

