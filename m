Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D6C27C76
	for <rcu@archiver.kernel.org>; Wed, 25 Jan 2023 07:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjAYHsb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Jan 2023 02:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjAYHs3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Jan 2023 02:48:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8100740BDD
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 23:48:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so12837529pgm.13
        for <rcu@vger.kernel.org>; Tue, 24 Jan 2023 23:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDwF9tj9fHvlSpuuPGJLGMfwfwlYr2nV0zrttFWAWug=;
        b=oePwEgdQGnoteB/ReC0ko22W2wPgFGjSMDXewYn+lmHngALzjLuBIA79ZVZNWVUw8I
         4zPwmlPLCHi+yR/9xNhFLmM2BVpxqixEKSStlAwTCTHxjm190HPyeV/ookzG9I5rAebf
         +6iFuFg4IpJlQ68QzaBEajzZzcWhkmCsxzzQ9TIsIFeEu+gAWaf7rtpJlgpQii/DBsi3
         +6fwhoDvZZYwjjntYq6seAq6SfPMb0SKxHY0ZTUxhZzviZ3CwWNezqFqdfBIVNk0XTGw
         x6qlcXwden/q9tntNB4ciDt7PoWHVEhLzMWqY/0d2f6fgGQor/7jTHrA3OgdAOJdEUW+
         NmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDwF9tj9fHvlSpuuPGJLGMfwfwlYr2nV0zrttFWAWug=;
        b=Ho+WVKIJo74BZ7WRBpoV5vc3KYrLaZY5HRcymBki6WOpaglw9PCoMqW9EbuO99Grm9
         Rae8Jn5EPdN6toOvyqicDOS52wVzYNSh8Q9rFFAfqOSOMUA3ULYGzoK0COaTXIGDAtN6
         l9EbjXOJD6kzk0oHnA3r+Rcr7pUT2A8UjA71qiSrb6TBi3a3AsSGeNPRh7/VyQPzdz3Z
         qCbVnBwrqdxcRm3fEEaWbSPF6D9t2bWlUMpgVFWZjGdDUUpYFYXp3rEQVGm09jP1dgb/
         23oXft6OtddnzsAm0xeWv6n7SfTCw72lfq6ZjVc738WaVMrtRDV8mSrhFhLbiI4xO679
         H4PA==
X-Gm-Message-State: AFqh2kpH4wsbO7eS5VE+D5AaXaDiiQl8tsd/T81qTz26Dqu09olaR/RB
        Ni9qGrKBGdxIXJwAJchY6KsSjAVkSzaJN9Bo6luudabIt2DAMw==
X-Google-Smtp-Source: AMrXdXsQa8utnUsqD22t1I9QPf8w1xe5MgoVU8oX8ahISk/mENTO351inWhuHHhlWgfPxnMC2n1I4/aD29VIHQ0FiRM=
X-Received: by 2002:a63:f047:0:b0:470:2c91:9579 with SMTP id
 s7-20020a63f047000000b004702c919579mr3115361pgj.22.1674632907990; Tue, 24 Jan
 2023 23:48:27 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2wa_ZTHUr9tH_6OSpr+TgNACo4kMu3eawsGV5qkCDoAKg@mail.gmail.com>
 <1F1F75F7-DAB2-4DCC-B366-E1AC45606816@joelfernandes.org>
In-Reply-To: <1F1F75F7-DAB2-4DCC-B366-E1AC45606816@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 25 Jan 2023 15:48:16 +0800
Message-ID: <CAABZP2z-cs64WuomHa0M1RnPmzp2Tha9sGdB6gc3z7ius1XR_Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] tick/nohz: Fix cpu_is_hotpluggable() by
 checking with nohz subsystem
To:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 25, 2023 at 2:58 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
>
>
> > On Jan 24, 2023, at 7:13 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > =EF=BB=BFOn Wed, Jan 25, 2023 at 6:56 AM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> >>
> >>> On Tue, Jan 24, 2023 at 05:31:26PM +0000, Joel Fernandes (Google) wro=
te:
> >>> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlin=
ed.
> >>> However, cpu_is_hotpluggable() still returns true for those CPUs. Thi=
s causes
> >>> torture tests that do offlining to end up trying to offline this CPU =
causing
> >>> test failures. Such failure happens on all architectures.
> >>>
> >>> Fix it by asking the opinion of the nohz subsystem on whether the CPU=
 can
