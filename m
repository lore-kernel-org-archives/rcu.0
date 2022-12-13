Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EA2C4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 15:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiLMPzJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiLMPzJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 10:55:09 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3F19005
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 07:55:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g14so3703465ljh.10
        for <rcu@vger.kernel.org>; Tue, 13 Dec 2022 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f45LqSLATEMrJCmw7aYkQz4KkDjKXisGTgOLI8JUUMU=;
        b=foFhoa5s2L3nT3GlSpjnKkQaiN4h8e6BQz+8OVie20qSf/jcUdw25d8fDQSuR7eJ7v
         5h4rdWdzND603joeZq5uX+EKdR1eCOfHo7boE7FOSpZ0S6r6Fevwmnuy/D8O6eKhcBw3
         qNi2SzyTK1rKd5uhEIug01l+E9t3QVOWrcbn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f45LqSLATEMrJCmw7aYkQz4KkDjKXisGTgOLI8JUUMU=;
        b=XWrKTObAkzXYVVG2nS2Takf8ggrYXC1jp+XxF4fsMoIXpwIrZ1521cYfjVnjb24SU/
         4tR3OlDiSPr1/61ZnMHKhI24CRs1x6ZtUNBHuEE0DD25V4oGU0snkRRSgeIgxLuVVeY2
         12WDydMhlGWuZeeukgptMR/3z+aF/y6vRLjLGPHvjDweBnlgUoztbZ26JuhrgY21CAdt
         MWpowydi5fDImHMtbTdccPty3A8OJcNBdD8JiGakRamgz/W7zZRyoOB5421GMhBV0tml
         Cj6p0B+OeDxIQbGPHT4LN1sltBqt/4cNiIH7tGHoAcZ5sEj9xgIfnq6jGgldOUlhI224
         hj/Q==
X-Gm-Message-State: ANoB5pld+ZwTja3OUXCLsixEcBbJzCXv1sUoEIHHRocRKuuTx2uLUlWh
        jRDMyaMe30YRkuP/5qrtAOSKnaU3+p7VDM6sUUSG0Q==
X-Google-Smtp-Source: AA0mqf5UDDvBoNUEJ03+OUKF/c071tTBcbnQtz+ZcXFJpWEQ/eowblIpCR9N28KEUIkFM/6Z0CFzNbAjAkYA6LnVKNw=
X-Received: by 2002:a2e:3309:0:b0:279:d1ef:69f7 with SMTP id
 d9-20020a2e3309000000b00279d1ef69f7mr11910701ljc.167.1670946905983; Tue, 13
 Dec 2022 07:55:05 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB5880569A84B6DCAA1D5F4837DAE29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <D00B9D88-368D-48E1-BE16-532417EDB7F5@joelfernandes.org> <PH0PR11MB58803E07FC1F7DC60545F405DAE39@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58803E07FC1F7DC60545F405DAE39@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 13 Dec 2022 10:54:54 -0500
Message-ID: <CAEXW_YS5NiFH4OpLFQgT=Mbm21D6DPvafMXf6sW=CSPBx0AgJg@mail.gmail.com>
Subject: Re: [Report] v4.19 TREE03 splat (stable kernel with ChromeOS patches)
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 13, 2022 at 8:21 AM Zhang, Qiang1 <qiang1.zhang@intel.com> wrot=
e:
>
> > On Dec 12, 2022, at 6:45 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wro=
te:
> >
> > =EF=BB=BFOn Fri, Dec 9, 2022 at 11:34 PM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> >>
> >> Hello,
> >>
> >> I see this an hour into the run for TREE03 on v4.19:
> >> tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 32 --duration 60
> >>
> >> Checking to see if Qiang has any thoughts as I saw him comment about a=
 similar
