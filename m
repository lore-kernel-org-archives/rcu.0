Return-Path: <SRS0=7Ubr=X4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC1C4360C
	for <rcu@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8376222C2
	for <rcu@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066992;
	bh=8ZyFUmDNuP7YABnB8UvoPnBETWg/O9MNocg7cJfuRNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kv+EsmC7V1dYPu1V5JjAe0eHxW8oZBM1z73w4Nbk1ziU3sbSiCvF2XxcF6+Ezqoz4
	 utBMUjIGLTqRaHeLpJgI71G4mVu+SP3A5nR+UjbrtM5wNAF21FwPKkLXNMa49AQk8z
	 RCLG/Q8FmLVXlGdft//gmCwgJBLKR0Nt2HBsTovc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfJCBnM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCBnM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFA9222BE;
        Thu,  3 Oct 2019 01:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066992;
        bh=8ZyFUmDNuP7YABnB8UvoPnBETWg/O9MNocg7cJfuRNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNGveLuefBEOXKRlAldGI1HhLt9gVfQ/CIGR4V/4ARVom8+NkV50Luvws4dhcIcme
         LB7zGCTf+Ewy57A6m4N8DqyLSjpb3z8K+GUszhS6jJiln3B6uKit9Hwg1XanBaRv0R
         TY2k7hY2PSITbK53obreSvs10PAR0UnJDqGphFAI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to rcu_replace()
Date:   Wed,  2 Oct 2019 18:43:02 -0700
Message-Id: <20191003014310.13262-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the rcu_swap_protected() macro follows the example of swap(),
the interactions with RCU make its update of its argument somewhat
counter-intuitive.  This commit therefore introduces an rcu_replace()
that returns the old value of the RCU pointer instead of doing the
argument update.  Once all the uses of rcu_swap_protected() are updated
to instead use rcu_replace(), rcu_swap_protected() will be removed.

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Shane M Seymour <shane.seymour@hpe.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/rcupdate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75a2ede..3b73287 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -383,6 +383,24 @@ do {									      \
 } while (0)
 
 /**
+ * rcu_replace() - replace an RCU pointer, returning its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ * @c: the lockdep conditions under which the dereference will take place
+ *
+ * Perform a replacement, where @rcu_ptr is an RCU-annotated
+ * pointer and @c is the lockdep argument that is passed to the
+ * rcu_dereference_protected() call used to read that pointer.  The old
+ * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
+ */
+#define rcu_replace(rcu_ptr, ptr, c)					\
+({									\
+	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
+	rcu_assign_pointer((rcu_ptr), (ptr));				\
+	__tmp;								\
+})
+
+/**
  * rcu_swap_protected() - swap an RCU and a regular pointer
  * @rcu_ptr: RCU pointer
  * @ptr: regular pointer
-- 
2.9.5

