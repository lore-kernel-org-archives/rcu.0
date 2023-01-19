Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB84C00A5A
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 12:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjASMSq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Jan 2023 07:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjASMSR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Jan 2023 07:18:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7A78A89
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 04:17:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i1so1341140pfk.3
        for <rcu@vger.kernel.org>; Thu, 19 Jan 2023 04:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZA9qjs3USlgzsNjJLnVsbCRmYp2U4skNH7eHsMkxRdg=;
        b=Snt5hmFATv/NKagpYsihk4x9SbvC0FAG0v3sqy+MLjASl1fo/buiR3uJlibSAKRmKy
         i12bKqX/++jxnTa3NizIZj0oKa9ppwU4MOmdpcDihiABNUyXShLpqbl0/p+ZrU3Fards
         hVM6VEfmd3ep8fFXfLEHwUPw2dNK9DuBP/cL6gv1bvM/mt893caTwHYFTf59H5a6s+Ng
         PUQw9NfRISChRsdZkYXrjcSZP+skNb6gvoHzv7Q0V1cD0OeFKcvA0KDzd/ljmPswPvgY
         BSHFxzFwgMjZakQFOHRlZN/BDf0zBKkMD0Usms3HRBUsKHLGx5xRGgwNpMATZHd2/1p1
         /BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZA9qjs3USlgzsNjJLnVsbCRmYp2U4skNH7eHsMkxRdg=;
        b=BEyAlHxun4omWbUqMA4aWjQ8L8KjI+YU7EqnAJz+eTFs/tp4SRLvhX+DSKC+fXfhWy
         z2/3joTm4VmX39cm6sUaXrkivJD4svyk/qHp1HJuaIrDl94v7DlMBH8gSerSJnPZ7iQi
         s96mZnEnAbqff/gL+NYRV/21Rq70EXKDpSQyWPy1iVHThY7CX+QJBeUKYwMssCsKQ7ha
         pxIWfX03TebMZsNnw96+91/oHz3C+oPa7hmpUkDmxxy1lxVdyst1+pXliXvBFYftAF33
         A1es8zh4S7g2I8zkz8iAA+CeoEEoRIx8FSLDVvEH+IO55+ykevd8LJV3WdkQwF62QY0+
         1ZqA==
X-Gm-Message-State: AFqh2krxxVL3lURTXw+Z5CS+OZZKYG5prSbPyblMypkYacm/bmXzcChh
        KxR3zYO9KS3hpapLBSQ3GFqpHeIHVAXpvMWNVq0=
X-Google-Smtp-Source: AMrXdXt7wK/pygPA2zE7o+pQ2wlRtHjuO+kslgds/03Zlh2TaiPdNmNMwVfWq2oqP+DQVdlDkPZDLlpcw6t1izYjQyA=
X-Received: by 2002:a62:e319:0:b0:580:c254:b230 with SMTP id
 g25-20020a62e319000000b00580c254b230mr1065512pfh.18.1674130674384; Thu, 19
 Jan 2023 04:17:54 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2xq5tCbXiOaH92X1F885FANX70p=H0nHg5P7BkjcYy+yQ@mail.gmail.com>
 <72EAFF5B-CE11-4672-BBFF-48B0E8A7F70D@joelfernandes.org>
In-Reply-To: <72EAFF5B-CE11-4672-BBFF-48B0E8A7F70D@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 19 Jan 2023 20:17:43 +0800
Message-ID: <CAABZP2wyRexauzY9G7OJWJjqdnm3x0PcqQe8jr_YWOm+ax=FUw@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 19, 2023 at 4:26 PM Joel Fernandes <joel@joelfernandes.org> wro=
te:
>
>
>
> > On Jan 18, 2023, at 10:21 PM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > =EF=BB=BFOn Thu, Jan 19, 2023 at 6:39 AM Joel Fernandes <joel@joelferna=
ndes.org> wrote:
> >>
> >>> On Wed, Jan 18, 2023 at 10:37 PM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
> >>>
> >>>> On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> >>> [...]
> >>>>>>>> Is there a plan to make CPU hotplug failures more frequent?
> >>>>>>>
> >>>>>>> I am not aware of such a plan but I was going by "There are quite=
 some
