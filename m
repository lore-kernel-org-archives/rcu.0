Return-Path: <SRS0=mwIH=WO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0CC3A589
	for <rcu@archiver.kernel.org>; Sun, 18 Aug 2019 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D121852
	for <rcu@archiver.kernel.org>; Sun, 18 Aug 2019 21:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sFx1qyWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfHRVuH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:50:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33607 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRVuG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Aug 2019 17:50:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id go14so4505809plb.0
        for <rcu@vger.kernel.org>; Sun, 18 Aug 2019 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Wg9JME0FWTs1tYyJ3nmuvph2mMJv0VgG1hoJmiI+89Y=;
        b=sFx1qyWsXacdqGPc0XPcx/uSYdMTruibrn5pboJKb0GPUIVxMWLd6yd09zXGovBFEI
         31vFPeXRk7jCScWKtdivUBw6ciSCob0vEGXgbXo08y2aals0woz+GXdP4HIl1/QQlsRa
         bzBo2BdvaV+I3u+DQVQGNIMPMYPA97ZyNigQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wg9JME0FWTs1tYyJ3nmuvph2mMJv0VgG1hoJmiI+89Y=;
        b=EvB56//7zsKBYLU4HMEhl5mb4t7SHASobiCNJcWyBF6C7ciHbuDQlPQf4uivsGydeu
         cjHoe6WD32TtErDjkw5mxeS3b6Kkxr1VreHMKd1bfezOke0ZAOiCet5n8mFDlA1uqMfq
         Qv8dEPyOa0sAZCc+/OruudwNQb8LVVaolQx8Bv9zdHsE9Ba7GffwGT+GTS9xMH9TCIPD
         3vimuhsPIRkyY3M9coD+ZrWhoJTfywD9xZ+XnZieR48w/7WYIBtiNHNVrRj/O70yxgi4
         y3VZWRr8MYRuWCmu3WVgNdG9JdzZY0CZeW0yF97IURmHIx8Y2HxQVdFubdAaVtsy9nPL
         bf+Q==
X-Gm-Message-State: APjAAAUdRHQf7eSo3dtca0Xey/Gvxc18M05gh/yBpqhFCQp0CKBhhcUu
        91zxJdooZFqN287R5FD4TZO9kzB0mGE=
X-Google-Smtp-Source: APXvYqzdnZqbCZQxwGZmMxdNNdL2R6VE2UIUjJOX/DEW15dQCctAiH1YCOyh6z0/ZGjPA6AXwR46cw==
X-Received: by 2002:a17:902:822:: with SMTP id 31mr1685767plk.343.1566165006033;
        Sun, 18 Aug 2019 14:50:06 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id f12sm12543645pgo.85.2019.08.18.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 14:50:05 -0700 (PDT)
Date:   Sun, 18 Aug 2019 17:49:48 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during unlock
Message-ID: <20190818214948.GA134430@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
User-Agent: Mutt/1.10.1 (2018-07-13)
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

We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
if expedited") thus doing the rcuc awakening only when none of the
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
v1->v2: Some minor character encoding issues in changelog corrected.

Note that I am still testing this patch, but I sent an early RFC for your
feedback. Thanks!

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
+			// Safe to awaken rcuc kthread which will be
+                       // scheduled in from the interrupt return path.
+			invoke_rcu_core();
 		} else {
 			// Enabling BH or preempt does reschedule, so...
 			// Also if no expediting or NO_HZ_FULL, slow is OK.
-- 
2.23.0.rc1.153.gdeed80330f-goog

