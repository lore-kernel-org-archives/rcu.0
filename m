Return-Path: <SRS0=BHDS=BB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0491C433E2
	for <rcu@archiver.kernel.org>; Wed, 22 Jul 2020 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADC12071A
	for <rcu@archiver.kernel.org>; Wed, 22 Jul 2020 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOZ6Uetu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgGVP0K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732628AbgGVP0J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jul 2020 11:26:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CCBC0619DC
        for <rcu@vger.kernel.org>; Wed, 22 Jul 2020 08:26:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so1570237pjt.0
        for <rcu@vger.kernel.org>; Wed, 22 Jul 2020 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzLOOS//hUD8q9wPH1hxqf0po1Wm9sGqsog9+/iTqAI=;
        b=NOZ6UetuWCJDo0hzkrmh3VMWWV8D9oRUMNZ4pDO/kd+xEWZ3QyxKqGDHqUhauU42FT
         lJzbINvNQ1ipDKEiN6giuu5cmLuuCZzH9aWilbHEM/+yYaK0n5KkbpzB3e+7nRY92qp9
         BJfGq3Hc4KULpAJlLg0z7bJ8+wchj3TY7lAYpqgPBp9T0FMfvwvM8UI7gAqZ1aQNc05l
         /COONQpsGm7VOPJuN4srq76cyOU5+y1lnlFGsR46MxI863bKkBEhKiPHnLRRwjqGRU3D
         lk1WvdlrwxYRZussgyknvro6EMDvVT5va4jpcOh16Ex9YhZvZ2xr5u2kMB/OOB5Mx7Ap
         kmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzLOOS//hUD8q9wPH1hxqf0po1Wm9sGqsog9+/iTqAI=;
        b=V4h1lg8/cU4tJEjuQqarVnK2qmz7/+XfRF9XeHU5vFtTee1Wj0OkeH0u1JVIbjlTil
         98SFPnIdjy7n1y39Ir3JntiEYUYIrjHkJ8fVK3yuFaJBMEJZhOkHYTVVwj3xjfbe2dnm
         QLmGdnRB4pUIwMineOctYObiNOAB+FFihb8uvNF+3lKhPYsSfo7fL2XRdkb4hjovjfbe
         Lrgyb3ovWorHuPqz8uP81pmXoxb2nprOniEq+9+RAWYoS4Z68zudBZ1zU75K/jPu3e9v
         7Wh9oFPX7zd7jDNjtXYRlkhRvcyqJjsjUN73Axm4O9xyXS4j4DFow4Hv7ev63glhXNns
         dmuw==
X-Gm-Message-State: AOAM532i20XQY3oHoMR6sc9Qc+3l/nw/ro/HPXsjuNRWa6pHIOU/HJj4
        Zr/amPLVMKM2Kbs+6zc82PEorLwuCikNNVwMSnqrcQ==
X-Google-Smtp-Source: ABdhPJxwGbDkiUfVo298yjBOWU/WqwCHTeJkyyPq+H7SlytcoTd3ErvS9165gVdX0ddyHf3f1m9/coLUoxNHm/YzU3c=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr10501433pjb.91.1595431568642;
 Wed, 22 Jul 2020 08:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHH7nDRYE6-tZL6+QmyX21D4OOQ4YU+v+okE6FEqqkhg@mail.gmail.com>
 <CAK8P3a01smLHy0vyPX0WxDRWWPxDCbZhRCBB5qGFvMCnsghwjg@mail.gmail.com> <20200722130109.GO9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200722130109.GO9247@paulmck-ThinkPad-P72>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jul 2020 08:25:32 -0700
Message-ID: <CAGETcx9xjyPw01gmhtu9XShmkmXriTPgoc8UfSQgHhkQg5S=VQ@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c db410c
To:     paulmck@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        walter-zh.wu@mediatek.com, neeraju@codeaurora.org,
        Vinod Koul <vinod.koul@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 22, 2020 at 6:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 10:04:21AM +0200, Arnd Bergmann wrote:
> > On Wed, Jul 22, 2020 at 9:44 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > Kernel BUG noticed on arm64 db410c device while booting linux next 20200721 tag.
> > > Continually popping up these BUG messages on the boot console and kernel warning
> > > also noticed.
> > >
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   git commit: de2e69cfe54a8f2ed4b75f09d3110c514f45d38e
> > >   git describe: next-20200721
> > >   kernel-config:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/818/config
> > >   build-location:
> > > http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/dragonboard-410c/lkft/linux-next/818
> > >
> > > Crash log:
> > > [    0.444349] BUG: sleeping function called from invalid context at
> > > /usr/src/kernel/kernel/locking/mutex.c:935
> > > [    0.444422] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
> > > 30, name: kworker/0:1
> > > [    0.444458] 2 locks held by kworker/0:1/30:
> > > [    0.444489]  #0: ffff00000eb15138
> > > ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x208/0x768
> > > [    0.444627]  #1: ffff800013713df0
> > > ((work_completion)(&sdp->work)){+.+.}-{0:0}, at:
> > > process_one_work+0x208/0x768
> > > [    0.444761] CPU: 0 PID: 30 Comm: kworker/0:1 Not tainted
> > > 5.8.0-rc6-next-20200721 #1
> > > [    0.444787] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > > [    0.444817] Workqueue: rcu_gp srcu_invoke_callbacks
> > > [    0.444856] Call trace:
> > > [    0.444883]  dump_backtrace+0x0/0x1f8
> > > [    0.444910]  show_stack+0x2c/0x38
> > > [    0.444939]  dump_stack+0xf0/0x16c
> > > [    0.444969]  ___might_sleep+0x144/0x208
> > > [    0.444996]  __might_sleep+0x54/0x90
> > > [    0.445027]  __mutex_lock+0x64/0x970
> > > [    0.445055]  mutex_lock_nested+0x54/0x70
> > > [    0.445084]  device_del+0x44/0x3c0
> > > [    0.445110]  device_unregister+0x24/0x78
> > > [    0.445138]  __device_link_free_srcu+0x64/0x70
> > > [    0.445164]  srcu_invoke_callbacks+0x10c/0x1a0
> >
> > The device_unregister() was added to __device_link_free_srcu() as part
> > of commit 287905e68dd2 ("driver core: Expose device link details in sysfs")
> >
> > I'm fairly sure this is what introduced the console output, though the
> > code before it is already suspicious:
> >
> > call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> >
> > According to the documentation, call_srcu() must not call any sleeping
> > functions, which is what the 'in_atomic(): 1' above is about.
>
> Yes, the callback function, in this case __device_link_free_srcu(),
> will execute from softirq context.
>
> > However, from what I can tell, the put_device() and pm_runtime_put()
> > calls in device_link_free() can also potentially sleep even if they normally
> > don't warn about that.
>
> The usual workaround is to have __device_link_free_srcu() schedule a
> workqueue that invokes the potentially sleeping functions.
>
>                                                         Thanx, Paul

Thanks for reporting. It was already reported and fixed last week.
Waiting on Greg to pull it in.
https://lore.kernel.org/lkml/CAGETcx9quqtV9TeD8WEcLLijGeV+7hXqnyiMv7F8xo+vyF_7iw@mail.gmail.com/#t


-Saravana