> >>>>>>> reasons why a CPU-hotplug or a hot-unplug operation can fail, whi=
ch is
> >>>>>>> not a fatal problem, really." in [1].
> >>>>>>>
> >>>>>>> What about an rcutorture to skip hotplug for a certain cpu id,
> >>>>>>> rcutorture.skip_hotplug_cpus=3D"0". Can be a last resort. But we/=
I
> >>>>>>> should debug this issue more before getting to that.
> >>>>>>
> >>>>>> Yes, in fact there already are some checks along those lines, for =
example,
> >>>>>> the torture_offline() function's check of cpu_is_hotpluggable().  =
So for
> >>>>>> example, as I understand it, a CONFIG_NO_HZ_FULL=3Dy system should=
 mark
> >>>>>> the housekeeping CPU as !cpu_is_hotpluggable().
> >>>>>
> >>>>> I don't think CONFIG_NO_HZ_FULL does any such marking (at least I a=
m
> >>>>> not seeing it). Even on x86, if you enable
> >>>>> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy , and CONFIG_NO_HZ_FULL=3Dy, and =
run
> >>>>> rcutorture with boot args:
> >>>>>
> >>>>> nohz_full=3D0-3 rcutorture.onoff_interval=3D100 rcutorture.onoff_ho=
ldoff=3D2
> >>>>> rcutorture.shutdown_secs=3D30
> >>>>>
> >>>>> You will see this in the kernel logs:
> >>>>> [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: er=
rno -16
> >>>>> [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: er=
rno -16
> >>>>>
> >>>>> So RCU torture test clearly thought the CPUs were hot-pluggable, wh=
en
> >>>>> they was chance for them to return -EBUSY (due to housekeeping and
> >>>>> what not). So this issue seems to be architecture independent, in t=
hat
> >>>>> sense.
> >>>>>
> >>>>> So the 2 ways forward I see are:
> >>>>> - Make the torture test aware of which CPUs are 'house keeping'
> >>>>> - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> >>>>> (via CONFIG or boot option).
> >>>>>
> >>>>> Another option could be, forgive -EBUSY on CPU0 for
> >>>>> CONFIG_NO_HZ_FULL=3Dy.  Is it possible to assign a non-0 CPU id as =
a
> >>>>> housekeeping CPU?
> >>>>
> >>>> I would be happier to forgive failure to offline housekeeping CPUs t=
han
> >>>> blanket forgiveness of CPU 0.  Especially given that I recently got
> >>>> burned by a non-zero boot cpu.  ;-)
> >>>>
> >>>> But wouldn't it be even better for cpu_is_hotpluggable() to know the
> >>>> NO_HZ_FULL rules of the road?
> >>>
> >>> That's a great idea. I found a way to do that without having to do th=
e
> >>> EXPORT_SYMBOL (like in Zhouyi's patch).
> >>>
> >>> Would the following be acceptable (only build-tested)?
> >>>
> >>> I can run more tests and submit a patch:
> >>>
> >>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> >>> index 55405ebf23ab..f73bc520b70e 100644
> >>> --- a/drivers/base/cpu.c
> >>> +++ b/drivers/base/cpu.c
> >>> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_att=
r_groups[] =3D {
> >>> bool cpu_is_hotpluggable(unsigned int cpu)
> >>> {
> >>>        struct device *dev =3D get_cpu_device(cpu);
> >>> -       return dev && container_of(dev, struct cpu, dev)->hotpluggabl=
e;
> >>> +       return dev && container_of(dev, struct cpu, dev)->hotpluggabl=
e
> >>> +               && !tick_nohz_cpu_hotpluggable(cpu);
> >>
> >> Oops, I should lose that "!" , but otherwise should be ok.
> > Looks plausible to me, According to your fantastic fix, I will perform
> > a new round of tests on the PPC VM of open source Lab of Oregon State
> > University.
>
> Thank you! And if it passes, I will add your Tested-by tag for attributio=
n if you do not mind.
Thank you very much in advance for giving me a Tested-by, I like it
very much ;-)
After patching 8e82c28ea2b4(torture: Make thread detection more robust
by using lspcu) to linux-5.15.y on PPC64 VM,
I can proceed with the torturing test now.

The test performed on original linux-5.15.y still needs an hour or two
to finish, after
that I can apply your fix, and perform another 20+ hours torturing
test (it is a little slow because it is on a virtual machine). Thank
you for your patience.

Cheers
Zhouyi
>
> > I learned a lot during this process
>
> Cool!!
>
>  - Joel
>
>
> >
> > Thanks
> > Zhouyi
