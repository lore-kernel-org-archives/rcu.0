Return-Path: <SRS0=CVHC=DG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F920C4727C
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D682083B
	for <rcu@archiver.kernel.org>; Tue, 29 Sep 2020 19:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ce8LTnc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgI2T3p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2T3p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Sep 2020 15:29:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCEC061755
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:29:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so4559271qtp.13
        for <rcu@vger.kernel.org>; Tue, 29 Sep 2020 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQjBA9NgyL26LnUuoSDLOqhNdN/FWjyvKU8svYcqWsk=;
        b=Ce8LTnc8e/zH9MehkioLTQWGUhuleeWSeiMQwntLEhQs92eE59HfRttFq9qE61S2Xw
         0F5HbktYGoepjGQHGS7dw5Re7zLmU4a0zcP3keEqP51Q0tl44DJdrfoSR7VjDnu3kpk9
         ZjEmjob35yN1LhZLsOSWox4kpZZGaUYjZZ95Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQjBA9NgyL26LnUuoSDLOqhNdN/FWjyvKU8svYcqWsk=;
        b=ItPIpzF8cOvB1q0/am2HZXq3zvA8zyHfIAGlv9iTSQeMZUHhSuHdqt0gFcMXFCCKga
         WejQVw3XfKX5sdLAsmXw/3pMHjNS/kDg4tYW4bcaAbTEWbO+uCo9jeFNfhhSha+celf3
         U/ym6J1RM+Yp5CaHJYnepBlQgaeFYCVL+a/SbdlclEfisK8UvkSOaWMNofQFmdCBC4bs
         O0LRp+KJ0qol90O2jgIlyXaho3YhsW90w54MbXNdCVPMzif59NCUeGkz+vBr0BimJOay
         vAt+E7VxLKHvto9UzAha7tsm1ZCpLbXZAnJnv3OkhhmvxqBLRyevvy7R4LBJpgvmuz16
         y0Bg==
X-Gm-Message-State: AOAM533SAPxs2pFg2wqnsZCXd56BRokftHK1prQRTNXZ0s7FGAiG4EBq
        MrIjy+gYFAXTFquLB/C9icfcuQ==
X-Google-Smtp-Source: ABdhPJy25X9n2PF95bcmGXJqCqVjaGo9NuWiG7UnaK6M9X2h10n1bvAtigH8Vr5rL4Np5meBMDld5A==
X-Received: by 2002:aed:2f61:: with SMTP id l88mr5024636qtd.262.1601407784422;
        Tue, 29 Sep 2020 12:29:44 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n7sm6892887qtf.27.2020.09.29.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:29:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not report QS already
Date:   Tue, 29 Sep 2020 15:29:27 -0400
Message-Id: <20200929192928.3749502-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_cpu_starting() checks to see if the RCU core expects a
quiescent state from the incoming CPU.  However, the current interaction
between RCU quiescent-state reporting and CPU-hotplug operations should
mean that the incoming CPU never needs to report a quiescent state.
First, the outgoing CPU reports a quiescent state if needed.  Second,
the race where the CPU is leaving just as RCU is initializing a new
grace period is handled by an explicit check for this condition.  Third,
the CPU's leaf rcu_node structure's ->lock serializes these checks.

This means that if rcu_cpu_starting() ever feels the need to report
a quiescent state, then there is a bug somewhere in the CPU hotplug
code or the RCU grace-period handling code.  This commit therefore
adds a WARN_ON_ONCE() to bring that bug to everyone's attention.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55d3700dd1e7..5efe0a98ea45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4119,7 +4119,9 @@ void rcu_cpu_starting(unsigned int cpu)
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+
+	/* An incoming CPU should never be blocking a grace period. */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-- 
2.28.0.709.gb0816b6eb0-goog

