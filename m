Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B519CC433B4
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85972611B0
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhDNMNC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhDNMNB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:13:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC320C061756;
        Wed, 14 Apr 2021 05:12:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r8so32670575lfp.10;
        Wed, 14 Apr 2021 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fcOwlh1hWcYkPKcp1G6pZ9TYsQSyP841jgIbzs8dR0=;
        b=P2HFnSwnBV8zt6Iet2HAllbgMASac9KeO+xhP7trAzIXtzfEssorWiFMj8IiU0hs9J
         nngEll9YZ2ChBaAmic98HgHkrvDXnYc3Thl+JSLgR2VfdiURJgtA48erJ2lGxMm5GqL/
         jP47SyKK4Q60IWocJyd4NuEqMK6qTcHVcHa8czIHApP9U3oTi3gf7JmyFa/dwVNN0d+i
         trfkT3q8ho98Q4Y651DGZKk4n0IX2TyiH4WwRvxG+SUy6AwKAA7/jGp9RXC32Ou8MtUJ
         vYGZxKgP2Bz+taWOK2cIdhnWP/d+l4g+xK7YWwgRjGETFB8IwoD24eVCBo9Lf5jxwTBN
         T0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fcOwlh1hWcYkPKcp1G6pZ9TYsQSyP841jgIbzs8dR0=;
        b=q5GsKdwV1X5oOc66OlNjBh9CcEK/5szf6/6MC12sLhfq8tEBWp+aPGmZN7uzhNHcr9
         i2KG26fDEPPt02dt/HJwTIFwNur7iNLvzg/78fyvXmPHyFCKc1MKY83hc7pPOlTZ3ue+
         VY2v9+tSJeSt9q4T6ueXNaVMS55C//3qLwgKq2WxcBETtIp+Wi4Q+0W6lfl0mP9pM8KU
         dkn3CnlHLBQrp9SJ3gelUs5AoMjvEOhZ9Mnz3VtUj9sw9uAlzp5pp325CM4q1VxicC2l
         dEJVzAMaR9uP8NR9+vze094e0UXTVO+8EIBvLB2/5Q/7lt4oVkNKlOQ2HxW3C60Aishb
         RJhA==
X-Gm-Message-State: AOAM533KULc8as/gttgfoSmc7dDfB6+UgfBnGvoaPLtboQKTuZvJ5mZu
        V/pv6EJ5QWyO50TYXCan1Kik9JFfTv+ldQ==
X-Google-Smtp-Source: ABdhPJxgmVYZQLdi8sLRdnC4VQhcZxuyKkUCdAWfw7JmdX123gb3+m4wYCqo5rglrxyyiZ965yW+bg==
X-Received: by 2002:ac2:47ee:: with SMTP id b14mr17310494lfp.447.1618402358122;
        Wed, 14 Apr 2021 05:12:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 4/6] kvfree_rcu: add a bulk-list check when a scheduler is run
Date:   Wed, 14 Apr 2021 14:12:24 +0200
Message-Id: <20210414121226.2650-4-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414121226.2650-1-urezki@gmail.com>
References: <20210414121226.2650-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU_SCHEDULER_RUNNING is set when a scheduling is available.
That signal is used in order to check and queue a "monitor work"
to reclaim freed objects(if they are) during a boot-up phase.

We have it because, the main path of the kvfree_rcu() call can
not queue the work untill the scheduler is up and running.

Currently in such helper only "krcp->head" is checked to figure
out if there are outstanding objects to be released. And this is
only one channel. After adding a bulk interface there are two
extra which have to be checked also: "krcp->bkvhead[0]" as well
as "krcp->bkvhead[1]". So, we have to queue the "monitor work"
if _any_ corresponding channel is not empty.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31ee820c3d9e..da3605067cc1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3723,13 +3723,11 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || test_and_set_bit(KRC_MONITOR_TODO, &krcp->flags)) {
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-			continue;
+		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head ||
+				!test_and_set_bit(KRC_MONITOR_TODO, &krcp->flags)) {
+			schedule_delayed_work_on(cpu, &krcp->monitor_work,
+				KFREE_DRAIN_JIFFIES);
 		}
-
-		schedule_delayed_work_on(cpu, &krcp->monitor_work,
-					 KFREE_DRAIN_JIFFIES);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
-- 
2.20.1

