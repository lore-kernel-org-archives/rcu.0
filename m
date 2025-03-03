Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9152E401;
	Mon,  3 Mar 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740963057; cv=none; b=dUF02zpJMU9QIupdvIH4t/0Ssy5J+iT9NSNVPE4Y54CSuuZVRlq/GpZkEAXM9PTSGMrpB3d7A3ECcakGKegQGFvtWDK7Xmc4x8F97GWOdfIf2zwD+cZqCECmKk+g5jfFyjEFiMSd4+IXZXkRJ4AKBdiNYkSUvL9HKUDgyO8N+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740963057; c=relaxed/simple;
	bh=b3wTXScjD5iISbY67J9jQbKQ99GOi5v18IdZgphe12U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtmucsUdbfWb1WqJ075OVP09VIgVFHGU7hhbI0tbZBaMZT0GF1nIQf1lFyOmROSTz+0YHU1JXxq9ZO7znRwR4RWislHvLswWzdNYogRs9/7kGej37AWEqUXqwY4ZstH3NzWt7yOJAS5nqqQemCz3+166ELGQI4Mqf07dDJECf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Fq4bkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Fq4bkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE092C4CED6;
	Mon,  3 Mar 2025 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740963057;
	bh=b3wTXScjD5iISbY67J9jQbKQ99GOi5v18IdZgphe12U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=M4Fq4bkxRUOqYtDCLxgUYlWV0lZ7tP+zXHzcrRQ+hp5UA0MPMnlEuNaSrU7ybNKvf
	 5F+Iiq5Z45f0AoBvq1gqJDyLhA+zolMGzCrw6VtoJEo0+Tl0SiJ5tBnQDqAtTzvkxB
	 HRs1gnxd8eeEc8D5pBF7iOvb2OCrZhhJYpYU4M2Cs7EwgiwGirDHmCqmcQ3sHLSuCb
	 +yBJWzMCQDtdi0IRErtV1uq6HpxAMiOJDZTaRvv4mhnM90oBcT/Ilex51lGCFBlz8w
	 wAlWLhv2SmtQOgG+wN14ud88M2QEMHFKDkp0w+zgdyi/Su6Vq0SSTErEBVx6WAiPXN
	 n6Csgr1Md570A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E7EBCE04E4; Sun,  2 Mar 2025 16:50:56 -0800 (PST)
Date: Sun, 2 Mar 2025 16:50:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Strforexc yn <strforexc@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: global-out-of-bounds Read in srcu_gp_start_if_needed
Message-ID: <13691946-f330-4a5c-baf7-3125ec97939b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HokZrPb-oHcuZQsc=LZ6_aJfjKy9oMeCBd-tq4b_sX5EG7NQ@mail.gmail.com>

On Mon, Mar 03, 2025 at 08:44:48AM +0800, Strforexc yn wrote:
> Dear Maintainers, When using our customized Syzkaller to fuzz the
> latest Linux kernel, the following crash was triggered.
> 
> Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
> Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
> Kernel Log: attachment
> 
> I’ve encountered a KASAN-reported global-out-of-bounds read in Linux
> kernel 6.14.0-rc4, involving the RCU subsystem and bcachefs. Here are
> the details:
> 
> A global-out-of-bounds read of size 1 was detected at address
> ffffffff8b8e8d55 in string_nocheck (lib/vsprintf.c:632), called from
> string (lib/vsprintf.c:714). The buggy address belongs to
> str__rcu__trace_system_name+0x815/0xb40, triggered by a kworker task.
> 
> The issue occurs during a bcachefs transaction commit
> (bch2_trans_commit), which enqueues an RCU callback via
> srcu_gp_start_if_needed. The out-of-bounds access happens in
> string_nocheck, likely during a printk or tracepoint operation
> (vprintk_emit), triggered by a lockdep warning (__warn_printk). The
> variable str__rcu__trace_system_name (size 0xb40) is overrun at offset
> 0x815, suggesting a string handling bug in RCU or bcachefs debug
> output.
> 
> The bug was observed in a QEMU environment during
> btree_interior_update_work execution in bcachefs. It may involve
> filesystem operations (e.g., key cache dropping) under load. I don’t
> have a precise reproducer yet but can assist with testing.
> 
> Could RCU or bcachefs maintainers investigate? This might be a
> tracepoint or printk format string issue in srcu_gp_start_if_needed or
> related code. I suspect an invalid index into
> str__rcu__trace_system_name or a pointer corruption. Happy to provide
> more logs or test patches.

