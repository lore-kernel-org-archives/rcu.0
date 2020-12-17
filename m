Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2B9C4361B
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C51423715
	for <rcu@archiver.kernel.org>; Thu, 17 Dec 2020 10:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgLQKEO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Dec 2020 05:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQKEN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Dec 2020 05:04:13 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15251C061794
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 02:03:33 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id k7so6140106ooa.0
        for <rcu@vger.kernel.org>; Thu, 17 Dec 2020 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QovU7n4TipZBHahKpVmuX6ckuC6desZlmOmZDqTqu3M=;
        b=JRI+pp7dnV1oOaSedDD0zjdx02ivklV8ckbZfiPHBcKgcdLi7zY+gS227LevsvZ0qt
         IDh8C0GVZpETDBWL96aYpOOsWjVr/wm7Yg2mPbqvPEzwoBK/acGCdB7H2Bm46SbXlMY9
         LI9prf+HrkxZcJ73yGyH50UGC7W7uAfLxSK2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QovU7n4TipZBHahKpVmuX6ckuC6desZlmOmZDqTqu3M=;
        b=Hrr3sduiuvxdKJ6/63F4rxBLEjvE+yAjK7ll8G86anWPYuXgugJSx+FnNcscZKOSe8
         Zy+uqM1tUv2HyNWZWywBIUOIjb0AQ3wiIDUPEnMpNSHorFNhsSmJe72QR1Up/xqqf5SV
         lJoXvXLd677u3icFZy6H8Z9tEzfDIyaYcmE/jvX22FuB59TFGVsEIMnJV4Bd/cSwEoxK
         dnsDzwASA2rUPYqmczf7Xo86zZKfmG5nPAlk4BW2TKNlpGJB3ETTDFQAMtlFYpZ3kA4Y
         kfPze2owMzirHEHgiI1aJeHyj/qc83Ac/qOLOrEjrqSTX5TB7lZ6s2QjX+jG9v9ND/zp
         +nsQ==
X-Gm-Message-State: AOAM533gDWtR0QdqqD2UXwBUBgSf2IOSSAUshPlGFCYZDLoYpRS0L2/c
        eJsFHQnXRVCQ5IYVqWvn74G6OCcw58X2B0BXFaoFpw==
X-Google-Smtp-Source: ABdhPJy5FyP1RpGPHptqgvfzTl40RI28lCDVHE2WDMhIPwjXe0oeZjeKTXrjIAMh+Ju7p0whj3OsI4bRHTUe7q/o58A=
X-Received: by 2002:a4a:c387:: with SMTP id u7mr23255908oop.89.1608199412424;
 Thu, 17 Dec 2020 02:03:32 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cb6db205b68a971c@google.com> <CAKMK7uEiS5SrBYv-2w2wWL=9G4ByoHvtiWVsPqekswZzOGmzjg@mail.gmail.com>
 <20201216161621.GH2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201216161621.GH2657@paulmck-ThinkPad-P72>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 17 Dec 2020 11:03:20 +0100
