Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF03C433FE
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 15:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKTPU6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 10:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKTPU5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 10:20:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A601F63E
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:20:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s196so9083100pgs.3
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hbo4ASnt6Ex3BNVM9to0bZhAI8FlYMU2cibb0s23NM=;
        b=FhjoXx/c/ot3peGNoYlyiDxN3gBsxPxrhcWDvS5lyz58Y8C04YzFN6QovV65+FtuCR
         IW2Y3UynV3U8ZNiRVGr+oXG+Q4fZbDmlhWJuz8KkudixJz2IMUr0KiQxhTsq4zyDk/7p
         nPbRIatWRVJvTTl0ffLyQ6wKGonDCy6vfDr4hcsaZZJkmkb575/23PGgwJTwnX6sVchu
         +usIE2lmDHUce2OYZvDQjOPDNLSKZelNWoVjao5lAqzNnV7NMIKHAEJsM9+ayl/ehLjV
         YPL66cZJinig9MUK6OT4wzEA50nWr0Mhp6hco/GlKF1veUSDUVPSE0KFi73ZWhlwapXA
         KYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hbo4ASnt6Ex3BNVM9to0bZhAI8FlYMU2cibb0s23NM=;
        b=yu1GrfYIdmaLYDQyC2g9Ijv8f2yVRchmEj1g5JyI4chyS3NXcTXhlAXQb5TTsQBNst
         h+ilkHAno3Uo0ccZGwl8CDEsXrhWqpOi4OgGoTaaQJ6+w1q6oecyog2Z/CluQCqpzFLR
         iRQr3x2pkQ78jP8w7IWWl2mOxY9yF6iWY55oZe/65wHMXgNCrV5AYHVEk87aHFUmw4+5
         b3jGYHGf0Ljs/8mUcZ5x7Kx1sNdDuRMvAfFhp2KdiTv2HNEaiZdvYB/9yJRogx3H6Xp7
         cStJ+XmlCqwfs4OzMT/Y4/iZK1QsDZ+0y7ZdHrNNr5SSxJlWaRXlZ01kMY0Q8aFhHgvJ
         mf5g==
X-Gm-Message-State: ANoB5pkIQDITq1hbZm2HxY/wSTJXbnj1FNHZRS09jRObzpuhIePYHuNN
        RV8au48GHj2TPdH/lHNvhDzwcQQV6Q==
X-Google-Smtp-Source: AA0mqf5fFm7FIT/thMho48Fngty09rPW2CEe7GoV+Zz56C4Tx+zhMgvGOjMYf5DgkgYYlVVEiUtq2Q==
X-Received: by 2002:aa7:947b:0:b0:56b:a3e5:d155 with SMTP id t27-20020aa7947b000000b0056ba3e5d155mr16348234pfq.23.1668957655008;
        Sun, 20 Nov 2022 07:20:55 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u203-20020a6279d4000000b0056abfa74eddsm6978832pfc.147.2022.11.20.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:20:53 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] srcu: Eliminate the case that snp_seq bigger than snap in srcu_funnel_gp_start()
Date:   Sun, 20 Nov 2022 23:20:40 +0800
Message-Id: <20221120152040.7460-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120034014.7390-1-kernelfans@gmail.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
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
 kernel/rcu/srcutree.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

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
index c54d6c04751f..057752db1125 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -900,14 +900,14 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
-			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
+			/* s should be the biggest in the current slot. Hence only LE is
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

