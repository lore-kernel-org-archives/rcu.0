Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5ED2629F;
	Sun, 21 Jul 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579861; cv=none; b=HrA8jXY8OTCXcofAKcgUZq6TNZMVHEb3nJ3FK2lSE/WU5GvyTjb4gnHs6rV2YPxGnxLfKN3zO3CJJQIrv62yn3fRil4hghDJFK4Tuu9bDi622sET2TmydmssOggg4oASFYrda7RQ0AbOa/a69HGUyBT+UBqvtyrNtpMMNwtWhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579861; c=relaxed/simple;
	bh=GKoQlBZa2RM6KnHvn3eBwGCTYlBbEzmABMqe/dEdJuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT33UPL52gmbxRiP0/GlB6F8FPttPI206Pe+/HClInrpfeLWsNsYXucOo7c/lOyx1B8neEdVm3Lzu1JI7ELkqr/F17ameaTGiIJsdqvh6bOsaryAhljB76f59ESTvkAxdGLzR+MeiJC0ASoJnnc716hXbSIJFwiyKK7PfDinpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaZKRsQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaZKRsQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9E6C116B1;
	Sun, 21 Jul 2024 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721579860;
	bh=GKoQlBZa2RM6KnHvn3eBwGCTYlBbEzmABMqe/dEdJuE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QaZKRsQ2z3N9sXzZNo8ilzM4clpVd6KW/XC6DKTo+0k2B3v3JMS146FMv/W30d/wE
	 WagYw/aEDQCUctKeKkd+g89q2kuX8nGVaZ47wT8cCueJJv/chPbBqoH5nXNWzeLE0u
	 BBTkUuoEMaH1jFpF8ZTJCF+a12RJ/6oZn96R9xayq/EGDuw8XFB2hM2AP1T2H+GC7Q
	 F42ib2RvTTGv0UmlrAcw4w1G8RXPbEvN8/PFqNmfn6EWh9uU9NWjTtU50MMpu1FmbN
	 NtoYToeii4pL13HoTtNDAr4z2XD7uoUHxcoNri84jvsnIUjNRqOFwgB7XLM2pDZISC
	 uS+8N/oOcPQww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69A40CE09D8; Sun, 21 Jul 2024 09:37:40 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:37:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: syzbot <syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com, urezki@gmail.com
Subject: Re: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
Message-ID: <2897a6bd-6c7d-4b9b-8891-27051df45f8e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <000000000000d0e3b5061dc16993@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d0e3b5061dc16993@google.com>

On Sun, Jul 21, 2024 at 05:53:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=150e825e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28bac69fa31fbb3a
> dashboard link: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4bf4e980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-51835949.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7a3a01db5542/vmlinux-51835949.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/14d329019155/Image-51835949.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> Voluntary context switch within RCU read-side critical section!
> WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330

Taking a voluntary context switch in an RCU read-side critical section
voids your RCU warranty.

> Modules linked in:
> CPU: 0 PID: 3460 Comm: syz-executor248 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> lr : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> sp : ffff800089523d30
> x29: ffff800089523d30 x28: f6f0000005d4a480 x27: 0000000000000000
> x26: 0000000000000000 x25: f6f0000005d4a480 x24: ffff800082643318
> x23: 0000000000000000 x22: f6f0000005d4a480 x21: fff000007f8d6240
> x20: ffff80008261e040 x19: fff000007f8d7040 x18: fffffffffffcb658
> x17: fff07ffffd2b9000 x16: ffff800080000000 x15: 0000000000000048
> x14: fffffffffffcb6a0 x13: ffff80008266b0a8 x12: 000000000000088b
> x11: 00000000000002d9 x10: ffff80008271f500 x9 : ffff80008266b0a8
> x8 : 00000000ffffdfff x7 : ffff80008271b0a8 x6 : 00000000000002d9
> x5 : fff000007f8cbf48 x4 : 40000000ffffe2d9 x3 : fff07ffffd2b9000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f6f0000005d4a480
> Call trace:
>  rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
>  __schedule+0xb0/0x850 kernel/sched/core.c:6417
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x34/0x104 kernel/sched/core.c:6621
>  do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
>  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
>  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
>  el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
>  __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
>  el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
>  el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599
> ---[ end trace 0000000000000000 ]---

If we are exiting to user mode, my first guess would be that someone
did rcu_read_lock() but forgot the matching rcu_read_unlock().

Can this be reproduced using lockdep?  That would pinpoint the unmatched
rcu_read_lock().

							Thanx, Paul

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
