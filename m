Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBEAC46466
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 23:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56E4206FA
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 23:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="saZdfCSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJBXPD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJBXPD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 19:15:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6BBC0613E3
        for <rcu@vger.kernel.org>; Fri,  2 Oct 2020 16:15:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u19so3309639ion.3
        for <rcu@vger.kernel.org>; Fri, 02 Oct 2020 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfdsfR+vxnsAijYLXa6tOfA8KqdB4WmlnZuQhX/Ct4U=;
        b=saZdfCSzMzpYeJMISnJ7OJgpgSkR3+dgqgr4x7aqFlkgmCFEB5WQMLMXbvty5IZrfL
         oGcm1OkS3ioUuJSCsT6K3mKOgLMbujc0eMb/GgU34MS2ynpi0gTY74sS2EGavQ4LW9sv
         hS7nfUFrE/cHESWXEEih7Al6VHHM86PkPAX/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfdsfR+vxnsAijYLXa6tOfA8KqdB4WmlnZuQhX/Ct4U=;
        b=elq9B7IiOyUiB/3gI1wofSuIY56zxWQ5DqiHNuvfLc2/UL2+A0LgH0MY8xbHd9siuJ
         gi1kT47//eNpgVVUVzQteRfiVi0Mo/daP1Ffws1vMdXxn5emPwNfXKg9YujfG1jNxymL
         ZfIp+rAOcdItRmuvz/4DJ8JxeHWzlS9dwTaueLYNA1D0Q9QPpmvP6Q7Q7rklvU7Hb3lQ
         o1VZ0crmEHsil3mh5xrZxpp+8b8ts+mAnOpgw/6+r9DcoKbzIQbXxC2+O2tXSnKyxYDd
         iUjtQGV625ym+8JKbthT9leHfDp0g5uUmu/o+0XCV1+b7oDBw8tpuoOhFIrhO7ur1LNX
         7SaA==
X-Gm-Message-State: AOAM530/gRXEvzgtgpb+k8yVMymb0Z0IdQyQ3ISxePVXfirYcqnBhRjD
        cj8pbsvgNmZYBc1SH/EP3la9WHsDDctEdyQMklb1bw==
X-Google-Smtp-Source: ABdhPJzI3tVlu8aSdAJm7W9AygkHAmLMflTi68aK8h4yRkfUXN/4nhsLC04yylzq/scPxqwON/RaPiy4CQkoxK+Fepw=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr3677082ior.154.1601680502289;
 Fri, 02 Oct 2020 16:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192928.3749502-1-joel@joelfernandes.org>
 <20200929192928.3749502-2-joel@joelfernandes.org> <20200929193248.GA3749988@google.com>
 <20201002193412.GJ29330@paulmck-ThinkPad-P72>
In-Reply-To: <20201002193412.GJ29330@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 2 Oct 2020 19:14:49 -0400
Message-ID: <CAEXW_YR=2K_E24k9BNXwEhuNCawaH8kQUPtMrx-xkmd+hjVzMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: Update RCU's hotplug requirements with a bit
 about design
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 2, 2020 at 3:34 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Sep 29, 2020 at 03:32:48PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> >
> > On Tue, Sep 29, 2020 at 03:29:28PM -0400, Joel Fernandes (Google) wrote:
> > > RCU's hotplug design will help understand the requirements an RCU
> > > implementation needs to fullfill, such as dead-lock avoidance.
> > >
> > > The rcu_barrier() section of the "Hotplug CPU" section already talks
> > > about deadlocks, however the description of what else can deadlock other
> > > than rcu_barrier is rather incomplete.
> > >
> > > This commit therefore continues the section by describing how RCU's
> > > design handles CPU hotplug in a deadlock-free way.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  .../RCU/Design/Requirements/Requirements.rst  | 30 +++++++++++++++++--
> > >  1 file changed, 28 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > index 1ae79a10a8de..e0413aa989dd 100644
> > > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > > @@ -1929,8 +1929,10 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> > >  to allow the various kernel subsystems (including RCU) to respond
> > >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> > >  be invoked from CPU-hotplug notifiers, including even synchronous
> > > -grace-period operations such as ``synchronize_rcu()`` and
> > > -``synchronize_rcu_expedited()``.
> > > +grace-period operations such as. However, the synchronous variants
> > > +(``synchronize_rcu()`` and ``synchronize_rcu_expedited()``) should not
> > > +from notifiers that execute via ``stop_machine()`` -- specifically those
> >
> > The "should not from notifiers" should be "should not be used from
> > notifiers" here. Sorry and hope you can fix it up.
>
> Thank you, and queued for further review.  How does the below look
> for a general fixup?

