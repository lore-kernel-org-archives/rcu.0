Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DAC4332F
	for <rcu@archiver.kernel.org>; Wed, 12 Oct 2022 19:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJLTyl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJLTyi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Oct 2022 15:54:38 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B7190
        for <rcu@vger.kernel.org>; Wed, 12 Oct 2022 12:54:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id u10so9317235ilm.5
        for <rcu@vger.kernel.org>; Wed, 12 Oct 2022 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIZK921kgx58UdIyVC5ayIJBJbNqULB9uu6tsSeumyA=;
        b=JGZDcUzJP7GvU3lcTwaBlSH0DdoDDbn3M6ccuZ2yUn3bHouMHUlk/eP0MaDhqbE4xO
         zXdJPa/5SOiFHfks0kXR0CwvF5mIzznqToOT55cjbD2Pu3g8zO6H+J5V7L5NBbONPbfZ
         fd4/vy8qzCEoetISe+lXuv4T4jna282pgC8UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIZK921kgx58UdIyVC5ayIJBJbNqULB9uu6tsSeumyA=;
        b=YAJC8Db50ckZ9GRit3YD18MywexkUJM/52G6OnymP7ppA+3P+5RxRgXOutAReeHzXo
         T6xYESxYCk9TTtwfg4NngiLmQfGPr7wVLQ7c1q01FDwRij7YsgYMey87grZ53vogJ+t0
         th9360nfcy77Bxx9Yr8PROEY4QtVX2cNkcEtz+IfiM4SBXINyNQbDVsKml62FoK7tO5X
         eYJCHEWnwGYx5UYGN/VCNUO2mJNbbBZZmN05kvPFeo2ymO3kj8DfWOOtp2PvCaRvGzeH
         y/12qHstKOtBcfiUNQinM8hrNx7p6TGAIJKQ8Q8Lo6bBjwPvQxeIr3atBF1W2F3DhXuo
         EeNw==
X-Gm-Message-State: ACrzQf3PWbfU0L0dE8yJucUJC+7AfynIgSepmuFvoe7mLNDiY9d9cco0
        +f8ljhw9/0dCaZJ9cEMiPtkYpsd9gX5N8KDa7GUK2w==
X-Google-Smtp-Source: AMsMyM54rwa+Cp1yIX8hwMtKzNITA9Rk1ufq2G5CcQCpwUxNxjtG5QHDz6FvStyqJctn6j7lFDS7wsw95fA2PpTDcx0=
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id
 p6-20020a92d686000000b002fa62266247mr15896122iln.79.1665604475795; Wed, 12
 Oct 2022 12:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-3-joel@joelfernandes.org> <20221011231053.GA1052831@lothringen>
In-Reply-To: <20221011231053.GA1052831@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 12 Oct 2022 15:54:25 -0400
Message-ID: <CAEXW_YSsEQ8krr9ckCOmO1B=C+Oy+8j_BtetQeNu1McH5nSuQg@mail.gmail.com>
Subject: Re: [PATCH v8 02/13] rcu: Make call_rcu() lazy to save power
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 11, 2022 at 7:10 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Tue, Oct 11, 2022 at 06:01:31PM +0000, Joel Fernandes (Google) wrote:
> > @@ -269,10 +294,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >       raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> >
> >       /*
> > -      * Bypass wakeup overrides previous deferments. In case
> > -      * of callback storm, no need to wake up too early.
> > +      * Bypass wakeup overrides previous deferments. In case of
> > +      * callback storm, no need to wake up too early.
> >        */
> > -     if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > +     if (waketype == RCU_NOCB_WAKE_LAZY &&
> > +         READ_ONCE(rdp->nocb_defer_wakeup) == RCU_NOCB_WAKE_NOT) {
>
> No need for READ_ONCE() here.
>
> > +             mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
> > +             WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > +     } else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> >               mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> >               WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> >       } else {
> > @@ -611,6 +682,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >       unsigned long flags;
> >       bool gotcbs = false;
> >       unsigned long j = jiffies;
> > +     bool lazy = false;
> > +     long lazy_ncbs;
>
> Looks like lazy_ncbs can be declared withing the loop, as well as bypass_cbs.
>
> Anyway, apart from such boring cosmectics:
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks, I folded the cosmetic suggestions with the Ack and pushed it to:
https://github.com/joelagnel/linux-kernel.git (branch rcu-next-oct.12.22)

thanks,

 - Joel
