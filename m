Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47117BAB;
	Mon, 22 Jul 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630544; cv=none; b=seFR/NyQ7+UsAgwmE8h+8tibHDK0eDrjPgiNuolWiZ82F2U14L0MllzMnnmyVRLpGgT4s7RwMaMaCwbVc0tvh1chj3sf9AoOkZDvmhw7zrbc6QnKWSH/e/mS3yL+C3I5XUzyV6o2YcHaa/Os3zv94I60Phcnu06zE9Ulh733a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630544; c=relaxed/simple;
	bh=IAaxgoeCJsJLYjpZHxPXX4qmFHPjlMz9AMOLC7nkPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu/p+SEFtGBvwdH6QwJ8lBXC35ZWVaxR3L5AiuAtDcFzcWSZfZmaL5hbRhgpIVIR+XbVJcZo1VBPZKlTKgIjLPhuNk95S2YEumRU11AKQ5G3Omy64ShFMdBEN4IpiLYcUC3e5El4o6KqStb0kBy+FacQ9kzItJpwr7VpCjKi51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdoNTHtu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdoNTHtu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so1897150a91.0;
        Sun, 21 Jul 2024 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721630542; x=1722235342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xEzYklpqYBgnyJTA+E77wihmjv1vKW71RVBehEaKTIM=;
        b=fdoNTHtuJPGOgnyhY1amh40tqfGubqAZ+xcwc/fkbZow41MkIqs8bh4mcK4OAglbCS
         fcgqiRlhWOuVaedsTAg8918SxHBg5Y0jcaMjrboBMx2NNMCRYxDo6kKqMwLzTUslA+aQ
         M4VByiVdT99b//Abb4MUkeoKIRIgoYvHEVc12zHJKsoyvFJdjPf9wzlFR39OJnXsq+Cy
         cL5bluxMqOq1UPr08UyRQgrE4N/oo/ufEFy//7hvGfTckWezrCTo/8SzDPVDqjmcadxn
         1dfhvN9M6bDVUn1bs1sVQYFV415I7DRHdjk5H9I80XCXHr4ao9QMPiOAgwn0hTlCPTDk
         HvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721630542; x=1722235342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEzYklpqYBgnyJTA+E77wihmjv1vKW71RVBehEaKTIM=;
        b=Ni0vemT+K9KtuY0dY9mkySc3NuchZmGWwPH+pBxvXucbgvv5K0OXjRiCMbgcLqNUcM
         eapLUrKwwu77v33P4Xy8LgBzy/UvMJk8B+KJtKrclPOFnHq8zVw9EhEGlP1gX0wcV2HN
         9319UsukxocKumSh2PfeA1/PzSaCDHV41pysWq6W6ZyQh/FOrMpAHq21mlSqbVxDG+Dw
         n8jRdWlooIGjEiZz7xOQe/ZS9GcWwD6w4lflXcTsFKsZON9JfVgSS3x8G+ng6ciqhUSU
         FGqIr7CMDz7sAm5kUPpZ0aKP/4hWnvyYn97HcM4E9iYu5/lIKdJUgPX6HJQxTvOpynHg
         Gwzg==
X-Forwarded-Encrypted: i=1; AJvYcCW8FHxm24fGIEpR8GWO+qGmYThYWpe6OnQj/EMA9+fIYWhjdt4L5bBlhaonxs1a8EiBNC66RRXTXOpZpebjlAxs288gO3hsxw8t6tHtGfkeyk8p5Fs0oM8eUxLQJRCQk7g2
X-Gm-Message-State: AOJu0YzUckUBHyubQMMXdi0y+eZetj0ApYqc2+BDy/8tUI1zzX9of+Qq
	wBpOEJ27u8f6jg9SfoVvpELJOkSLJId8cXOGEbnW+Sbt6fV3wsDLoW0XV3m4bWmOR6S6873vIFj
	3UZvONnxLe5+jdDS31CHX+GmN1Ak=