Looks great, thanks!

 -Joel



>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit a93716177eeac726037828b28e6b1a45e828688a
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Tue Sep 29 15:29:28 2020 -0400
>
>     docs: Update RCU's hotplug requirements with a bit about design
>
>     The rcu_barrier() section of the "Hotplug CPU" section discusses
>     deadlocks, however the description of deadlocks other than those involving
>     rcu_barrier() is rather incomplete.
>
>     This commit therefore continues the section by describing how RCU's
>     design handles CPU hotplug in a deadlock-free way.
>
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 1ae79a1..98557fe 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
>  to allow the various kernel subsystems (including RCU) to respond
>  appropriately to a given CPU-hotplug operation. Most RCU operations may
>  be invoked from CPU-hotplug notifiers, including even synchronous
> -grace-period operations such as ``synchronize_rcu()`` and
> -``synchronize_rcu_expedited()``.
> -
> -However, all-callback-wait operations such as ``rcu_barrier()`` are also
> -not supported, due to the fact that there are phases of CPU-hotplug
> -operations where the outgoing CPU's callbacks will not be invoked until
> -after the CPU-hotplug operation ends, which could also result in
> -deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
> -during its execution, which results in another type of deadlock when
> -invoked from a CPU-hotplug notifier.
> +grace-period operations such as (``synchronize_rcu()`` and
> +``synchronize_rcu_expedited()``).  However, these synchronous operations
> +do block and therefore cannot be invoked from notifiers that execute via
> +``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
> +and ``CPUHP_AP_ONLINE`` states.
> +
> +In addition, all-callback-wait operations such as ``rcu_barrier()`` may
> +not be invoked from any CPU-hotplug notifier.  This restriction is due
> +to the fact that there are phases of CPU-hotplug operations where the
> +outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
> +operation ends, which could also result in deadlock. Furthermore,
> +``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
> +which results in another type of deadlock when invoked from a CPU-hotplug
> +notifier.
> +
> +Finally, RCU must avoid deadlocks due to interaction between hotplug,
> +timers and grace period processing. It does so by maintaining its own set
> +of books that duplicate the centrally maintained ``cpu_online_mask``,
> +and also by reporting quiescent states explictly when a CPU goes
> +offline.  This explicit reporting of quiescent states avoids any need
> +for the force-quiescent-state loop (FQS) to report quiescent states for
> +offline CPUs.  However, as a debugging measure, the FQS loop does splat
> +if offline CPUs block an RCU grace period for too long.
> +
> +An offline CPU's quiescent state will be reported either:
> +1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
> +2.  When grace period initialization (``rcu_gp_init()``) detects a
> +    race either with CPU offlining or with a task unblocking on a leaf
> +    ``rcu_node`` structure whose CPUs are all offline.
> +
> +The CPU-online path (``rcu_cpu_starting()``) should never need to report
> +a quiescent state for an offline CPU.  However, as a debugging measure,
> +it does emit a warning if a quiescent state was not already reported
> +for that CPU.
> +
> +During the checking/modification of RCU's hotplug bookkeeping, the
> +corresponding CPU's leaf node lock is held. This avoids race conditions
> +between RCU's hotplug notifier hooks, the grace period initialization
> +code, and the FQS loop, all of which refer to or modify this bookkeeping.
>
>  Scheduler and RCU
>  ~~~~~~~~~~~~~~~~~
