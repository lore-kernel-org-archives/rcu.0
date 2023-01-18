Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E109DC32793
	for <rcu@archiver.kernel.org>; Wed, 18 Jan 2023 22:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjARWjn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjARWjm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Jan 2023 17:39:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899354B0C
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:39:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so568307lfr.3
        for <rcu@vger.kernel.org>; Wed, 18 Jan 2023 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hnZf+MwiEk7hz021WqhtQTN43XvoYCpKI3aCIWGTew=;
        b=H8W5Sgq3sGX4tM8pvFUlasiKcnhHumnDWibXiJrrKCQGUysnwZg/Ulap3siecO1LXB
         VN1zfS5Js46gLDQ8GfsteLxk5JQh3aUXxpR3DhRzwT7ez2tcpY88qfncb585aBmx8BFX
         NTjfXYv9v9NCtGtZvQraMYuW/JWihe1pUxBUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hnZf+MwiEk7hz021WqhtQTN43XvoYCpKI3aCIWGTew=;
        b=lbmR9gaPogW+bM5pSsHR25YJL/2iV+M0nqWSVNzKow3KeunfPf/iU6j59shrWoCpXT
         baMHvdENQww3HXk6FPlwz2s68gVPOntFN//Dx/IZ1Ul9fWLGtyDOnnU6KdIdnPvgK27e
         CLtw/cOhzjOUqHRV6LfDPfkHpz9xQi55TRBsGnql5OWZr9CAKEQYKqZj2up6Q8DY23tk
         kctIE1ikW9coSoYQ9SF+wIZ47peIHr9ipdp99BYIBL67ESteQiL0eiY6M5dvP2d6dwDl
         ZUgE/CPmp5eeq8zI5BNL++GfRZjpLZs3L5r2spa7EocijulxFfTSQjpawRBeKGtgWXJg
         /ctA==
X-Gm-Message-State: AFqh2kotfEiAl7ham7AA2UzmGjpLoQ4DuRSB2iMCNDR+BbJ4BNhIXeWq
        yT37br7lh0nNVSEnfuKf60arTC3Ya+AuETdwwey9jQ==
X-Google-Smtp-Source: AMrXdXs0ICeqBXCKaTsDt4cRnu178MkwymnmGAPytKIwDUR1m+Hmcs+hXveEAZaqKoHNZHqHnMfjwmRzzC1Fl697+Dg=
X-Received: by 2002:ac2:5924:0:b0:4ca:fa1b:ebc7 with SMTP id
 v4-20020ac25924000000b004cafa1bebc7mr442113lfi.169.1674081579900; Wed, 18 Jan
 2023 14:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <24953EEA-5B3E-4046-B106-7A7FBE8B8995@joelfernandes.org> <20230117045456.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTeR7y5TjYPFiZ_RbzOBCk0p-2J-Gga2uHuMr020jL0vQ@mail.gmail.com>
 <20230117204231.GP2948950@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YTtY5WNLJ4p9ggso7L38rtiCFEq2aLCwYUkQ2ckBnEsSA@mail.gmail.com>
 <20230118040058.GV2948950@paulmck-ThinkPad-P17-Gen-1> <Y8h0lDnQ9Z0VtXfV@google.com>
In-Reply-To: <Y8h0lDnQ9Z0VtXfV@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Jan 2023 22:39:28 +0000
Message-ID: <CAEXW_YTscMEtrMXK7nAGdey+EK0+voL6Fvd1Qrdq2stR2wUZPg@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
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

On Wed, Jan 18, 2023 at 10:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Jan 17, 2023 at 08:00:58PM -0800, Paul E. McKenney wrote:
> [...]
> > > > > > Is there a plan to make CPU hotplug failures more frequent?
> > > > >
> > > > > I am not aware of such a plan but I was going by "There are quite some
> > > > > reasons why a CPU-hotplug or a hot-unplug operation can fail, which is
> > > > > not a fatal problem, really." in [1].
> > > > >
> > > > > What about an rcutorture to skip hotplug for a certain cpu id,
> > > > > rcutorture.skip_hotplug_cpus="0". Can be a last resort. But we/I
> > > > > should debug this issue more before getting to that.
> > > >
> > > > Yes, in fact there already are some checks along those lines, for example,
> > > > the torture_offline() function's check of cpu_is_hotpluggable().  So for
> > > > example, as I understand it, a CONFIG_NO_HZ_FULL=y system should mark
> > > > the housekeeping CPU as !cpu_is_hotpluggable().
> > >
> > > I don't think CONFIG_NO_HZ_FULL does any such marking (at least I am
> > > not seeing it). Even on x86, if you enable
> > > CONFIG_BOOTPARAM_HOTPLUG_CPU0=y , and CONFIG_NO_HZ_FULL=y, and run
> > > rcutorture with boot args:
> > >
> > > nohz_full=0-3 rcutorture.onoff_interval=100 rcutorture.onoff_holdoff=2
> > > rcutorture.shutdown_secs=30
> > >
> > > You will see this in the kernel logs:
> > > [    2.816022] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > [    2.975913] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > >
> > > So RCU torture test clearly thought the CPUs were hot-pluggable, when
> > > they was chance for them to return -EBUSY (due to housekeeping and
> > > what not). So this issue seems to be architecture independent, in that
> > > sense.
> > >
> > > So the 2 ways forward I see are:
> > > - Make the torture test aware of which CPUs are 'house keeping'
> > > - Make it possible to turn off CPU0 hotplugging on ARM64 by default
> > > (via CONFIG or boot option).
> > >
> > > Another option could be, forgive -EBUSY on CPU0 for
> > > CONFIG_NO_HZ_FULL=y.  Is it possible to assign a non-0 CPU id as a
> > > housekeeping CPU?
> >
> > I would be happier to forgive failure to offline housekeeping CPUs than
> > blanket forgiveness of CPU 0.  Especially given that I recently got
> > burned by a non-zero boot cpu.  ;-)
> >
> > But wouldn't it be even better for cpu_is_hotpluggable() to know the
> > NO_HZ_FULL rules of the road?
>
> That's a great idea. I found a way to do that without having to do the
> EXPORT_SYMBOL (like in Zhouyi's patch).
>
> Would the following be acceptable (only build-tested)?
>
> I can run more tests and submit a patch:
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 55405ebf23ab..f73bc520b70e 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
>  bool cpu_is_hotpluggable(unsigned int cpu)
>  {
>         struct device *dev = get_cpu_device(cpu);
> -       return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> +       return dev && container_of(dev, struct cpu, dev)->hotpluggable
> +               && !tick_nohz_cpu_hotpluggable(cpu);

Oops, I should lose that "!" , but otherwise should be ok.
