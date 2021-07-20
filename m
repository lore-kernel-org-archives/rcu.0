Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224EAC07E9B
	for <rcu@archiver.kernel.org>; Tue, 20 Jul 2021 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF7660FF3
	for <rcu@archiver.kernel.org>; Tue, 20 Jul 2021 13:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhGTMul (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238353AbhGTMjR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jul 2021 08:39:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C3C06108B;
        Tue, 20 Jul 2021 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626787131;
        bh=fo0JC3teQ2bqD7GaitNugeR+tkf4a62+U1EO4/mcbZ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SK0g5/iIHfFPfSwbCVoQP8uymYhiWhKqN71zDu9zmLSE/sQgBPla7BPlZaANXDv/T
         hWpe8K/Akn8bMe644FXI3fkUUGcKzQW45dWifQ2WuqqIjnaQzVPJHqqQL3Hqmfi8ow
         9jrEPq8cedfjQrJHB/d+bVrmUtk1ckLV5DwekBV53oTobfOWzw4688QUbBRzRJuEBq
         29u6GfU8uWl/ysswkbGj4YnvMur+sldYG0U788CjuDNiUvTfbbTASEluaQu/aHAr9Y
         fd4iGjNScRW67ESiEG0d1adtZqG/MW7RtiRnSRiE22l+6v2P3kKsQK/Gn2raxLN0C0
         s03wlpKAMCftA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35B4A5C094C; Tue, 20 Jul 2021 06:18:51 -0700 (PDT)
Date:   Tue, 20 Jul 2021 06:18:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KCSAN: data-race in call_rcu / rcu_gp_kthread
Message-ID: <20210720131851.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <00000000000080403805c6ef586d@google.com>
 <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPx2b+W2OZxNROTWfGcU92bwqyDe-=vxgnV9MEurjyqzQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 12, 2021 at 06:14:37PM +0200, Marco Elver wrote:
> [-Bcc: fsdevel]
> [+Cc: Paul, rcu@vger.kernel.org]
> 
> On Mon, 12 Jul 2021 at 18:09, syzbot
> <syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e73f0f0e Linux 5.14-rc1
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=172196d2300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e73542d774430b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e08a83a1940ec3846cd5
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in call_rcu / rcu_gp_kthread
> >
> > write to 0xffffffff837328a0 of 8 bytes by task 11 on cpu 0:
> >  rcu_gp_fqs kernel/rcu/tree.c:1949 [inline]
> >  rcu_gp_fqs_loop kernel/rcu/tree.c:2010 [inline]
> >  rcu_gp_kthread+0xd78/0xec0 kernel/rcu/tree.c:2169
> >  kthread+0x262/0x280 kernel/kthread.c:319
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >
> > read to 0xffffffff837328a0 of 8 bytes by task 30193 on cpu 1:
> >  __call_rcu_core kernel/rcu/tree.c:2946 [inline]
> >  __call_rcu kernel/rcu/tree.c:3062 [inline]
> >  call_rcu+0x4b0/0x6c0 kernel/rcu/tree.c:3109
> >  file_free fs/file_table.c:58 [inline]
> >  __fput+0x43e/0x4e0 fs/file_table.c:298
> >  ____fput+0x11/0x20 fs/file_table.c:313
> >  task_work_run+0xae/0x130 kernel/task_work.c:164
> >  get_signal+0x156c/0x15e0 kernel/signal.c:2581
> >  arch_do_signal_or_restart+0x2a/0x220 arch/x86/kernel/signal.c:865
> >  handle_signal_work kernel/entry/common.c:148 [inline]
> >  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
> >  exit_to_user_mode_prepare+0x109/0x190 kernel/entry/common.c:209
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
> >  syscall_exit_to_user_mode+0x20/0x40 kernel/entry/common.c:302
> >  do_syscall_64+0x49/0x90 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > value changed: 0x0000000000000f57 -> 0x0000000000000f58
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 1 PID: 30193 Comm: syz-executor.5 Tainted: G        W         5.14.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Good catch!  And yes, this would be hard to reproduce.

How about as shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 43e0f01f3b6f510dbe31d02a8f4c909c45deff04
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jul 20 06:16:27 2021 -0700

    rcu: Mark accesses to rcu_state.n_force_qs
    
    This commit marks accesses to the rcu_state.n_force_qs.  These data
    races are hard to make happen, but syzkaller was equal to the task.
    
    Reported-by: syzbot+e08a83a1940ec3846cd5@syzkaller.appspotmail.com
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a7379c44a2366..245bca7cdf6ee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1913,7 +1913,7 @@ static void rcu_gp_fqs(bool first_time)
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
-	rcu_state.n_force_qs++;
+	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
@@ -2556,7 +2556,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Reset ->qlen_last_fqs_check trigger if enough CBs have drained. */
 	if (count == 0 && rdp->qlen_last_fqs_check != 0) {
 		rdp->qlen_last_fqs_check = 0;
-		rdp->n_force_qs_snap = rcu_state.n_force_qs;
+		rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	} else if (count < rdp->qlen_last_fqs_check - qhimark)
 		rdp->qlen_last_fqs_check = count;
 
@@ -2904,10 +2904,10 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 		} else {
 			/* Give the grace period a kick. */
 			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
-			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
+			if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
 				rcu_force_quiescent_state();
-			rdp->n_force_qs_snap = rcu_state.n_force_qs;
+			rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 		}
 	}
@@ -4134,7 +4134,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rdp->qlen_last_fqs_check = 0;
-	rdp->n_force_qs_snap = rcu_state.n_force_qs;
+	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
 	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
 	rcu_dynticks_eqs_online();
