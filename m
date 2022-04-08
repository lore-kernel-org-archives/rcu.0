Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F331C433FE
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiDHRWT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDHRWS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 13:22:18 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425F10709F
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 10:20:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h63so11365283iof.12
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap3imm5PObX8OjFwHiIq7wbaVhzckxpuYj3ptqq60vU=;
        b=UHfQeD1lAhbtCeKgODYSJwUtX5auhDWffFb658RRF9FBEG0q8T22o2gnveOVKsicw8
         WPPubOCK3XBImjGPd2oXbXzmrv//eSoK6K+C33aybOXhaYYBgnPsHrNbf7BaGA88Onnz
         ZQNYOORMnV0l6+5mPh1/MfHdNERrz9SgOPaz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap3imm5PObX8OjFwHiIq7wbaVhzckxpuYj3ptqq60vU=;
        b=Y7fVxhkKu3W+B7DumaRs9vqT2uQxd4op5n06UydZ24Stpv98pCtHhi0n17Wl9+2HA9
         T7cWvH3LAOSeA+rdy6I7+Rp+2uEpAiW6AbQ4T05pbGhB5MkMQZFPSaWfxrq1CzD1SbvU
         zsn6WybvNNq9dg5o7uDW9n1vaG6zxPUGWJkMylktNLs2jIo4P9m+XDdXZ10a5pjKmhEu
         Yykjkfz2qYACm3/IH+8E1Iqa8upQa/VEsnQXRZg9o2P8PP6Qs6Za0xTz2BG83K1pNMeW
         aorFxgDWDRFBdiPFU6HDuRgCX4+A70QptLXZsygJXlNrj5Al2scHdHv4ON1/Zvulvo2I
         LV8A==
X-Gm-Message-State: AOAM532Ni2GgLn7YLwrNeqSPeP1rqKzTI1sADNnebPEDbqRQ2ttxkKPR
        Ud6c6KxbBJDv9LdxgEHvRv3xdalJzU4nI9BcBnv2+Q==
X-Google-Smtp-Source: ABdhPJwSKMj/cXiIp4ghHfKmz6M7gvuI55nrfQzJ50c1hNzfslGXmGEkmDdAfPwq9YV2BrL4R+7XwysmOAj5/jCxK9k=
X-Received: by 2002:a05:6638:223:b0:326:22:e1c5 with SMTP id
 f3-20020a056638022300b003260022e1c5mr1367996jaq.259.1649438413882; Fri, 08
 Apr 2022 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 13:20:02 -0400
Message-ID: <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 11:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Apr 08, 2022 at 10:52:21AM -0400, Joel Fernandes wrote:
> > On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > > > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > > > which ends up not offloading any CPU. This patch removes yet another
> > > > dependency from the bootloader having to know about RCU, about how many
> > > > CPUs the system has, and about how to provide the mask. Basically, I
> > > > think we should stop pretending that the user knows what they are doing :).
> > > > In other words, if NO_CB_CPU is enabled, lets make use of it.
> > > >
> > > > My goal is to make RCU as zero-config as possible with sane defaults. If
> > > > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > > > take precedence and this patch will have no effect.
> > > >
> > > > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
> > >
> > > Unless something has changed, this would change behavior relied upon
> > > the enterprise distros.  Last I checked, they want to supply a single
> > > binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> > > and they also want the default to be non-offloaded.  That is, given a
> > > kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> > > or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.
> >
> > Just curious, do you have information (like data, experiment results)
> > on why they want default non-offloaded? Or maybe they haven't tried
> > the recent work done in NOCB code?
>
> I most definitely do.  When I first introduced callback offloading, I
> made it completely replace softirq callback invocation.  There were some
> important throughput-oriented workloads that got hit with significant
> performance degradation due to this change.  Enterprise Java workloads
> were the worst hit.
>
> Android does not run these workloads, and I am not aware of ChromeOS
> running them, either.

Thanks a lot for mentioning this, I was not aware and will make note
of it :-). I wonder if the scheduler had something to do with the
degradation.

> > Another option I think is to make it enforce NOCB if NR_CPUS <= 32 if
> > that makes sense.
>
> That would avoid hurting RHEL and SLES users, so this would be better
> than making the change unconditionally.  But there are a lot of distros
> out there.
>
> I have to ask...  Isn't there already a way of specifying a set of kernel
> boot parameters that are required for ChromeOS?  If so, add rcu_nocbs=0-N
> to that list and be happy.

Yes, that's doable.

> > > And is it really all -that- hard to specify an additional boot parameter
> > > across ChromeOS devices?  Android seems to manage it.  ;-)
> >
> > That's not the hard part I think. The hard part is to make sure a
> > future Linux user who is not an RCU expert does not forget to turn it
> > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > ;-D. AFAIR, there were Android devices too in the past where I saw
> > this forgotten. I don't think we should rely on the users doing the
> > right thing (as much as possible).
> >
> > The single kernel binary point makes sense but in this case, I think
> > the bigger question that I'd have is what is the default behavior and
> > what do *most* users of RCU want. So we can keep sane defaults for the
> > majority and reduce human errors related to configuration.
>
> If both the ChromeOS and Android guys need it, I could reinstate the
> old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> and Android movers and shakers would overcome lingering objections.
>
> Would that help?

Yes, I think I would love for such a change. I am planning to add a
test to ChromeOS to check whether config options were correctly set
up. So I can test for both the RCU_NOCB_CPU options.

Thanks!

- Joel
