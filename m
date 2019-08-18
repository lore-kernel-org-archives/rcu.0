Return-Path: <SRS0=mwIH=WO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F6DC3A589
	for <rcu@archiver.kernel.org>; Sun, 18 Aug 2019 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771A921852
	for <rcu@archiver.kernel.org>; Sun, 18 Aug 2019 21:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BVVH68/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHRVmk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:42:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40734 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfHRVmj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Aug 2019 17:42:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so5718723pgj.7
        for <rcu@vger.kernel.org>; Sun, 18 Aug 2019 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61qLZ7UMFaKVnDV5mvBa0eWjDF7eSf4QHPHUhwbs13k=;
        b=BVVH68/aMMzu/429+ZaQeCfbshDOPRzdi/Zxce3MtKGuKnJeLkNmTCf2KOqlvmphRR
         TzlFhzxgs0tDoc1+KokRw9UiQLd7NVTYtJfFwS+cRoJ1KI7kte7q7+uDFbLrAYuOBUHC
         iDLSCqRHXI2rPctCN+qWS5tZDWQEfE9wILUuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61qLZ7UMFaKVnDV5mvBa0eWjDF7eSf4QHPHUhwbs13k=;
        b=J6biDfWN0EZdQIXQemX0zyY/7D0q9sylGoZmwhiSjqh6px+A8EV4VZx7UWfqn0kCYj
         eYGBwV8kW2LWIhbgTi0OV0NJN75FLdsq1+6Y+I8V41uBN7y1q7AUeFXoF02K203iqdsQ
         r2S+0yr5cs31bERWT+idmlYqv3zrpl488mIfCayR/MuclhUNJIh972A4l7SIRmNDWumu
         M5eAyBZurrtqxibAftnmUR6JEaynJY2+NCw8G6ZvCg7CHNgd6RTmcfM84yGtkLNKJ4kW
         HLJV47dw3xAMq2ET716r/xOVxJwRIGDricdDkL3QSxwR5tnhwTQx0zgIBS4zUGVKK92D
         6CPw==
X-Gm-Message-State: APjAAAWx1q1/vv1QSrdZnrMAl0sOiXVwGiuHMYPvSLE0inrl3mhk/ZWQ
        58IF4UMbhsjM2BT41xN0h0Zo/TfILok=
X-Google-Smtp-Source: APXvYqytmoCajKgT1HTwrvLq7wVXskpPzQCaejI6FRVLsAHWLgA4uELRyrcs9U65w08NohIP172ysA==
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr18177895pjb.85.1566164559139;
        Sun, 18 Aug 2019 14:42:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id d2sm10456089pjs.21.2019.08.18.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 14:42:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC] rcu/tree: Try to invoke_rcu_core() if in_irq() during unlock
Date:   Sun, 18 Aug 2019 17:42:10 -0400
Message-Id: <20190818214210.133525-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When we're in hard interrupt context in rcu_read_unlock_special(), we
can still benefit from invoke_rcu_core() doing wake ups of rcuc
threads when the !use_softirq parameter is passed.  This is safe
to do so because:

1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
conditions in rcu_read_unlock_special()") by checking for the same in
this patch.

2. in_irq() implies in_interrupt() which implies raising softirq will
not do any wake ups.

The rcuc thread which is awakened will run when the interrupt returns.

We also honor 25102de (“rcu: Only do rcu_read_unlock_special() wakeups
if expedited”) thus doing the rcuc awakening only when none of the
following are true:
  1. Critical section is blocking an expedited GP.
  2. A nohz_full CPU.
If neither of these cases are true (exp == false), then the "else" block
will run to do the irq_work stuff.

This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
check added.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree_plugin.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c3..f4b3055026dc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -621,6 +621,11 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Using softirq, safe to awaken, and we get
 			// no help from enabling irqs, unlike bh/preempt.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
+		} else if (exp && in_irq() && !use_softirq &&
+			   !t->rcu_read_unlock_special.b.deferred_qs) {
+			// Safe to awaken rcuc thread which will be
+                       // scheduled in from the interrupt return path.
+			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
-- 
2.23.0.rc1.153.gdeed80330f-goog

