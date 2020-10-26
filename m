Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE585C4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B960C20773
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 15:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782947AbgJZPET (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:04:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782284AbgJZPET (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 11:04:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92456AD4A;
        Mon, 26 Oct 2020 15:04:17 +0000 (UTC)
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Alexander Potapenko <glider@google.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [BUG] Lockdep splat during kvfree_call_rcu and stack_depot_save
Reply-To: rpalethorpe@suse.de
Date:   Mon, 26 Oct 2020 15:04:16 +0000
Message-ID: <87a6w9uiz3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,

The kmem memcg selftest causes the following lockdep splat on 5.9+

[   67.534319] =============================
[   67.534410] [ BUG: Invalid wait context ]
[   67.534522] 5.9.1-22-default #125 Not tainted
[   67.534647] -----------------------------
[   67.534732] ksoftirqd/5/36 is trying to lock:
[   67.534833] ffffffffa7802d58 (depot_lock){..-.}-{3:3}, at: stack_depot_save (lib/stackdepot.c:286)
[   67.534993] other info that might help us debug this:
[   67.535089] context-{3:3}
[   67.535139] 3 locks held by ksoftirqd/5/36:
[   67.535216] #0: ffffffffa769d3e0 (rcu_callback){....}-{0:0}, at: rcu_do_batch (./include/linux/rcupdate.h:241 kernel/rcu/tree.c:2425)
[   67.535362] #1: ffffffffa769d4a0 (rcu_read_lock){....}-{1:3}, at: percpu_ref_switch_to_atomic_rcu (./arch/x86/include/asm/preempt.h:79 ./include/linux/rcupdate.h:60 ./include/linux/rcupdate.h:632 ./include/linux/percpu-refcount.h:304 ./include/linux/percpu-refcount.h:325 lib/percpu-refcount.c:131 lib/percpu-refcount.c:166)
[   67.535556] #2: ffff96ca3b55e910 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu (kernel/rcu/tree.c:3301 kernel/rcu/tree.c:3404)
[   67.535709] stack backtrace:
[   67.535780] CPU: 5 PID: 36 Comm: ksoftirqd/5 Not tainted 5.9.1-22-default #125
[   67.535907] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[   67.536108] Call Trace:
[   67.536151] dump_stack (lib/dump_stack.c:120)
[   67.536221] print_lock_invalid_wait_context.cold (kernel/locking/lockdep.c:4093)
[   67.536311] __lock_acquire (kernel/locking/lockdep.c:4391)
[   67.536377] ? validate_chain (kernel/locking/lockdep.c:2603 kernel/locking/lockdep.c:3218)
[   67.536453] lock_acquire (kernel/locking/lockdep.c:398 kernel/locking/lockdep.c:5031)
[   67.536521] ? stack_depot_save (lib/stackdepot.c:286)
[   67.536590] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
[   67.536662] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:117 kernel/locking/spinlock.c:159)
[   67.536873] ? stack_depot_save (lib/stackdepot.c:286)
[   67.537108] stack_depot_save (lib/stackdepot.c:286)
[   67.537284] save_stack (mm/page_owner.c:137)
[   67.537382] ? prep_new_page (./include/linux/page_owner.h:31 mm/page_alloc.c:2220 mm/page_alloc.c:2226)
[   67.537479] ? get_page_from_freelist (mm/page_alloc.c:3851)
[   67.537664] ? __alloc_pages_nodemask (mm/page_alloc.c:4896)
[   67.537843] ? __get_free_pages (mm/page_alloc.c:4940)
[   67.537971] ? kvfree_call_rcu (kernel/rcu/tree.c:3336 kernel/rcu/tree.c:3404)
[   67.538066] ? percpu_ref_switch_to_atomic_rcu (./include/linux/percpu-refcount.h:309 ./include/linux/percpu-refcount.h:325 lib/percpu-refcount.c:131 lib/percpu-refcount.c:166)
[   67.538218] ? rcu_do_batch (./include/linux/rcupdate.h:246 kernel/rcu/tree.c:2432)
[   67.538348] ? rcu_core (kernel/rcu/tree.c:2658)
[   67.538409] ? __do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:299)
[   67.538509] ? run_ksoftirqd (kernel/softirq.c:653 kernel/softirq.c:644)
[   67.538640] ? smpboot_thread_fn (kernel/smpboot.c:165)
[   67.538814] ? kthread (kernel/kthread.c:292)
[   67.539004] ? ret_from_fork (arch/x86/entry/entry_64.S:300)
[   67.539172] __set_page_owner (mm/page_owner.c:169 mm/page_owner.c:192)
[   67.539281] prep_new_page (./include/linux/page_owner.h:31 mm/page_alloc.c:2220 mm/page_alloc.c:2226)
[   67.539445] get_page_from_freelist (mm/page_alloc.c:3851)
[   67.539653] ? kvfree_call_rcu (kernel/rcu/tree.c:3301 kernel/rcu/tree.c:3404)
[   67.539823] __alloc_pages_nodemask (mm/page_alloc.c:4896)
[   67.540020] __get_free_pages (mm/page_alloc.c:4940)
[   67.540171] kvfree_call_rcu (kernel/rcu/tree.c:3336 kernel/rcu/tree.c:3404)
[   67.540324] ? rcu_do_batch (./include/linux/rcupdate.h:241 kernel/rcu/tree.c:2425)
[   67.540524] percpu_ref_switch_to_atomic_rcu (./include/linux/percpu-refcount.h:309 ./include/linux/percpu-refcount.h:325 lib/percpu-refcount.c:131 lib/percpu-refcount.c:166)
[   67.540736] rcu_do_batch (./include/linux/rcupdate.h:246 kernel/rcu/tree.c:2432)
[   67.540941] rcu_core (kernel/rcu/tree.c:2658)
[   67.541169] __do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:299)
[   67.541375] run_ksoftirqd (kernel/softirq.c:653 kernel/softirq.c:644)
[   67.541574] smpboot_thread_fn (kernel/smpboot.c:165)
[   67.541771] ? smpboot_register_percpu_thread (kernel/smpboot.c:108)
[   67.542025] kthread (kernel/kthread.c:292)
[   67.542219] ? kthread_create_worker_on_cpu (kernel/kthread.c:245)

This appears to be caused by
8ac88f7177c7 ("rcu/tree: Keep kfree_rcu() awake during lock contention")

which switched krc.lock from a spinlock to a raw_spinlock. Indeed if I
switch it back to a spinlock again then the splat is no longer
reproducible.

-- 
Thank you,
Richard.