X-Google-Smtp-Source: AGHT+IHlO+ljDYswbfvNMxizipKTY+A05d/kXP9Hjm8wI+5/2CcS9Bc3wDvBLpzSDj28wNbiy8z5yO5JzLa0/S7Br9A=
X-Received: by 2002:a17:90a:4585:b0:2c7:22d6:98e with SMTP id
 98e67ed59e1d1-2cd2743b7admr2335334a91.19.1721630541562; Sun, 21 Jul 2024
 23:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d0e3b5061dc16993@google.com> <2897a6bd-6c7d-4b9b-8891-27051df45f8e@paulmck-laptop>
 <CALm+0cWP3=HJfdbQcRNf-StdfFEJw66HSX4i8a+fTek3zR=ORA@mail.gmail.com> <29449e47-d40b-4d01-94dc-630b2a92279b@paulmck-laptop>
In-Reply-To: <29449e47-d40b-4d01-94dc-630b2a92279b@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 22 Jul 2024 14:42:10 +0800
Message-ID: <CALm+0cXx4LADq0XJeUP6M0KwY_ok9bx7YLOz1BSX09D3XrvUAQ@mail.gmail.com>
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
> On Mon, Jul 22, 2024 at 11:38:31AM +0800, Z qiang wrote:
> > >
> > > On Sun, Jul 21, 2024 at 05:53:21AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=150e825e980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=28bac69fa31fbb3a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
> > > > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > > userspace arch: arm64
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4bf4e980000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-51835949.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/7a3a01db5542/vmlinux-51835949.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/14d329019155/Image-51835949.gz.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > Voluntary context switch within RCU read-side critical section!
> > > > WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > >
> > > Taking a voluntary context switch in an RCU read-side critical section
> > > voids your RCU warranty.
> > >
> > > > Modules linked in:
> > > > CPU: 0 PID: 3460 Comm: syz-executor248 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
> > > > Hardware name: linux,dummy-virt (DT)
> > > > pstate: 614000c9 (nZCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > > pc : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > > > lr : rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > > > sp : ffff800089523d30
> > > > x29: ffff800089523d30 x28: f6f0000005d4a480 x27: 0000000000000000
> > > > x26: 0000000000000000 x25: f6f0000005d4a480 x24: ffff800082643318
> > > > x23: 0000000000000000 x22: f6f0000005d4a480 x21: fff000007f8d6240
> > > > x20: ffff80008261e040 x19: fff000007f8d7040 x18: fffffffffffcb658
> > > > x17: fff07ffffd2b9000 x16: ffff800080000000 x15: 0000000000000048
> > > > x14: fffffffffffcb6a0 x13: ffff80008266b0a8 x12: 000000000000088b
> > > > x11: 00000000000002d9 x10: ffff80008271f500 x9 : ffff80008266b0a8
> > > > x8 : 00000000ffffdfff x7 : ffff80008271b0a8 x6 : 00000000000002d9
> > > > x5 : fff000007f8cbf48 x4 : 40000000ffffe2d9 x3 : fff07ffffd2b9000
> > > > x2 : 0000000000000000 x1 : 0000000000000000 x0 : f6f0000005d4a480
> > > > Call trace:
> > > >  rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
> > > >  __schedule+0xb0/0x850 kernel/sched/core.c:6417
> > > >  __schedule_loop kernel/sched/core.c:6606 [inline]
> > > >  schedule+0x34/0x104 kernel/sched/core.c:6621
> > > >  do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
> > > >  exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
> > > >  exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
> > > >  el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
> > > >  __el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
> > > >  el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
> > > >  el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599
> > > > ---[ end trace 0000000000000000 ]---
> > >
> > > If we are exiting to user mode, my first guess would be that someone
> > > did rcu_read_lock() but forgot the matching rcu_read_unlock().
> > >
> > > Can this be reproduced using lockdep?  That would pinpoint the unmatched
> > > rcu_read_lock().
> >
> > This should be caused by this modification  (commit id:
> > ca567df74a28a9fb368c6b2d93e864113f73f5c2)
> > when tsk is null, miss invoke rcu_read_unlock() for NS_GET_TGID_IN_PIDNS.
>
> Very good, and it looks like that to me as well.  Would you like to
> submit a fix patch and see if syzbot agrees?

I see there is a c test
program(https://syzkaller.appspot.com/x/repro.c?x=17a3c349980000),
I will run this test on my local machine, and then make a fix.

Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > If the report is already addressed, let syzbot know by replying with:
> > > > #syz fix: exact-commit-title
> > > >
> > > > If you want syzbot to run the reproducer, reply with:
> > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > If you attach or paste a git patch, syzbot will apply it before testing.
> > > >
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
