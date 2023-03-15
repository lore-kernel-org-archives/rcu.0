Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C2C6FD1D
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjCOTpK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjCOTor (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712646C1AD
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y10so17531906qtj.2
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B9TRjdncmXbZW5HDxJoPgY1Lgs+0sxOKkTAY/VF78g=;
        b=dqOfXnxHTLjoCGihltc9NkJBBAVuV0+9aZqiLbjL4hII42e0QglBr/nfEAbRs2bOkJ
         GJMPOjeYCEpzI+Scjv/06JFOBqgaiyJfIHVZH/2XR0pVlXRzCzTggamJVGUci2HlXgXm
         tuGi6ULhvXLuP1gdGRXg0ylLcoiFMYJdJDCmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B9TRjdncmXbZW5HDxJoPgY1Lgs+0sxOKkTAY/VF78g=;
        b=CebZFsC2oj0Fk8wH+SCflDmBPz8Wg5R0dgMn4eDWq7YuYZ2I5E3Bt5a4pv15N89nUt
         WyUXrJ081q2kl2Wd00fzw/AXnBKPKNfAETvic9KKGEqEwQYTe4TpBjKkyW1N2fjmv5/8
         mqUfy0VLDmCcaIn7nxLVK58lj2v24zl/kMqGMLP/6JpRKKOpJyTbqgpndD558Ydi1lP6
         aYa7AR/fMvx4mA3yPFFI62f9EIKz4YrRPISSFBTcez85nqJ4kDGDto4gfNNX8P6sNVv0
         7QmSaJT9sAu5dIcTK1onGINjAuBvt6DCvSvzla0NgAC9jIAtZGVyo0nvhZTOIpZ3oseq
         8hTg==
X-Gm-Message-State: AO0yUKVeoi8gTSKNroSfnqHJgr7BnqwIwadHbO5hHKK4CCJcrBg18dYo
        hc3EpcKO0YDt3CAnWJQHSNNIQg==
X-Google-Smtp-Source: AK7set/vWDGY32rblTovY6ftZOnuWh8zkM0Wz+Ch7gWDOOg0NQXco/uUREG10n6H7kQ6zngLdzVBHg==
X-Received: by 2002:a05:622a:44f:b0:3b8:340b:1aab with SMTP id o15-20020a05622a044f00b003b8340b1aabmr1820256qtx.25.1678909477913;
        Wed, 15 Mar 2023 12:44:37 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH 9/9] rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
Date:   Wed, 15 Mar 2023 19:43:49 +0000
Message-Id: <20230315194349.10798-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
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
2.40.0.rc1.284.g88254d51c5-goog