If this is reproduceable, building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
has a decent chance of providing useful diagnostics.

							Thanx, Paul

> If you fix this issue, please add the following tag to the commit:
> Reported-by: Zhizhuo Tang <strforexctzzchange@foxmail.com>, Jianzhou
> Zhao <xnxc22xnxc22@qq.com>, Haoran Liu <cherest_san@163.com>
> ------------[ cut here ]------------
> ==================================================================
> BUG: KASAN: global-out-of-bounds in string_nocheck lib/vsprintf.c:632 [inline]
> BUG: KASAN: global-out-of-bounds in string+0x4b3/0x500 lib/vsprintf.c:714
> Read of size 1 at addr ffffffff8b8e8d55 by task kworker/u10:0/28
> 
> CPU: 1 UID: 0 PID: 28 Comm: kworker/u10:0 Not tainted 6.14.0-rc4 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: btree_update btree_interior_update_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
>  print_report+0xaa/0x270 mm/kasan/report.c:521
>  kasan_report+0xbd/0x100 mm/kasan/report.c:634
>  string_nocheck lib/vsprintf.c:632 [inline]
>  string+0x4b3/0x500 lib/vsprintf.c:714
>  vsnprintf+0x620/0x1120 lib/vsprintf.c:2843
>  vprintk_store+0x34f/0xb90 kernel/printk/printk.c:2279
>  vprintk_emit+0x151/0x330 kernel/printk/printk.c:2408
>  __warn_printk+0x162/0x320 kernel/panic.c:797
>  look_up_lock_class+0xad/0x160 kernel/locking/lockdep.c:938
>  register_lock_class+0xb2/0xfc0 kernel/locking/lockdep.c:1292
>  __lock_acquire+0xc3/0x16a0 kernel/locking/lockdep.c:5103
>  lock_acquire+0x181/0x3a0 kernel/locking/lockdep.c:5851
>  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
>  _raw_spin_trylock+0x76/0xa0 kernel/locking/spinlock.c:138
>  spin_lock_irqsave_sdp_contention kernel/rcu/srcutree.c:375 [inline]
>  srcu_gp_start_if_needed+0x1a9/0x5f0 kernel/rcu/srcutree.c:1270
>  __call_rcu fs/bcachefs/rcu_pending.c:76 [inline]
>  __rcu_pending_enqueue fs/bcachefs/rcu_pending.c:497 [inline]
>  rcu_pending_enqueue+0x686/0xd30 fs/bcachefs/rcu_pending.c:531
>  bkey_cached_free+0xfd/0x170 fs/bcachefs/btree_key_cache.c:115
>  bch2_btree_key_cache_drop+0xe7/0x770 fs/bcachefs/btree_key_cache.c:613
>  bch2_trans_commit_write_locked.constprop.0+0x2bc6/0x3bc0
> fs/bcachefs/btree_trans_commit.c:794
>  do_bch2_trans_commit.isra.0+0x7a6/0x12f0 fs/bcachefs/btree_trans_commit.c:866
>  __bch2_trans_commit+0x1018/0x18e0 fs/bcachefs/btree_trans_commit.c:1070
>  bch2_trans_commit fs/bcachefs/btree_update.h:183 [inline]
>  btree_update_nodes_written+0x1352/0x2210
> fs/bcachefs/btree_update_interior.c:708
>  btree_interior_update_work+0xda/0x100 fs/bcachefs/btree_update_interior.c:846
>  process_one_work+0x109d/0x18c0 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3317 [inline]
>  worker_thread+0x677/0xe90 kernel/workqueue.c:3398
>  kthread+0x3b3/0x760 kernel/kthread.c:464
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> The buggy address belongs to the variable:
>  str__rcu__trace_system_name+0x815/0xb40
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb8e8
> flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000002000 ffffea00002e3a08 ffffea00002e3a08 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner info is not present (never set?)
> 
> Memory state around the buggy address:
>  ffffffff8b8e8c00: f9 f9 f9 f9 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9
>  ffffffff8b8e8c80: 00 00 00 00 00 00 01 f9 f9 f9 f9 f9 00 00 00 07
> >ffffffff8b8e8d00: f9 f9 f9 f9 00 00 00 03 f9 f9 f9 f9 00 00 00 06
>                                                  ^
>  ffffffff8b8e8d80: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 01 f9
>  ffffffff8b8e8e00: f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9 00 00 00 00
> ==================================================================
> Thanks,
> Zhizhuo Tang