Message-ID: <CAKMK7uH1agVS=e245b=25Lv9Q+u5c7=KL-_NF8Hte10nKTqAXw@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in modeset_lock
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+972b924c988834e868b2@syzkaller.appspotmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 5:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Dec 16, 2020 at 10:52:06AM +0100, Daniel Vetter wrote:
> > On Wed, Dec 16, 2020 at 2:14 AM syzbot
> > <syzbot+972b924c988834e868b2@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    94801e5c Merge tag 'pinctrl-v5.10-3' of git://git.kernel.o..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=130558c5500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8a1012a5314210
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=972b924c988834e868b2
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+972b924c988834e868b2@syzkaller.appspotmail.com
> > >
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.10.0-rc7-syzkaller #0 Not tainted
> > > -----------------------------
> > > kernel/sched/core.c:7270 Illegal context switch in RCU-sched read-side critical section!
> > >
> > > other info that might help us debug this:
> > >
> > >
> > > rcu_scheduler_active = 2, debug_locks = 0
> > > 7 locks held by syz-executor.1/9232:
> > >  #0: ffffffff8b328c60 (console_lock){+.+.}-{0:0}, at: do_fb_ioctl+0x2e4/0x690 drivers/video/fbdev/core/fbmem.c:1106
> > >  #1: ffff888041bd4078 (&fb_info->lock){+.+.}-{3:3}, at: lock_fb_info include/linux/fb.h:636 [inline]
> > >  #1: ffff888041bd4078 (&fb_info->lock){+.+.}-{3:3}, at: do_fb_ioctl+0x2ee/0x690 drivers/video/fbdev/core/fbmem.c:1107
> > >  #2: ffff888041adca78 (&helper->lock){+.+.}-{3:3}, at: drm_fb_helper_pan_display+0xce/0x970 drivers/gpu/drm/drm_fb_helper.c:1448
> > >  #3: ffff8880159f01b8 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x1d/0x70 drivers/gpu/drm/drm_auth.c:407
> > >  #4: ffff888041adc898 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x44/0x580 drivers/gpu/drm/drm_client_modeset.c:1143
> > >  #5: ffffc90001c07730 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0xb7/0x7c0 drivers/gpu/drm/drm_client_modeset.c:981
> > >  #6: ffff888015986108 (crtc_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_lock_slow include/linux/ww_mutex.h:287 [inline]
> > >  #6: ffff888015986108 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x31c/0x650 drivers/gpu/drm/drm_modeset_lock.c:260
> >
> > Given that we managed to take all these locks without upsetting anyone
> > the rcu section is very deep down. And looking at the backtrace below
> > I just couldn't find anything.
> >
> > Best I can think of is that an interrupt of some sort leaked an rcu
> > section, and we got shot here. But I'd assume the rcu debugging would
> > catch this? Backtrace of the start of that rcu read side section would
> > be really useful here, but I'm not seeing that in the logs. There's
> > more stuff there, but it's just the usual "everything falls apart"
> > stuff of little value to understanding how we got there.
>
> In my experience, lockdep will indeed complain if an interrupt handler
> returns while in an RCU read-side critical section.
>
> > Adding some rcu people for more insights on what could have gone wrong here.
> > -Daniel
> >
> > > stack backtrace:
> > > CPU: 1 PID: 9232 Comm: syz-executor.1 Not tainted 5.10.0-rc7-syzkaller #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x107/0x163 lib/dump_stack.c:118
> > >  ___might_sleep+0x25d/0x2b0 kernel/sched/core.c:7270
> > >  __mutex_lock_common kernel/locking/mutex.c:935 [inline]
> > >  __ww_mutex_lock.constprop.0+0xa9/0x2cc0 kernel/locking/mutex.c:1111
> > >  ww_mutex_lock+0x3d/0x170 kernel/locking/mutex.c:1190
>
> Acquiring a mutex while under the influence of rcu_read_lock() will
> definitely get you this lockdep complaint, and rightfully so.
>
> If you need to acquire a mutex with RCU-like protection, one approach
> is to use SRCU.  But usually this indicates (as you suspected) that
> someone forgot to invoke rcu_read_unlock().
>
> One way to locate this is to enlist the aid of lockdep.  You can do this
> by putting something like this in the callers:
>
>         RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
>                          lock_is_held(&rcu_lock_map) ||
>                          lock_is_held(&rcu_sched_lock_map),
>                          "We are in an RCU read-side critical section");
>
> This will get you a lockdep complaint much like the one above if the
> caller is in any sort of RCU read-side critical section.  You can push
> this up the call stack one level at a time or just sprinkle it up the
> stack in one go.
>
> The complaint is specifically about RCU-sched, so you could focus on
> that using this instead:
>
>         RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),
>                          "We are in an RCU-sched read-side critical section");
>
> This of course assumes that this is reproducible.  :-/
>
> But even if it isn't reproducible, for example, if the mutex is only
> acquired occasionally, these RCU_LOCKDEP_WARN() calls can be used to
> check assumptions about state.

I think we're tripping over the might_sleep() all the mutexes have,
and that's not as good as yours, but good enough to catch a missing
rcu_read_unlock(). That's kinda why I'm baffled, since like almost
every 2nd function in the backtrace grabbed a mutex and it was all
fine until the very last.

I think it would be really nice if the rcu checks could retain (in
debugging only) the backtrace of the outermost rcu_read_lock, so we
could print that when something goes wrong in cases where it's leaked.
For normal locks lockdep does that already (well not full backtrace I
think, just the function that acquired the lock, but that's often
enough). I guess that doesn't exist yet?

Also yes without reproducer this is kinda tough nut to crack.
-Daniel

>
>                                                         Thanx, Paul
>
> > >  modeset_lock+0x392/0x650 drivers/gpu/drm/drm_modeset_lock.c:263
> > >  drm_modeset_lock drivers/gpu/drm/drm_modeset_lock.c:342 [inline]
> > >  drm_modeset_lock+0x50/0x90 drivers/gpu/drm/drm_modeset_lock.c:338
> > >  drm_atomic_get_plane_state+0x19d/0x510 drivers/gpu/drm/drm_atomic.c:481
> > >  drm_client_modeset_commit_atomic+0x225/0x7c0 drivers/gpu/drm/drm_client_modeset.c:994
> > >  drm_client_modeset_commit_locked+0x145/0x580 drivers/gpu/drm/drm_client_modeset.c:1145
> > >  pan_display_atomic drivers/gpu/drm/drm_fb_helper.c:1395 [inline]
> > >  drm_fb_helper_pan_display+0x28b/0x970 drivers/gpu/drm/drm_fb_helper.c:1455
> > >  fb_pan_display+0x2f7/0x6c0 drivers/video/fbdev/core/fbmem.c:925
> > >  fb_set_var+0x57f/0xda0 drivers/video/fbdev/core/fbmem.c:1043
> > >  do_fb_ioctl+0x2f9/0x690 drivers/video/fbdev/core/fbmem.c:1108
> > >  fb_compat_ioctl+0x17c/0xaf0 drivers/video/fbdev/core/fbmem.c:1315
> > >  __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
> > >  do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
> > >  __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:137
> > >  do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
> > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > > RIP: 0023:0xf7fd8549
> > > Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> > > RSP: 002b:00000000f55d20bc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004601
> > > RDX: 0000000020000240 RSI: 0000000000000000 RDI: 0000000000000000
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > detected fb_set_par error, error code: -16
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