> >> issue in [1].
> >>
> >> [ 3243.844445] ------------[ cut here ]------------^M
> >> [ 3243.847112] WARNING: CPU: 1 PID: 0 at kernel/kthread.c:411 __kthrea=
d_bind_mask+0x19/0x60^M
> >> [ 3243.851585] Modules linked in:^M
> >> [ 3243.853295] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.267+ #1^=
M
> >> [ 3243.856699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS 1.16.0-debian-1.16.0-4 04/01/2014^M
> >> [ 3243.860052] RIP: 0010:__kthread_bind_mask+0x19/0x60^M
> >> [ 3243.861769] Code: 48 89 42 20 c3 66 66 2e 0f 1f 84 00 00 00 00 00 9=
0 41 55 41 54 55 48 89 f5 48 89 d6 53 48 89 fb e8 3c e9 00 00 48 85 c0 75 0=
9 <0f> 0b 5b 5d 41 5c 41 5d c3 4c 8d ab b4 07 00 00 4c 89 ef e8 6f 28^M
> >> [ 3243.867751] RSP: 0000:ffffa54b8014fec0 EFLAGS: 00010246^M
> >> [ 3243.868959] RAX: 0000000000000000 RBX: ffff95555ee3c240 RCX: 000000=
0000000000^M
> >> [ 3243.870606] RDX: ffff95555f063d80 RSI: 0000000000000246 RDI: 000000=
00ffffffff^M
> >> [ 3243.872246] RBP: ffffffffb720a010 R08: af82bdcb11f9f4ff R09: 000000=
0000000000^M
> >> [ 3243.873894] R10: ffffa54b8014fe70 R11: 00000000621ccdc2 R12: 000000=
0000000000^M
> >> [ 3243.875538] R13: 0000000000000000 R14: 0000000000000000 R15: 000000=
0000000000^M
> >> [ 3243.877181] FS:  0000000000000000(0000) GS:ffff95555f040000(0000) k=
nlGS:0000000000000000^M
> >> [ 3243.878698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> >> [ 3243.879747] CR2: 0000000000000000 CR3: 000000001300a000 CR4: 000000=
00000006e0^M
> >> [ 3243.881050] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000^M
> >> [ 3243.882358] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400^M
> >> [ 3243.883660] Call Trace:^M
> >> [ 3243.884925]  kthread_unpark+0x52/0x60^M
> >> [ 3243.885613]  cpuhp_online_idle+0x31/0x50^M
> >> [ 3243.886341]  cpu_startup_entry+0x62/0x70^M
> >> [ 3243.887063]  start_secondary+0x186/0x1b0^M
> >> [ 3243.887783]  secondary_startup_64+0xa4/0xb0^M
> >>
> >> [1] https://groups.google.com/g/syzkaller-bugs/c/w_LARy6pxvQ/m/dKjQyHA=
xAQAJ
> >>
> >>
> >> This set of scheduler patches seems to make it go away, however I am
> >> running a long weekend test to collect more data:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=
=3Drcu/torture/v4.19.fixes.wip.120922
> >
> >
> > Hi Joel
> >
> > I also used the link above to do the TREE03 test, looks like the proble=
m still exists:
> >
> > 5834 [  966.016205]  kthread_unpark+0x50/0x60^M
> > 5835 [  966.016440]  cpuhp_online_idle+0x31/0x50^M
> > 5836 [  966.016678]  cpu_startup_entry+0x65/0x70^M
> > 5837 [  966.016913]  start_secondary+0x18b/0x1c0^M
> > 5838 [  966.017148]  secondary_startup_64+0xa4/0xb0^M
> > 5839 [  966.017407] ---[ end trace 636953f76b8055db ]---^M
> > 5840 [  966.017691] migration/1     R  running task    14952    18     =
 2 0x80000000 last_sleep: 961405359084.  last_runna      ble: 961700816631^=
M
> > 5841 [  966.018406] Call Trace:^M
> > 5842 [  966.018559]  __schedule+0x75f/0x1320^M
> > 5843 [  966.018775]  ? cpuhp_invoke_callback+0x88/0x600^M
> > 5844 [  966.019042]  ? ___preempt_schedule+0x16/0x18^M
> > 5845 [  966.019302]  ? sort_range+0x20/0x20^M
> > 5846 [  966.019515]  preempt_schedule_common+0x32/0x80^M
> > 5847 [  966.019776]  ___preempt_schedule+0x16/0x18^M
> > 5848 [  966.020018]  _raw_spin_unlock_irq+0x1f/0x20^M
> > 5849 [  966.020275]  smpboot_thread_fn+0x195/0x230^M
> > 5850 [  966.020525]  kthread+0x139/0x160^M
> > 5851 [  966.020717]  ? kthread_create_worker_on_cpu+0x60/0x60^M
> > 5852 [  966.021014]  ret_from_fork+0x35/0x40^M
> >
> > From the calltrace, the state of migration kthreads is not correct,
> > I'm also looking at what's going wrong.
> >
> >Thanks for checking. I also noticed that the state of those threads is r=
unning instead of parked, causing the warning.
> >
> >- Joel
>
> Hi Joel
>
> I find the TREE03 enable CONFIG_SCHED_CORE =3D y, under this condition, i=
f the cpu goes offline,
> we will directly select the idle kthread, which leads to it preempting th=
e migration kthread.
> through calltrace, it can also be found , the  migration/1  kthread is pr=
eempted and schedule out.
>
> [  966.017691] migration/1     R  running task    14952
> [  966.018559]  __schedule+0x75f/0x1320^M
> [  966.018775]  ? cpuhp_invoke_callback+0x88/0x600^M
> [  966.019042]  ? ___preempt_schedule+0x16/0x18^M
> [  966.019302]  ? sort_range+0x20/0x20^M
> [  966.019515]  preempt_schedule_common+0x32/0x80^M
> [  966.019776]  ___preempt_schedule+0x16/0x18^M
> [  966.020018]  _raw_spin_unlock_irq+0x1f/0x20^M
> [  966.020275]  smpboot_thread_fn+0x195/0x230^M
> [  966.020525]  kthread+0x139/0x160^M
> [  966.020717]  ? kthread_create_worker_on_cpu+0x60/0x60^M
> [  966.021014]  ret_from_fork+0x35/0x40^M
>
> The following modification can fix this warning(this change comes from th=
e new kernel version).
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0acbc7706d71..1c76226a2c26 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4109,8 +4109,10 @@ pick_next_task(struct rq *rq, struct task_struct *=
prev, struct rq_flags *rf)
>         bool fi_before =3D false;
>
>         cpu =3D cpu_of(rq);
> -       if (cpu_is_offline(cpu))
> -               return idle_sched_class.pick_next_task(rq, prev, rf);
> +       if (cpu_is_offline(cpu)) {
> +               rq->core_pick =3D NULL;
> +               return __pick_next_task(rq, prev, rf);
> +       }

Wow hats off at that debugging and thank you so much, I will test this
more and let you know. I think CONFIG_SCHED_CORE might be enabled by
default on the ChromeOS 4.19 kernel, which is why we see it and the
regular 4.19 stable kernel does not.

Anyway thank you again and kudos on the awesome debug. I will keep you
posted on my testing.

Thanks,

 - Joel