> >>> be hotplugged.
> >>>
> >>> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_dow=
n(). ]
> >>>
> >>> For drivers/base/ portion:
> >>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>
> >>> Cc: Frederic Weisbecker <frederic@kernel.org>
> >>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >>> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Marc Zyngier <maz@kernel.org>
> >>> Cc: rcu <rcu@vger.kernel.org>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the =
rest of the kernel")
> >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>
> >> Queued for further review and testing, thank you both!
> >>
> >> It might be a few hours until it becomes publicly visible, but it will
> >> get there.
> > A new round of rcutorture test on fixed linux-5.15.y[3] has been
> > performed in the PPC VM of Open Source Lab of Oregon State University
> > [1], which will last about 29 hours. The test result on original
> > linux-5.15.y is at [2].
> >
> > [1] http://140.211.169.189/linux-stable-rc/tools/testing/selftests/rcut=
orture/res/2023.01.25-00.04.30-torture/
> > [2] http://140.211.169.189/linux-stable-rc/tools/testing/selftests/rcut=
orture/res/2023.01.18-13.22.39-torture/
> > [3] http://140.211.169.189/linux-stable-rc/
> >
> > Happy to benefit the community and this is a fruitful learning journey =
;-)
>
> Thanks a lot Zhouyi! After testing something your reply can also optional=
ly include:
>
> Tested-by: Zhouyi Zhou <zhouzhoui@gmail.com>
>
> Thanks.
I see. Thank Joel for your guidance and your encouragement ;-)
>
> Have fun at the university. I miss my university days.
Many thanks, I also miss my university days and days as a graduate
student [1], but I am no longer young ;-)
The open source Lab of Oregon State University lent me their VM hoping
to contribute to the open source
community, but I feel like being in university again while I am having
fun in the VM ;-)

[1] https://wiki.freebsd.org/ZhouyiZHOU

Have a nice day ;-)
Cheers
Zhouyi
>
>  - Joel
>
>
> >
> > Cheers
> > Zhouyi
> >>
> >>                                                        Thanx, Paul
> >>
> >>> ---
> >>> Sorry, resending with CC to stable.
> >>>
> >>> drivers/base/cpu.c       |  3 ++-
> >>> include/linux/tick.h     |  2 ++
> >>> kernel/time/tick-sched.c | 11 ++++++++---
> >>> 3 files changed, 12 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> >>> index 55405ebf23ab..450dca235a2f 100644
> >>> --- a/drivers/base/cpu.c
> >>> +++ b/drivers/base/cpu.c
> >>> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_att=
r_groups[] =3D {
> >>> bool cpu_is_hotpluggable(unsigned int cpu)
> >>> {
> >>>      struct device *dev =3D get_cpu_device(cpu);
> >>> -     return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> >>> +     return dev && container_of(dev, struct cpu, dev)->hotpluggable
> >>> +             && tick_nohz_cpu_hotpluggable(cpu);
> >>> }
> >>> EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
> >>>
> >>> diff --git a/include/linux/tick.h b/include/linux/tick.h
> >>> index bfd571f18cfd..9459fef5b857 100644
> >>> --- a/include/linux/tick.h
> >>> +++ b/include/linux/tick.h
> >>> @@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_=
struct *tsk,
> >>>                                   enum tick_dep_bits bit);
> >>> extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
> >>>                                     enum tick_dep_bits bit);
> >>> +extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
> >>>
> >>> /*
> >>>  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize o=
ff-cases
> >>> @@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(str=
uct cpumask *mask) { }
> >>>
> >>> static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits =
bit) { }
> >>> static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bit=
s bit) { }
> >>> +static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { re=
turn true; }
> >>>
> >>> static inline void tick_dep_set(enum tick_dep_bits bit) { }
> >>> static inline void tick_dep_clear(enum tick_dep_bits bit) { }
> >>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >>> index 9c6f661fb436..63e3e8ebcd64 100644
> >>> --- a/kernel/time/tick-sched.c
> >>> +++ b/kernel/time/tick-sched.c
> >>> @@ -510,7 +510,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cp=
umask)
> >>>      tick_nohz_full_running =3D true;
> >>> }
> >>>
> >>> -static int tick_nohz_cpu_down(unsigned int cpu)
> >>> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> >>> {
> >>>      /*
> >>>       * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> >>> @@ -518,8 +518,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
> >>>       * CPUs. It must remain online when nohz full is enabled.
> >>>       */
> >>>      if (tick_nohz_full_running && tick_do_timer_cpu =3D=3D cpu)
> >>> -             return -EBUSY;
> >>> -     return 0;
> >>> +             return false;
> >>> +     return true;
> >>> +}
> >>> +
> >>> +static int tick_nohz_cpu_down(unsigned int cpu)
> >>> +{
> >>> +     return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
> >>> }
> >>>
> >>> void __init tick_nohz_init(void)
> >>> --
> >>> 2.39.1.405.gd4c25cc71f-goog
> >>>
