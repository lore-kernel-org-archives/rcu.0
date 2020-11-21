Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269FCC5519F
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B8F2408E
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0AI19tN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgKUA7X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgKUA7W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 19:59:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 002C724124;
        Sat, 21 Nov 2020 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605920362;
        bh=eXqmPK7rjzzukwjOur7/+opCjw/4/DHQPRC78zUbrN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0AI19tNxD7P5CgC9A1Fv96ir0vTPRWN4yZl4UKptirErVopkKsgfUFe10dRc3qTm
         3yLAsSlMjLk1zTDpHDMurdHyG6TKEL/1rcNuRsSucoRqtyqBCW/Hk+f0ebZ+2iPTR/
         rfAReJ6x5HBxfh6pjxBjqUN6viYNitoLubCK8kAI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 tip/core/rcu 6/6] srcu: Document polling interfaces for Tree SRCU grace periods
Date:   Fri, 20 Nov 2020 16:59:19 -0800
Message-Id: <20201121005919.17152-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds requirements documentation for the
get_state_synchronize_srcu(), start_poll_synchronize_srcu(), and
poll_state_synchronize_srcu() functions.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1e3df77..2dce79d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2600,6 +2600,24 @@ also includes DEFINE_SRCU(), DEFINE_STATIC_SRCU(), and
 init_srcu_struct() APIs for defining and initializing
 ``srcu_struct`` structures.
 
+More recently, the SRCU API has added polling interfaces:
+
+#. start_poll_synchronize_srcu() returns a cookie identifying
+   the completion of a future SRCU grace period and ensures
+   that this grace period will be started.
+#. poll_state_synchronize_srcu() returns ``true`` iff the
+   specified cookie corresponds to an already-completed
+   SRCU grace period.
+#. get_state_synchronize_srcu() returns a cookie just like
+   start_poll_synchronize_srcu() does, but differs in that
+   it does nothing to ensure that any future SRCU grace period
+   will be started.
+
+These functions are used to avoid unnecessary SRCU grace periods in
+certain types of buffer-cache algorithms having multi-stage age-out
+mechanisms.  The idea is that by the time the block has aged completely
+from the cache, an SRCU grace period will be very likely to have elapsed.
+
 Tasks RCU
 ~~~~~~~~~
 
-- 
2.9.5

