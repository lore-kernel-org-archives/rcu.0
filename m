Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1421C433F5
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 01:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiCVBDX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Mar 2022 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbiCVBDW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Mar 2022 21:03:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CB73BB7B5
        for <rcu@vger.kernel.org>; Mon, 21 Mar 2022 18:01:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so33091895ejb.13
        for <rcu@vger.kernel.org>; Mon, 21 Mar 2022 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCU47dWtMaxwzN2nw+/flrpgN1+qt7GJRMjPkG/nfZ4=;
        b=e2SEFFHfSW8b+NHspznI9t78ncmyPprk6s/GZ0v/h/C4yxJqK9S7OmEq6BJ2hGpXLZ
         Bo6rwV77PRqW0WOho14m4D8xcgOdPXtkv3f3ixv869LRFIEtoCK58iHisCSg/8V2AM4F
         39hbQKBb4JukgAh6kkia0sPAr2y5kz4j1MzOURviB+GoFxPyB1FgBhaq6mMbbALcBb5H
         E509cSnDPIbT50DLXSSWEX/J2iOiTdcTpVGYEa5B9INtJ09VqnxE5l+Zx1zUDyWc0uGV
         Tv6/JgLMAj8gt7WCd2SeAUnRm3a9hW2hU7jDonvu5YfTC6IMyT+nbiRJD4DCDB+PdJYc
         Zcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCU47dWtMaxwzN2nw+/flrpgN1+qt7GJRMjPkG/nfZ4=;
        b=hAopyV6Mbdy/IgO+3yrXKhXrl1ZG6afNQfOZhA1qNS/Oo3GkO/NlB71l214tJdahY5
         llZkyIFhudpaPztiOaxo0XN+e5tuDGJctG87YyqzFkJQ2YyLJBqsdql3hyh0n7HHFXlM
         f9/Mz582ioKm7nRarkavIlV7FWnzzIEn00FG3Y9yjwYjcyT7fy8o0VIIxXi/3ihSQ7q9
         BbrWhHxy6LKPYRqOikoDOpn2YyXEcfa1RUiDxZiCFCnJE8DFlT5cLI/2hc1zUH3Yp1qH
         MaLyyYI38010Kbj0R8bYZrrK4v5KvgjHAvmhxmvmAQur0hW3saETtmxbzxuQM6AcBYc7
         Pqjg==
X-Gm-Message-State: AOAM533+A1T3Y4GWlS33xm1aPvoLQpRBwNUb9w0XTMfZSZ5AcS1GDKEe
        xw6oKK5lyUmGO5DEXrOwB9lDJtQo1JFLIVHlRIQ=
X-Google-Smtp-Source: ABdhPJx33b+JzEBenf5koeVOlZ1SZEyKn001PIw3HNgRB5h9zjFk4yIR/wd5g0uJDiw+HfXl0zM7IJnDARFqprnk9VQ=
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id
 o6-20020a170906774600b006cea12e489fmr22473602ejn.551.1647910912085; Mon, 21
 Mar 2022 18:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <Yje18NgLjpPo7VEp@casper.infradead.org> <SA1PR15MB49655CF8AC3998CA9A7CE903B8169@SA1PR15MB4965.namprd15.prod.outlook.com>
 <20220321043813.GF4285@paulmck-ThinkPad-P17-Gen-1> <20220321071327.GA798064@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2woW2UuPg1rSYYc+S6k7qd9JwM4gJFMHhiVcBkDewE_Nw@mail.gmail.com>
 <20220321155746.GG4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x=ZNkDME12fKAapESLSrhmC9sT-Rmm4EEJLqqfyyEfGw@mail.gmail.com>
 <20220321215012.GM4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220321215012.GM4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 22 Mar 2022 09:01:40 +0800
Message-ID: <CAABZP2x1JouxNUB3JR8dFXAMK58C2DFVx_BVAvREK=i4hBJL4g@mail.gmail.com>
Subject: Re: Fw: rc6 splat
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul McKenney <paulmckrcu@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul

