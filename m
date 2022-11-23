Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709A8C4332F
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiKWOC3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiKWOCE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 09:02:04 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85078517B
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v28so17360592pfi.12
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frc03htJZ059XDf8jvNx8xF1z8MxlsBIYwkX/Pm2UpU=;
        b=DNAdAzBrkta6W+WG60HsupasjZnlUbd9g8I9n218vA6Zg0HdfNY4d3QYwpH8uZ04Q+
         j1XlaK8G39QrGPfYQYZ4uiT3TdubtMJTqRdbGiYSG2G5mL1d4omzmkCTNsvirkJBCryF
         5Ud+I6gf6myz3uPJdGF04GZNafZH65LaJRRdvYPYu3tx+74RLvGQFCKGgjk3XGynIRFb
         7hkj68fDD1pRerQf5LeTPX4gFtuk1PW6iFrToZiKiePAP1TmLHIhqSqwmVtGTAClmG2d
         zyAJAWRN1do6pbcOGbpHrI2wymOnf9MK2x4qs3bnLC7KxcywdzU+cmfllG/R4s4MmbWC
         2Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frc03htJZ059XDf8jvNx8xF1z8MxlsBIYwkX/Pm2UpU=;
        b=25qUWByDO6yBHGjko5hy6YsrQoFy+omcTgLfyKUAahFur9bNrP7gvrzHsBE4YDuTok
         QIZC5dKyevtEG5Wvjw776TvOmDZWwhXv67F7+7lcDkf708FE5QiTXSAKYZEOpmY/oXiE
         bVx2Mk/fK5/y4l+dsBEgDXE580UvFteLwoKmvyiqJDPfwZx39iyhrsYzD8CYAMhfBFeT
         6UQOvUJuBeAsophjmh1ucrNpZYTM4O47PoRMIpmesq1UsbwOThu+Fjoqt+UJJv57yT3Y
         LSszKl86sluD+fefzWhGDd6SAvRiTxLMnL7+/edbtvC0Wj8PqhHUABedxyhRKICMNkB+
         wCMA==
X-Gm-Message-State: ANoB5pmXjDDb8yh1fA8uPsRpTjnT26yo8D4KU1ymh3E8C5HQv1uZN9MX
        GkdWvz1wZSmPQWXGEpsDAM0gqprxRw==
X-Google-Smtp-Source: AA0mqf7JZuzYzPQc+lg1xSdGGvT+Nehv8IspFgxhSfhTk4PHjN3OjBmUUQp6xMvt9JDW/aMOtmCqIw==
X-Received: by 2002:a63:5c1e:0:b0:46e:96ba:494d with SMTP id q30-20020a635c1e000000b0046e96ba494dmr8046481pgb.404.1669211828825;
        Wed, 23 Nov 2022 05:57:08 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-20020a63d34b000000b0047048c201e3sm10895996pgi.33.2022.11.23.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:57:08 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than snap in srcu_funnel_gp_start()
Date:   Wed, 23 Nov 2022 21:56:38 +0800
Message-Id: <20221123135638.79021-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221123135638.79021-1-kernelfans@gmail.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since the srcu read lock is still held during srcu_funnel_gp_start(),
the seq snap should be the largest number for the slot
srcu_have_cbs[idx].

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 include/linux/rcupdate.h |  1 +
 kernel/rcu/srcutree.c    | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 08605ce7379d..a09007236660 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -32,6 +32,7 @@
 #include <linux/context_tracking_irq.h>
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
+#define ULONG_CMP_GT(a, b)	(ULONG_MAX / 2 > (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
 #define ulong2long(a)		(*(long *)(&(a)))
 #define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2fc0e775ade4..41902b823687 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
-			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
+			/*
+			 * s should be the biggest in the current slot. Hence only LE is
+			 * valid
+			 */
+			BUG_ON(ULONG_CMP_GT(snp_seq, s));
+			if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
 				if (snp == snp_leaf && snp_seq == s)
 					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 				spin_unlock_irqrestore_rcu_node(snp, flags);
-				if (snp == snp_leaf && snp_seq != s) {
-					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
-					return;
-				}
 				if (!do_norm)
 					srcu_funnel_exp_start(ssp, snp, s);
 				return;
-- 
2.31.1

