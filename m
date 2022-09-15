Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618CFECAAD3
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 00:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIOAOl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIOAOi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61DB3883
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u28so9202072qku.2
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SqiD/rmTmUnZN+sxp6myZ+MDQ3Vwh3eOQpZ6rdR1rxE=;
        b=ZLcx7NHB52/qzkYWSR8ckkf1gareZ4GmzTiq/hCOgGnRBEHkz0NxGweHu1K3EVjRIg
         G3fMULXiX7AFK9DZkvhNqmCZECLF0CkEWQAp6MDA9wyeA6dFgX5uV1lxs9PA0qPeJ9Kz
         BW7OgVuE0HCV8Sui9C6J77DMSvj8TO6/fRzB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SqiD/rmTmUnZN+sxp6myZ+MDQ3Vwh3eOQpZ6rdR1rxE=;
        b=2ID/Du5w/0OI1GQc3gKdPj5F6OVMxOBOAJTCqd35YXZxoga7hx456dNRRHpUgW50ef
         1Abynk1+V0DsFVdtf/JSETxaHsElmZzfiVI2EiBqY5BeTgY04IjRpnfddvOD41eUbMWL
         kRB66Z0dmcAgNZWw+u9Qz/5n5CT1E5g08UYjZMUCTNa97MjdK9DWqMmOjcljjY/yT8xW
         sU5bGCk68ddzUp0k76C5mHxWtTomSg1ZP+v/VbedZY3OpwjqnMHspIP+oHZZQ4XnPp0b
         3U9dZvUsn2I2mjUGKSFr0gtT8UgZPmwdyoTheuTG89D+xbNpYz+n2XIblzwWnSGTd5tu
         oHJQ==
X-Gm-Message-State: ACgBeo192OazuVegyybFnFOUWSPVV1XDwd4SSBBY5GgNcQDE7sc4W9ps
        R7m36L0xFyti4UBEoa4FlnmRtw==
X-Google-Smtp-Source: AA6agR6Jaelol8J/6+LJ4V0dMBTzfQIqYm7WXyULloG4qJkDuOxHTYKXfQ9I2xuKCi40lhnAtDyzpw==
X-Received: by 2002:a05:620a:318a:b0:6ce:732a:f92 with SMTP id bi10-20020a05620a318a00b006ce732a0f92mr6969342qkb.347.1663200875110;
        Wed, 14 Sep 2022 17:14:35 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm2872422qkb.108.2022.09.14.17.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
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
Subject: [PATCH rcu/next 3/3] rcu: Fix late wakeup when flush of bypass cblist happens
Date:   Thu, 15 Sep 2022 00:14:19 +0000
Message-Id: <20220915001419.55617-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915001419.55617-1-joel@joelfernandes.org>
References: <20220915001419.55617-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the bypass cblist gets too big or its timeout has occurred, it is
flushed into the main cblist. However, the bypass timer is still running
and the behavior is that it would eventually expire and wake the GP
thread.

Since we are going to use the bypass cblist for lazy CBs, do the wakeup
soon as the flush happens. Otherwise, the lazy-timer will go off much
later and the now-non-lazy cblist CBs can get stranded for the duration
of the timer.

This is a good thing to do anyway, since it makes the behavior consistent with
behavior of other code paths where queueing something into the ->cblist makes
the GP kthread in a non-sleeping state quickly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..04c87f250e01 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
-			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -447,7 +448,12 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the regular list.
+		// Don't wait for the wake up timer as it may be too far ahead.
+		// Wake up the GP thread now instead, if the cblist was empty.
+		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.37.2.789.g6183377224-goog

