Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF2AC6FD1C
	for <rcu@archiver.kernel.org>; Sat, 25 Mar 2023 17:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCYReb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCYReU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:20 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F5F75B
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g19so4488997qts.9
        for <rcu@vger.kernel.org>; Sat, 25 Mar 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONoHk+Rj1ufMcYHSOwfNTPmuuZ3mXzko5D4ACMs/eOA=;
        b=ikQ37MdCcvJ+qjCxLa0DlYnQ1qgqtu0+7/KD0Bb/Tc4mBBI7pxErsaA3YnRKCfkpmX
         3p0P+l2DU6LzWXS3KmQPuTqncSpWI/pcmz1ufIhInc5srxC3za/4WZhFXfWgLnnaNFNZ
         Nk9m6/9CnTBL+94W3Acb2UnO12oHOjCG9k8vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONoHk+Rj1ufMcYHSOwfNTPmuuZ3mXzko5D4ACMs/eOA=;
        b=HRBDPp8HmAnCHfAd/JdwOwagVA7Tm1UP39wgB1rZBQjQVTNiQcllpH127MeeVbAiro
         K025551FGUMhJpZyM0CHihYR0q+4+mpQ1o4sLwVj09YXx9fxwCvo3hlCKAVOuNki+Lxd
         nLW1N/ubV9FvovHtf7rytq9vtCIlgQ4hCMx7EPQK9E8dUwgqZIo+Rm2lAhx3ytJfjdH7
         JMlkgaEtexOsnJpC8OP/1mxJQMUja2XMSxorOqcV+inCKu5V8LAxgnIYjhzRyn2WCDxd
         6KMGfBg7Mhtm1IRY+Sjx69q4Bo/fZtX+EmKoFZmUSvhz8zy5o4CAMmtWaLt1z5YWh7dZ
         wdCA==
X-Gm-Message-State: AAQBX9ekBequUcObbBUFZ9+RtroNv+1XDqnaONbS6hI+q1d6skbqwO2U
        rfKMUuB0pCYmD6VTlPKMmBx5yg==
X-Google-Smtp-Source: AKy350YEgc1Eq00eYoCtjBB7hMJjZEs/02/OUcwF5Nmwzwr8rFs2fkTW9CVn5OaLI4MsCVSYmWRBKw==
X-Received: by 2002:a05:622a:1a0b:b0:3e4:dbaa:8a05 with SMTP id f11-20020a05622a1a0b00b003e4dbaa8a05mr4599709qtb.0.1679765647265;
        Sat, 25 Mar 2023 10:34:07 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 13/13] rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
Date:   Sat, 25 Mar 2023 17:33:16 +0000
Message-Id: <20230325173316.3118674-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario can
result in a NULL-pointer dereference:

           CPU1                                           CPU2
rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
  if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
    raw_spin_lock_rcu_node
    np = rcu_next_node_entry(t, rnp)
    if (&t->rcu_node_entry == rnp->exp_tasks)
      WRITE_ONCE(rnp->exp_tasks, np)
      ....
      raw_spin_unlock_irqrestore_rcu_node
                                                    raw_spin_lock_irqsave_rcu_node
                                                    t = list_entry(rnp->exp_tasks->prev,
                                                        struct task_struct, rcu_node_entry)
                                                    (if rnp->exp_tasks is NULL, this
                                                       will dereference a NULL pointer)

The problem is that CPU2 accesses the rcu_node structure's->exp_tasks
field without holding the rcu_node structure's ->lock and CPU2 did
not observe CPU1's change to rcu_node structure's ->exp_tasks in time.
Therefore, if CPU1 sets rcu_node structure's->exp_tasks pointer to NULL,
then CPU2 might dereference that NULL pointer.

This commit therefore holds the rcu_node structure's ->lock while
accessing that structure's->exp_tasks field.

[ paulmck: Apply Frederic Weisbecker feedback. ]

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 5343f32e7d67..3b7abb58157d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -803,9 +803,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	int ndetected = 0;
 	struct task_struct *t;
 
-	if (!READ_ONCE(rnp->exp_tasks))
-		return 0;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!rnp->exp_tasks) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return 0;
+	}
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-- 
2.40.0.348.gf938b09366-goog

