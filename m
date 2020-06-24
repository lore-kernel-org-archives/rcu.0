Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3718C433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEC62100A
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029551;
	bh=+Ml9K6OhgREHxq/Lrb5RMnmhVEQ5vipDFbL6KJkj7LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pM2c28Y216SrFT6cSe+TsDAOkZvjwd2CpmXcF/GtE/sCCH7DuFkfLrL6fwNC/pOaL
	 X3ti9fiuN2x98rNIWJlLM6V9F0wi30SZrM0JRDCDIqYyG/jC7dkpLewVKXXYS3rBiZ
	 mtTNG9IL1mQ/9HN6HbQMtvUg78oQusFaYq3pfIbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406385AbgFXUMa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406370AbgFXUM3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8474120CC7;
        Wed, 24 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029548;
        bh=+Ml9K6OhgREHxq/Lrb5RMnmhVEQ5vipDFbL6KJkj7LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9HkoC7/4m/5Ft1DtFJyQAd73lsyyBDWOnfij9dL2kAcc9hJnZ/z8MI7H5K/yMlkN
         YXGVAUPtfLFTXDeynOwalw9ybOhiPp1MgL9LT3uHXKot7mPoELzxAFW3LrQGq9d4FU
         BUxiRsR4MzT+PBZ/ZpGp7JEMYzpiIFNJEU7VYgDA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
Date:   Wed, 24 Jun 2020 13:12:12 -0700
Message-Id: <20200624201226.21197-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

To keep the kfree_rcu() code working in purely atomic sections on RT,
such as non-threaded IRQ handlers and raw spinlock sections, avoid
calling into the page allocator which uses sleeping locks on RT.

In fact, even if the  caller is preemptible, the kfree_rcu() code is
not, as the krcp->lock is a raw spinlock.

Calling into the page allocator is optional and avoiding it should be
Ok, especially with the page pre-allocation support in future patches.
Such pre-allocation would further avoid the a need for a dynamically
allocated page in the first place.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 64592b4..dbdd509 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3184,6 +3184,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
+			/*
+			 * To keep this path working on raw non-preemptible
+			 * sections, prevent the optional entry into the
+			 * allocator as it uses sleeping locks. In fact, even
+			 * if the caller of kfree_rcu() is preemptible, this
+			 * path still is not, as krcp->lock is a raw spinlock.
+			 * With additional page pre-allocation in the works,
+			 * hitting this return is going to be much less likely.
+			 */
+			if (IS_ENABLED(CONFIG_PREEMPT_RT))
+				return false;
+
 			bnode = (struct kfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
-- 
2.9.5

