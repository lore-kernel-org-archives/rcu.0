Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221D12B82;
	Mon, 22 Jul 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619525; cv=none; b=t0cmCwMv5KK4a5lALrSs1umebyZ7BXbPcxsaWtQkzZgWPot2lFufzqctji7OLpojNXisKe7/Ev4vp+LBWaPxqtFvqESF4vdHucMlWejrNwJU4vl5hg4Cqb3feHPjpBspUEPUycMY/M5s7s6X4U472C5+K+MUr7zCqDFeGZAqWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619525; c=relaxed/simple;
	bh=jmBrvLyT5FQGwPMay5GKRZcXRSnS2uGJZHm2lgGEnts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lagJTA+YZC+bXsPfWGCMmm0xO5BpKzSuloS18aW4U++h9IPnZyVH+ncrfelPVNzaSg080EagPFNkqqNF5Mh5VuwTCnDlonOftxM10OMvAc4vjinvn4ZZGmAWkCLoEEVEhEdA6/pwjIzalxmCEJOHy09+AfMvFFvfVBJIoaPjyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVye040D; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVye040D"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3daf0e73a62so576024b6e.0;
        Sun, 21 Jul 2024 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721619523; x=1722224323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8VmTf+NUMX3D9wq/MwZrjaWEUh0QWnJq6TwWWhjaVc=;
        b=LVye040DvRAv6N3yl1lws0DA9nYVItjwSmgE9ImODTcGjGttCUbW5inn+o5sEMXwsw
         fdklRFVXpkOZIs8MT3KekeZoSOwx+xi93402q5RxSRB7ChpYBsQg6Bem9rZGk/g8HLpm
         l7bp2OeGj4vTd09i5aLVtGl1oEsHCaOENoiHAPJEVLszpfVAVLc9iPuEAcPprACHncqR
         0f5O256DxgMbjcp+g2d+gh/SayAaaleF1kk7Ee6w9P/Gt769A6/4Zt5iel6yN8n0VqgK
         qb+Lg9XY1SQSi/HKIur2YD79Zsy++abgjL+Cv6zATAQcn0oa5ahlPkZcan6Z66zx0itW
         sGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721619523; x=1722224323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8VmTf+NUMX3D9wq/MwZrjaWEUh0QWnJq6TwWWhjaVc=;
        b=H1Vr1nmpe9mYUfzPUo4E0xrr2UTnDzhRBD9Bpq0faseGO4K+ky/zQr6sWJaT4ipoHS
         tMvD+YGpOc6b+FPmf+oKcMgmJp2QZbMkxftm6O/l7CYEVI+4A+pAm5Uy7kkO6eerxAZc
         qwi6MWmpHiqp32uFBb1HsGzsfAiBTPrjqrjZKv3+4kplZZ03iBtBIuu4h4lW46360qix
         gzIjmLwDwNtp2g0DkqTfqP9yPsDPPcQy4MWd0vSEskQTApnJBE3PGl6KQb5/0eBeBIOO
         L39sQGhIBX/In4KTyoM2cVNeOFg3KHeRkws58AgpUibUfKIqQv8tdIamV1UOI+1nfQxa
         Jy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoqu2C4RfjmNIcw7LGrHDLQGwnnu/oK5J7sZIeTEicigeRFsszDPSDp3qMLENRWGqF4KsN7zYWPlLkTQNn8QVdhVllqDCc7JvnMs2JW4ROtRWkXmJe35BaOx+QCfNLTYIk
X-Gm-Message-State: AOJu0YxrNaQCIEVCifPJdp8fmCZphZ5kWUzGCuoKdQM/ZDVoHXEMaXBV
	hQq1uUFaOLUcfn5IeYq5c+2wGzGaQbrq62Nt0WWHBu+VabSGth6Wkxn88PaBTCwVfmVZ+TpGCIv
	eTsEWDWosP61eGG7zN4/Om4OOIIsg79vB
X-Google-Smtp-Source: AGHT+IH2HjNQOPL7p+WK41uWB3W6f4U3NKxeNUestIs5cuc+ctJnBdjJuioEJbuq/aZ/anwuIZjicjdf34KCB7KpSAQ=
X-Received: by 2002:a05:6808:199e:b0:3d9:3a2f:959e with SMTP id
 5614622812f47-3dae964e390mr6248408b6e.0.1721619522969; Sun, 21 Jul 2024
 20:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d0e3b5061dc16993@google.com> <2897a6bd-6c7d-4b9b-8891-27051df45f8e@paulmck-laptop>
In-Reply-To: <2897a6bd-6c7d-4b9b-8891-27051df45f8e@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 22 Jul 2024 11:38:31 +0800
Message-ID: <CALm+0cWP3=HJfdbQcRNf-StdfFEJw66HSX4i8a+fTek3zR=ORA@mail.gmail.com>
Subject: Re: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
To: paulmck@kernel.org
Cc: syzbot <syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com>, 
	boqun.feng@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com, 
	joel@joelfernandes.org, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org, 
	rcu@vger.kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Jul 21, 2024 at 05:53:21AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=150e825e980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=28bac69fa31fbb3a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
> > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4bf4e980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-51835949.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7a3a01db5542/vmlinux-51835949.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/14d329019155/Image-51835949.gz.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > Voluntary context switch within RCU read-side critical section!
> > WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
>
> Taking a voluntary context switch in an RCU read-side critical section
> voids your RCU warranty.
>
> > Modules linked in:
> > CPU: 0 PID: 3460 Comm: syz-executor248 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > pc : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > lr : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > sp : ffff800089523d30
> > x29: ffff800089523d30 x28: f6f0000005d4a480 x27: 0000000000000000
> > x26: 0000000000000000 x25: f6f0000005d4a480 x24: ffff800082643318
> > x23: 0000000000000000 x22: f6f0000005d4a480 x21: fff000007f8d6240
> > x20: ffff80008261e040 x19: fff000007f8d7040 x18: fffffffffffcb658
> > x17: fff07ffffd2b9000 x16: ffff800080000000 x15: 0000000000000048
> > x14: fffffffffffcb6a0 x13: ffff80008266b0a8 x12: 000000000000088b
> > x11: 00000000000002d9 x10: ffff80008271f500 x9 : ffff80008266b0a8
> > x8 : 00000000ffffdfff x7 : ffff80008271b0a8 x6 : 00000000000002d9
> > x5 : fff000007f8cbf48 x4 : 40000000ffffe2d9 x3 : fff07ffffd2b9000
> > x2 : 0000000000000000 x1 : 0000000000000000 x0 : f6f0000005d4a480
> > Call trace:
> >  rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> >  __schedule+0xb0/0x850 kernel/sched/core.c:6417
> >  __schedule_loop kernel/sched/core.c:6606 [inline]
> >  schedule+0x34/0x104 kernel/sched/core.c:6621
> >  do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
> >  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
> >  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
> >  el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
> >  __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
> >  el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
> >  el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599
> > ---[ end trace 0000000000000000 ]---
>
> If we are exiting to user mode, my first guess would be that someone
> did rcu_read_lock() but forgot the matching rcu_read_unlock().
>
> Can this be reproduced using lockdep?  That would pinpoint the unmatched
> rcu_read_lock().
>

This should be caused by this modification  (commit id:
ca567df74a28a9fb368c6b2d93e864113f73f5c2)
when tsk is null, miss invoke rcu_read_unlock() for NS_GET_TGID_IN_PIDNS.

Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
