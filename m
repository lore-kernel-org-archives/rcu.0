Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32617C38142
	for <rcu@archiver.kernel.org>; Mon, 23 Jan 2023 15:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjAWPAa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAWPA3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Jan 2023 10:00:29 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B810A97
        for <rcu@vger.kernel.org>; Mon, 23 Jan 2023 07:00:28 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id by7so12384552ljb.6
        for <rcu@vger.kernel.org>; Mon, 23 Jan 2023 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8OXVqqET23d8P8R69qpaJVVVA99GrD94+chyNKQDIY=;
        b=wyBkSw2oPqo3G89B6ZpS2kEB1NDROP8LQlyni5F4RpasuOn7ATjRDwOnQ/i0ifmrh8
         0hyonsnEs+u3CfpCEJDc1IWqnJvfscPHLtZFAMb+dLt4TJl3Mc017hre7Oa/bu7ROPeh
         qTOaGqp0MLJtXa2qJDQImzc47OCmFxCU1nywE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8OXVqqET23d8P8R69qpaJVVVA99GrD94+chyNKQDIY=;
        b=gNWp+0bBXidS4p+t1NE7d2+ZHjEZ69v4wyO1+Fr8Tn3GqpuNPs9a2903U05xKxp/nN
         ISpIj8mYYX7AwGd7WWugpiqqpC4FDrfhpHq4FlMVzg+0ToOVgKqLTThqHONs2b3S+gDp
         lDKqkPLkhCFlduOXuMQFD3ajbd2xZnfYnjloxUCxw29MlO8Ym9PksHSMOAxmb1+cBCam
         Umy2jnR6s5wvD5uNCq5YHn0rhIdEB7jVOK+eXdtBRGzaHe2XXXkhHG7atq0Dl2PevTc2
         wpzWbGVXUOTZtrsrwWmSv1CfCRk+e4/pi3EY4JHeOONteUWXIUPkqg3JoB0UX1vHk56k
         PAVA==
X-Gm-Message-State: AFqh2kpLwAJACQ3ZBT45kBtlcL/Gi5eAe0qQV96L2gmgHJ+o4Uvmts0b
        MTB5mdkEG0HywfdhssOYw8rLp5SY43YLyWOgkio3GA==
X-Google-Smtp-Source: AMrXdXsi5MJ1MrfqUVaqrdEIvyJFulxZgssUqiHKkQAorIqz+ie5vwCbCXeEE3EJ5JwW2PdapQf9fQPo4xyOg21yUv4=
X-Received: by 2002:a2e:a485:0:b0:27f:bb8b:7520 with SMTP id
 h5-20020a2ea485000000b0027fbb8b7520mr2155168lji.371.1674486026590; Mon, 23
 Jan 2023 07:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230119204434.4017605-1-joel@joelfernandes.org> <Y8sU5ADeKpow5aUY@lothringen>
In-Reply-To: <Y8sU5ADeKpow5aUY@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 23 Jan 2023 10:00:14 -0500
Message-ID: <CAEXW_YSN66Ac1i5-4oanbRERc0C3hRD=3dnQNy6CtgCFTzvD0w@mail.gmail.com>
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with
 nohz subsystem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 20, 2023 at 5:25 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 08:44:35PM +0000, Joel Fernandes (Google) wrote:
> > -static int tick_nohz_cpu_down(unsigned int cpu)
> > +static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
> >  {
> >       /*
> >        * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> > @@ -522,6 +522,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
> >       return 0;
> >  }
> >
> > +static int tick_nohz_cpu_down(unsigned int cpu)
> > +{
> > +     return tick_nohz_cpu_hotplug_ret(cpu);
> > +}
> > +
> > +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> > +{
> > +     return tick_nohz_cpu_hotplug_ret(cpu) == 0;
>
> This is still calling the hotplug function for the CPU in order to know if the
> CPU is hotpluggable...
>
> Why not:
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index ba2ac1469d47..a46506f7ec6d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -532,7 +532,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>         tick_nohz_full_running = true;
>  }
>
> -static int tick_nohz_cpu_down(unsigned int cpu)
> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
>  {
>         /*
>          * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> @@ -540,8 +540,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
>          * CPUs. It must remain online when nohz full is enabled.
>          */
>         if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
> -               return -EBUSY;
> -       return 0;
> +               return false;
> +       return true;
> +}
> +
> +static int tick_nohz_cpu_down(unsigned int cpu)
> +{
> +       return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
>  }
>

Yes, this looks better. I will do it this way. Thanks!

 - Joel
