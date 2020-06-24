Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA35C433E1
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C73820823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029599;
	bh=N43J/nnraBD2R1e0Ivz38wMpe/rKq/bCku2ZrgM/PCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/X25V2V7hy1Ae3bxKgo0SZ2IcoO7Ge/2cFwr96EoszS1TlPrK/Z6uGkXATzBy00T
	 iDd2rWDvuatleTBTt4KLbfVRxm16MzXNtnW7MVL4/2JCuZA5eUKtw2Oas697YGIwjG
	 xHosYBElsZVz9Bc7Jn+LSp6vY228ST+Xmpgy4BrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406500AbgFXUNS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406389AbgFXUMa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A16D21532;
        Wed, 24 Jun 2020 20:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029550;
        bh=N43J/nnraBD2R1e0Ivz38wMpe/rKq/bCku2ZrgM/PCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQkWCKdPJQo9qXLS8QRTuYc9uWS8x9/jk6ITFhrFNEKJmrS9SUEQ3ytHgWPXlLLHo
         MQvliis1Tc8DugsM7eqM9mW51QVl6ezbSa5/egBzLO9Z9WMZXCJtdvZMqWIjiDN+v2
         Nw3DyDwsx4aVYcVHdf94vcxn8V14c2FHxPoIZmMA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/17] rcu/tiny: support vmalloc in tiny-RCU
Date:   Wed, 24 Jun 2020 13:12:20 -0700
Message-Id: <20200624201226.21197-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Replace kfree() with kvfree() in rcu_reclaim_tiny().
This makes it possible to release either SLAB or vmalloc
objects after a GP.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tiny.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dd572ce..4b99f7b8 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/prefetch.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 
 #include "rcu.h"
 
@@ -86,7 +87,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kfree_callback("", head, offset);
-		kfree((void *)head - offset);
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	}
-- 
2.9.5