On Tue, Mar 22, 2022 at 5:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Mar 22, 2022 at 05:19:28AM +0800, Zhouyi Zhou wrote:
> > Hi Paul,
> >
> > On Mon, Mar 21, 2022 at 11:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 11:46:28PM +0800, Zhouyi Zhou wrote:
> > > > Hi Paul and Willy
> > > >
> > > > I can reproduce the bug. Following is what I do:
> > > > 1.1 git clone https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
> > > > 1.2 cd linux
> > > > 1.3 cp http://154.223.142.244/20220321/config-20220321 to .config
> > > > 1.4 make vmlinux -j 16
> > > > 1.5 kvm -smp 4 -net none     -serial file:/tmp/console.log -m 512
> > > > -kernel vmlinux -append "console=ttyS0"
> > > > 1.6 the /tmp/console.log is uploaded to
> > > > http://154.223.142.244/20220321/console.log
> > > >
> > > > 2.1 wget https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.17-rc6.tar.gz
> > > > 2.2 - 2.6 the result is similar.
> > > >
> > > > I am very interested in this topic.
> > > > Could you please give me about a week to make a full understand of the
> > > > meaning of the warning, and try the fixes one by one, and
> > > > find out what happens?
> > >
> > > Works for me!  The eventual fix likely involves some version of Valentin
> > > Schneider's patchset that provides APIs that allow RCU to detect the
> > > current preemption state.  Which can change at runtime.  A prototype of
> > > this patch is on -rcu here:
> > >
> > > 2436ee0b4cea ("EXP preempt/dynamic: Introduce preempt mode accessors")
> > >
> > > It is entirely possible that the fix might need to go to mainline sooner
> > > rather than later.
> > I tried to apply 2436ee0b4cea to 5.17.0-rc6, but this does not work,
> > and I will try other fixes above in the coming days.
> > WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696
> > rcu_tasks_verify_self_tests+0x29/0x30
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc6 #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:rcu_tasks_verify_self_tests+0x29/0x30
> > Code: 90 55 31 c0 48 89 e5 53 48 c7 c3 80 ef 0c 82 80 7b 18 00 0f 84
> > 39 a1 63 00 48 83 c3 20 48 81 fb e0 ef 0c 82 75 e9 85 c0 74 02 <0f> 0b
> > 5b 5d c3 66 90 31 c0 80 3d 1b 6f ca 01 00 55 48 89 e5 75 10
> > RSP: 0000:ffff888003173e98 EFLAGS: 00010286
>
> In addition to v5.17-rc6, could you please also try reproducing this
> problem on the -rcu tree's "dev" branch?
Unfortunately, the problem remains in -rcu tree's "master" branch and
-rcu tree's "dev' branch:
1) console.log for linux-rcu:
http://154.223.142.244/20220321/linux-rcu-console.log
2) console.log for linux-rcu(dev):
http://154.223.142.244/20220321/linux-rcu-dev-console.log (
Linux version 5.17.0-rc1-00158-g45abaed6ed05)

Could you please tell me if I have made any mistakes above?
>
> And yes, there may well be additional dependencies from earlier on the
> -rcu branch on the one hand and conflicting commits following v5.17-rc1
> in mainline on the other.  Not necessarily a simple backport, sad to say.
I still have a lot to learn in RCU ;-)
>
> > by the way, Paul, could you please take a look at following:
> > 1664static void rcu_tasks_initiate_self_tests(void)
> > 1665{
> > 1666        pr_info("Running RCU-tasks wait API self tests\n");
> > 1667#ifdef CONFIG_TASKS_RCU
> > 1668        synchronize_rcu_tasks();
> > 1669        call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> > 1670#endif
> > shouldn't synchronize_rcu_tasks() be called after
> > call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback)
> > There is much for me to learn in RCU, but my intuition let me ask your
> > help to take a little look at this.
>
> The order should not matter.  However, if synchronize_rcu_tasks() is to
> be used before the scheduler is initialized, then there would need to
> be a single-CPU check.  (This is not currently guaranteed, so as far as
> I know, there is no need to add such a check.)
Thanks for your answer ;-) I think I should learn more about this in
the coming days.
>
>                                                         Thanx, Paul
>
Kind Regard
Thanks
Zhouyi
