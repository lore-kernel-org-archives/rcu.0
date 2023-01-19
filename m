Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F25C00A5A
	for <rcu@archiver.kernel.org>; Thu, 19 Jan 2023 04:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjASEaE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 23:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjASE24 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 23:28:56 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D26DB2E
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 20:26:57 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1442977d77dso1307044fac.6
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 20:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgTi3mRknr7ymI3bBx9syfIByuvDeFdd79v+DVZRfbk=;
        b=ZejmPqyBlA3ICPcNghQAUffbLNMHJMP1g5snXPAlVMKxdwRfrUNrgz4AzQFWjw5YHW
         bJg8tVHEGfzBcX7z0An6m/pBv1jqrl65wcyNcmnK+V+nQZ1KQtyT77fNPgH0tvc9jo7y
         BfuhRUIJKTlSkwUtohRBMRRQvUXfuEbMZV3AsMpn4uxBvDgxJkhxyUhrEtvp9hrnne6s
         Rv5TxenTMOPhJQRSuJHkkoJXpdVs1YIpMrBDPIdhP2Z7lfplM4RdEqw0N/vZ5ghQ9vP5
         snIcT4e6F3Tv94XlVCZ8GAEQtmqgWchrgrGtT9CemaZkIUqhE9P05TeF+U+t8KRV32Z+
         Y3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgTi3mRknr7ymI3bBx9syfIByuvDeFdd79v+DVZRfbk=;
        b=rg7CblmCRdpa0uakMkdslYh67M1sGn/5UXhmCZb1sQS13+GbgAgCZvbxTG/SGBk1AM
         RXWyf132sWvpl18L0z22ELTJ0GqOQQR+I2Qw+1PoMuCMOHXm44FrcSDOu07XnGN2GTIZ
         OO1iiIm0USkEN//rouxT+crLSGgtMWaQBpk2gztG/y+fIbC/Bh8pJTCoad3ENE5WFv48
         z7ykAwvZM1DtG5kGRxIf/z9xzHoQVAww3qSnsRI5QEB5nWma2xdIYeMaGrjJxXbxS0qO
         OW8fvorpiWwznX14F84zSckvFHboNm0wRLieZBp0LTGGW5jFAZOctHr3IquwWI710HO+
         3swg==
X-Gm-Message-State: AFqh2kqK/imnYXni/LDHYTX5YpdeybcayfvJSqAxkXbWc40cJ97ecbBd
        hs4ogde/Pxe9ylsj6JqSBOTRzCaVMlgH0CKUi8Mf7CLBmow=
X-Google-Smtp-Source: AMrXdXshFQr+kvrk2elGe3wLBDfg0nIMTXtBW2kNSXDJqrKVLwL5dNh+5kXN//jj6qi/ZiaG4EuAbrNv8LpPP2u8lAU=
X-Received: by 2002:a17:90b:f0a:b0:229:55bb:e575 with SMTP id
 br10-20020a17090b0f0a00b0022955bbe575mr857948pjb.144.1674098512590; Wed, 18
 Jan 2023 19:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org> <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1> <Y8h0lDnQ9Z0VtXfV@google.com>
 <CAEXW_YTscMEtrMXK7nAGdey+EK0+voL6Fvd1Qrdq2stR2wUZPg@mail.gmail.com>
In-Reply-To: <CAEXW_YTscMEtrMXK7nAGdey+EK0+voL6Fvd1Qrdq2stR2wUZPg@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 19 Jan 2023 11:21:41 +0800
Message-ID: <CAABZP2xq5tCbXiOaH92X1F885FANX70p=H0nHg5P7BkjcYy+yQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 19, 2023 at 6:39 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Jan 18, 2023 at 10:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> > [...]
> > > > > > > Is there a plan to make CPU hotplug failures more frequent?
> > > > > >
> > > > > > I am not aware of such a plan but I was going by "There are quite some
> > > > > > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > > > > > not a fatal problem, really." in [1].
> > > > > >
> > > > > > What about an rcutorture to skip hotplug for a certain cpu id,
> > > > > > rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> > > > > > should debug this issue more before getting to that.
> > > > >
> > > > > Yes, in fact there already are some checks along those lines, for example,
> > > > > the torture_offline() function's check of cpu_is_hotpluggable().  So for
> > > > > example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
> > > > > the housekeeping CPU as !cpu_is_hotpluggable().
> > > >
> > > > I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
> > > > not seeing it). Even on x86, if you enable
> > > > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y , and CONFIG_NO_HZ_FULL=y, and run
> > > > rcutorture with boot args:
> > > >
> > > > nohz_full=0-3 rcutorture.onoff_interval=100 rcutorture.onoff_holdoff=2
> > > > rcutorture.shutdown_secs=30
> > > >
> > > > You will see this in the kernel logs:
> > > > [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >
> > > > So RCU torture test clearly thought the CPUs were hot-pluggable, when
> > > > they was chance for them to return -EBUSY (due to housekeeping and
> > > > what not). So this issue seems to be architecture independent, in that
> > > > sense.
> > > >
> > > > So the 2 ways forward I see are:
> > > > - Make the torture test aware of which CPUs are 'house keeping'
> > > > - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> > > > (via CONFIG or boot option).
> > > >
> > > > Another option could be, forgive -EBUSY on CPU0 for
> > > > CONFIG_NO_HZ_FULL=y.  Is it possible to assign a non-0 CPU id as a
> > > > housekeeping CPU?
> > >
> > > I would be happier to forgive failure to offline housekeeping CPUs than
> > > blanket forgiveness of CPU 0.  Especially given that I recently got
> > > burned by a non-zero boot cpu.  ;-)
> > >
> > > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > > NO_HZ_FULL rules of the road?
> >
> > That's a great idea. I found a way to do that without having to do the
> > EXPORT_SYMBOL (like in Zhouyi's patch).
> >
> > Would the following be acceptable (only build-tested)?
> >
> > I can run more tests and submit a patch:
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 55405ebf23ab..f73bc520b70e 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
> >  bool cpu_is_hotpluggable(unsigned int cpu)
> >  {
> >         struct device *dev = get_cpu_device(cpu);
> > -       return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> > +       return dev && container_of(dev, struct cpu, dev)->hotpluggable
> > +               && !tick_nohz_cpu_hotpluggable(cpu);
>
> Oops, I should lose that "!" , but otherwise should be ok.
Looks plausible to me, According to your fantastic fix, I will perform
a new round of tests on the PPC VM of open source Lab of Oregon State
University.

I learned a lot during this process

Thanks
Zhouyi
