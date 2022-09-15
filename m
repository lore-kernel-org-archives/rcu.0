Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E64C6FA82
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 00:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIOAOk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 20:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIOAOi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EACF64E0
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d17so11372216qko.13
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7NTlW4AVEaEifdUDNJKG5n5TSALhIocTrw3kCCpTxNA=;
        b=aufasvy68P6Ewg+Se2UzkhM+dsbLyQxC4Y8rMgj0/dn7wakhHYWGMOKsnUKG3S4ABp
         6EucXs9y5wMo4i5DJQlt8fqTu/P8aaNCEAyBL7IzBTgXEuHN/qUGlR8gR2BWlMi8Mm7/
         9WKL7uRA0DCxmbHJoZcawp2vF9OiRs32DNSDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7NTlW4AVEaEifdUDNJKG5n5TSALhIocTrw3kCCpTxNA=;
        b=6PyqAKBF75WnlYAbKplvWx7Y5dDLMJzuAlHlCem/ALcuKV5XH4ls+qQJZf2dM4JuZQ
         cS9OlQTQ9gBVo7XAWHkVp/VVSD6elINpjtqstsRxFwua+hAwrX6krE0aBsHO2xYdx4AP
         QxHD0cDZSlNaX7cvzbuDwv682TObOlp+L4n4M4pI/ufdFyW94f2cwUoYurQRtrmoTl9H
         i0VSIl7YpFwp/ACSkjwfphf+IJer3+sibGZeW25q65EseYUB16E88LsqRAPfPGoqBDz6
         WeCdqkLEW0ioRtLjZOOJEVHLwLCgTfxiEqULC84+jd1DPJJl5uSr0r/6j7veDEP2EDKY
         L5qA==
X-Gm-Message-State: ACgBeo0w/HEKp3nyWdl21/c73j5BWGsyQ9FDs75QsHbk1Bjt6SO8WQrn
        pybnKiAWxVDLmH2FTnYpXVvpFQ==
X-Google-Smtp-Source: AA6agR4dx+hoiCK3T5tFVcbkeQk/wU2na31F054HHTCbDwmPVtIe+kG4dyVZZowUw7+G+FYkfxNT4A==
X-Received: by 2002:a05:620a:2491:b0:6bb:8982:8f66 with SMTP id i17-20020a05620a249100b006bb89828f66mr28190732qkn.665.1663200874404;
        Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm2872422qkb.108.2022.09.14.17.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:14:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/next 2/3] rcu: Move trace_rcu_callback() before bypassing
Date:   Thu, 15 Sep 2022 00:14:18 +0000
Message-Id: <20220915001419.55617-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915001419.55617-1-joel@joelfernandes.org>
References: <20220915001419.55617-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

If any CB is queued into the bypass list, then trace_rcu_callback() does
not show it. This makes it not clear when a callback was actually
queued, as you only end up getting a trace_rcu_invoke_callback() trace.
Fix it by moving trace_rcu_callback() before
trace_rcu_nocb_try_bypass().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..9fe581be8696 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2809,10 +2809,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
-		return; // Enqueued onto ->nocb_bypass, so just leave.
-	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
-	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	if (__is_kvfree_rcu_offset((unsigned long)func))
 		trace_rcu_kvfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
@@ -2821,6 +2818,11 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+		return; // Enqueued onto ->nocb_bypass, so just leave.
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
+	rcu_segcblist_enqueue(&rdp->cblist, head);
+
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
 	/* Go handle any RCU core processing required. */
-- 
2.37.2.789.g6183377224-goog

