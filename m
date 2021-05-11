Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D823C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0570161625
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEKW7V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKW7U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8678261606;
        Tue, 11 May 2021 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773893;
        bh=tjC0NkFp44jUefELqWmciYgOvqVjRwTPREzS4z26L/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDnApygCdcsAvUUAkeNFO7leNVRZh64Z12a1LBxKX5xI4cDziQhuJu04hkm6CVc7P
         oLW6rdvJTq4X93BhQk0ji2c+7XPxUsgP9Y99xVhPRX6ReyXuLJmISlTLuJcclR2szh
         nkeq6eY8JKr4oVyPgOJ9K940QmjmODQBa2TuwxQ5q+GXkyOwn+7BsRfKu1m7so6iTL
         lXYOcwnHALFjGg8sW2lRVgztmCyXMeWgXugwZNYHpnCiN1LVFYpmusXTOvQJOAcOl9
         IO5k4Xlu91OVYuAUny4H3Ug32rCSMxMOOtgs9vslxpHl2DTpnCNG5uUcPjzkwseIdV
         j81a6SwFBIWGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58DF55C0138; Tue, 11 May 2021 15:58:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vaneet Narang <v.narang@samsung.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/2] mm/slub: Fix backtrace of objects to handle redzone adjustment
Date:   Tue, 11 May 2021 15:58:10 -0700
Message-Id: <20210511225811.2893697-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Maninder Singh <maninder1.s@samsung.com>

This commit fixes commit 8e7f37f2aaa5 ("mm: Add mem_dump_obj() to print
source of memory block").

With current code, the backtrace of allocated object is incorrect:
/ # cat /proc/meminfo
[   14.969843]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at 0x6b6b6b6b
[   14.970635]     0x6b6b6b6b
[   14.970794]     0x6b6b6b6b
[   14.970932]     0x6b6b6b6b
[   14.971077]     0x6b6b6b6b
[   14.971202]     0x6b6b6b6b
[   14.971317]     0x6b6b6b6b
[   14.971423]     0x6b6b6b6b
[   14.971635]     0x6b6b6b6b
[   14.971740]     0x6b6b6b6b
[   14.971871]     0x6b6b6b6b
[   14.972229]     0x6b6b6b6b
[   14.972363]     0x6b6b6b6b
[   14.972505]     0xa56b6b6b
[   14.972631]     0xbbbbbbbb
[   14.972734]     0xc8ab0400
[   14.972891]     meminfo_proc_show+0x40/0x4fc

The reason is that the object address was not adjusted for the red zone.
With this fix, the backtrace is correct:
/ # cat /proc/meminfo
[   14.870782]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 128 size 64 allocated at meminfo_proc_show+0x40/0x4f4
[   14.871817]     meminfo_proc_show+0x40/0x4f4
[   14.872035]     seq_read_iter+0x18c/0x4c4
[   14.872229]     proc_reg_read_iter+0x84/0xac
[   14.872433]     generic_file_splice_read+0xe8/0x17c
[   14.872621]     splice_direct_to_actor+0xb8/0x290
[   14.872747]     do_splice_direct+0xa0/0xe0
[   14.872896]     do_sendfile+0x2d0/0x438
[   14.873044]     sys_sendfile64+0x12c/0x140
[   14.873229]     ret_fast_syscall+0x0/0x58
[   14.873372]     0xbe861de4

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index feda53ae62ba..8f2d13508ec9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4002,6 +4002,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	    !(s->flags & SLAB_STORE_USER))
 		return;
 #ifdef CONFIG_SLUB_DEBUG
+	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
 #ifdef CONFIG_STACKTRACE
-- 
2.31.1.189.g2e36527f23

