Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29ECECAAD3
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 05:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIOF6t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIOF6s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 01:58:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1E90199
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so16398133pgc.0
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eGzhxNHfxgZG+HUCB9A/U66lF7BlvYesE74FyPkk6Rk=;
        b=oSfzNplE9jROtQE+W9Ioy6jG8Dwhn360g1wue0YJiinyz2YwoJfySMbkF16p4x/9kD
         A7lkEeVmW/YMX2OOaptC8zjVMI2kzmLsJ7F5oje5pTP6pafkD0cYBrcKTCnkCw0z1pvH
         jmuNHIfl6rWRVWPNMt1X7PJ8fOdQiRP8JF5/LmOScd4rMgavDVA9KWJdGuFyFAXWGjhi
         4UZd43xAH2P3aUCPs5AjDYCfp9XOalDxO0qUXBqcoSCi1gkPGWQuXC2gQMb1D1NPnlLs
         lyBr1PNPJpOhcZTDJDM+qkYoqqwuBTkH8QFKOUR5qXUlO6KzlthNIYmbkzqT8uJPjJa9
         dP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eGzhxNHfxgZG+HUCB9A/U66lF7BlvYesE74FyPkk6Rk=;
        b=nObcw9GjUJc3IItJ1/g2TtHBJWD1WHoE4O5HvAPBJeRBdQ6mXHcmEc2uJzVHJtZsSO
         i2iccHNQfWn2+YebjoPesFpbcwnto4qQEKVVYl8adp+bYc5DMyW2sYlSq4X222AmG4su
         8I5ZDiOZxAUyfFhLwar4ur02e2MPD6cP7hT3aoMiJ9BkkGChiiEiLWOp0+78pYo9d9iJ
         FWp+QUDwYM0RndwMHXh1c/fRcJfKPG5vsLORTtfklNESS0xFpTKKrP1a1/bZyoWIFxAL
         1YeNlXrL+zimq9bRkyRk44pOot/FmrY7/UJRQXgfHT0GVWC5eM6Fap1dY7FjvNBs1Vky
         LwIg==
X-Gm-Message-State: ACgBeo1m4CsC1Rg4ElVU774fPim3JBVLRGx29ecsMN00uvB/unhggP1V
        dOqyjBqQRqaKzqdBL7CurcinvWZ0fA==
X-Google-Smtp-Source: AA6agR6mMUMxMV4NGkonr8rqsuGBesgWg1Qgt/WxSY83l1NQgUl41SQor7YgQEspCIdqBVr8nHx9Gw==
X-Received: by 2002:a05:6a00:1943:b0:53a:8602:6758 with SMTP id s3-20020a056a00194300b0053a86026758mr40803724pfk.47.1663221526719;
        Wed, 14 Sep 2022 22:58:46 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001768452d4d7sm11983386plg.14.2022.09.14.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 22:58:46 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when rcutree_online_cpu()
Date:   Thu, 15 Sep 2022 13:58:23 +0800
Message-Id: <20220915055825.21525-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220915055825.21525-1-kernelfans@gmail.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcutree_online_cpu() is concurrent, so there is the following race
scene:

        CPU 1                               CPU2
mask_old = rcu_rnp_online_cpus(rnp);
...

                                   mask_new = rcu_rnp_online_cpus(rnp);
                                   ...
                                   set_cpus_allowed_ptr(t, cm);

set_cpus_allowed_ptr(t, cm);

Consequently, the old mask will overwrite the new mask in the task's cpus_ptr.

Since there is a mutex ->boost_kthread_mutex, using it to build an
order, then the latest ->qsmaskinitnext will be fetched for updating cpus_ptr.

But for concurrent offlining, ->qsmaskinitnext is not reilable when
rcutree_offline_cpu(). That is another story and comes in the following
patch.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/tree_plugin.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 438ecae6bd7e..ef6d3ae239b9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 	struct task_struct *t = rnp->boost_kthread_task;
-	unsigned long mask = rcu_rnp_online_cpus(rnp);
+	unsigned long mask;
 	cpumask_var_t cm;
 	int cpu;
 
@@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
 	mutex_lock(&rnp->boost_kthread_mutex);
+	/*
+	 * Relying on the lock to serialize, so when onlining, the latest
+	 * qsmaskinitnext is for cpus_ptr.
+	 */
+	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
-- 
2.31.1

