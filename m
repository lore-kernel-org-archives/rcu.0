Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9BC35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577524650
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581723565;
	bh=Xp78FGzNqHuEO65RxH11Myi+um4691vIjCePxsT4fL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TlmLHlS6kw5ODJ0EpwiXRr4vZZ2TfjEGoY7jrd9ZMhgDTrfBkHpuuNbhTtmwWF0cs
	 v7iQWe8yk96kEIQcOiYw65hIOfApC4sOz4eMkZxWI+AK7xqlk7Qwe2JwTeNi0HBWLy
	 MwRBBwIVlyPqVrJ9wL33DzSDvFlSfTJZey14qewY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgBNXjX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgBNXjX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:23 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416842465D;
        Fri, 14 Feb 2020 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723562;
        bh=Xp78FGzNqHuEO65RxH11Myi+um4691vIjCePxsT4fL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/dn2nGYNI4BjQ5yakLl8EhElCMCEX9iUSv9lB4rMBeJv2xcvk9YzokEOyjgJqywB
         fVjLRrxx93LsARAJnaB4MfCqizPsRiRlGhoKOH6vbRsBW6p5ROEAbLuRglUZMQFKa4
         ZX8x5/QK2XNATKO825VUXBnxkcXPNs8NWQCA5c14=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/9] doc/RCU/listRCU: Update example function name
Date:   Fri, 14 Feb 2020 15:38:58 -0800
Message-Id: <20200214233903.12916-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

listRCU.rst document gives an example with 'ipc_lock()', but the
function has dropped off by commit 82061c57ce93 ("ipc: drop
ipc_lock()").  Because the main logic of 'ipc_lock()' has melded in
'shm_lock()' by the commit, this commit updates the document to use
'shm_lock()' instead.

Reviewed-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/listRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index e768f56..2a643e2 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -286,11 +286,11 @@ time the external state changes before Linux becomes aware of the change,
 additional RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
-One example in the Linux kernel is the System V IPC (see the ipc_lock()
-function in ipc/util.c).  This code checks a *deleted* flag under a
+One example in the Linux kernel is the System V IPC (see the shm_lock()
+function in ipc/shm.c).  This code checks a *deleted* flag under a
 per-entry spinlock, and, if the *deleted* flag is set, pretends that the
 entry does not exist.  For this to be helpful, the search function must
-return holding the per-entry lock, as ipc_lock() does in fact do.
+return holding the per-entry spinlock, as shm_lock() does in fact do.
 
 .. _quick_quiz:
 
-- 
2.9.5

