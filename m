Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C60C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7502E20780
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871787;
	bh=iCKOvbCRfqkVczFsIKppK3kQNn2OlK2C2edwVd11wls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JHqxfn77YY4FrpM9wWLwDM8Rgxl/U80qqhNzmqv2dZbJR3iTOR9IdI6ZJbjue9vWk
	 EKBuEFUP1Wxkvgz1pYVAMlxgahHX7IbIlCN37k1/BQTXiFUxkZu59Ord1//c1SjABK
	 t+vE3x4elwHKTHdcZQ1oYRQT5hsoweOpCMVRG0/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgFWAXD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbgFWAVw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DEC20809;
        Tue, 23 Jun 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=iCKOvbCRfqkVczFsIKppK3kQNn2OlK2C2edwVd11wls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvTK9Bf9uANAh8kx4Yr3cThD+XvHhN/0pYIXS4WbTn+/tQwioQ9QGt3uYYBhuAM1T
         CdIFEcYSQQjoTuyRgCgA1NA8H9k3KvDhaBTfpaKrlWUyj+dbg9YbwjWOLvW2ht9+W7
         KRHMQh3tflCZPfTQCTJuGCn3feKVV6T5zSFWMU88=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/26] fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls
Date:   Mon, 22 Jun 2020 17:21:32 -0700
Message-Id: <20200623002147.25750-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Very large I/Os can cause the following RCU CPU stall warning:

RIP: 0010:rb_prev+0x8/0x50
Code: 49 89 c0 49 89 d1 48 89 c2 48 89 f8 e9 e5 fd ff ff 4c 89 48 10 c3 4c =
89 06 c3 4c 89 40 10 c3 0f 1f 00 48 8b 0f 48 39 cf 74 38 <48> 8b 47 10 48 85 c0 74 22 48 8b 50 08 48 85 d2 74 0c 48 89 d0 48
RSP: 0018:ffffc9002212bab0 EFLAGS: 00000287 ORIG_RAX: ffffffffffffff13
RAX: ffff888821f93630 RBX: ffff888821f93630 RCX: ffff888821f937e0
RDX: 0000000000000000 RSI: 0000000000102000 RDI: ffff888821f93630
RBP: 0000000000103000 R08: 000000000006c000 R09: 0000000000000238
R10: 0000000000102fff R11: ffffc9002212bac8 R12: 0000000000000001
R13: ffffffffffffffff R14: 0000000000102000 R15: ffff888821f937e0
 __lookup_extent_mapping+0xa0/0x110
 try_release_extent_mapping+0xdc/0x220
 btrfs_releasepage+0x45/0x70
 shrink_page_list+0xa39/0xb30
 shrink_inactive_list+0x18f/0x3b0
 shrink_lruvec+0x38e/0x6b0
 shrink_node+0x14d/0x690
 do_try_to_free_pages+0xc6/0x3e0
 try_to_free_mem_cgroup_pages+0xe6/0x1e0
 reclaim_high.constprop.73+0x87/0xc0
 mem_cgroup_handle_over_high+0x66/0x150
 exit_to_usermode_loop+0x82/0xd0
 do_syscall_64+0xd4/0x100
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

On a PREEMPT=n kernel, the try_release_extent_mapping() function's
"while" loop might run for a very long time on a large I/O.  This commit
therefore adds a cond_resched() to this loop, providing RCU any needed
quiescent states.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 68c9605..7042395 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4515,6 +4515,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 
 			/* once for us */
 			free_extent_map(em);
+
+			cond_resched(); /* Allow large-extent preemption. */
 		}
 	}
 	return try_release_extent_state(tree, page, mask);
-- 
2.9.5

