Return-Path: <SRS0=JZbX=CN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27DC43461
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 20:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C33208C7
	for <rcu@archiver.kernel.org>; Fri,  4 Sep 2020 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599251840;
	bh=WADGPzwowjSTS+Hl7q5Jd1+4dvLF57LBIRyYHPWuYfk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yl+AQoKXyYT20TfZAxMC487cJtywrYAi4MAyUFlNUJkBPke9Pji5QhppJ6aO5wouF
	 Kkx/lGjvWdEGMsFLQ8sGInP62v8P/woJwMSzV6WeZZFJQZX9xNZoHdDGnqENp+8Apd
	 iI0c5Omn3xSXByS0QvmyBVbgcsqXQfhgKDAJHX/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgIDUhU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgIDUhT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Sep 2020 16:37:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC017208C7;
        Fri,  4 Sep 2020 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599251838;
        bh=WADGPzwowjSTS+Hl7q5Jd1+4dvLF57LBIRyYHPWuYfk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xnCb0MC1AZcT++NU7kOBTD6a3NBxzpNC9rRqjbDBdRLWAexeAWJRLPWOFPh2AGTvq
         e1JbOTZF3jVnJkHDUjJQqUuOhDal+edrJXjCzA7Xq/VEld7bWYh60mu4qUL8WScfyT
         6j7PpNHYea23eUKFGJIS92KGl7yoD3mvKqOEgi8s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D59D352162B; Fri,  4 Sep 2020 13:37:18 -0700 (PDT)
Date:   Fri, 4 Sep 2020 13:37:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Zhou <chao@eero.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: allow multiple stalls before panic
Message-ID: <20200904203718.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1598856077-58603-1-git-send-email-chao@eero.com>
 <20200904175007.GG29330@paulmck-ThinkPad-P72>
 <CAOr4Z-uwhX3LY=2x84da_uqAnX3dgpsgGSztQJLE6YEduCrR0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOr4Z-uwhX3LY=2x84da_uqAnX3dgpsgGSztQJLE6YEduCrR0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 04, 2020 at 12:40:29PM -0700, Chao Zhou wrote:
> Thanks Paul. Appreciated it.
> 
> Initial intent was to give users a way to make their system more
> tolerable, but prudent enough to recover if suspicious behavior
> reaches a watermark. If a system experiences multiple stalls in one
> lifetime, no matter how healthy it looks or whether the stalls are
> from different sources, we still want it to dramatically recover.
> Please share your guidance?

I have no guidance in this case.  I was just wanting to verify that the
patch was in fact doing what you want it to.  And it sounds like it does,
so good!

I have queued this for testing and further review.  If all goes well,
I would submit it upstream for the v5.11 merge window, that is, not the
upcoming merge window, but the one after that.

							Thanx, Paul

> eero inc.
> 
> 660 3rd St, 4th Floor
> 
> San Francisco, CA 94107
> 
> 
> 
> On Fri, Sep 4, 2020 at 11:05 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Aug 30, 2020 at 11:41:17PM -0700, chao wrote:
> > > Some stalls are transient and system can fully recover.
> > > Allow users to configure the number of stalls experienced
> > > to trigger kernel Panic.
> > >
> > > Signed-off-by: chao <chao@eero.com>
> >
> > Hearing no objections, I have queued this with wordsmithing as shown
> > below.  Please let me know if I messed something up.
> >
> > One question, though.  It looks like setting this to (say) 5 would panic
> > after the fifth RCU CPU stall warning message, regardless whether all
> > five were reporting the same RCU CPU stall event or whether they instead
> > were five widely separated transient RCU CPU stall events, where the
> > system fully recovered from each event.  Is this the intent?
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit e710c928fb52d8e56bc6173515805301da6aa22b
> > Author: chao <chao@eero.com>
> > Date:   Sun Aug 30 23:41:17 2020 -0700
> >
> >     rcu: Panic after fixed number of stalls
> >
> >     Some stalls are transient, so that system fully recovers.  This commit
> >     therefore allows users to configure the number of stalls that must happen
> >     in order to trigger kernel panic.
> >
> >     Signed-off-by: chao <chao@eero.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 500def6..fc2dd3f 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -536,6 +536,7 @@ extern int panic_on_warn;
> >  extern unsigned long panic_on_taint;
> >  extern bool panic_on_taint_nousertaint;
> >  extern int sysctl_panic_on_rcu_stall;
> > +extern int sysctl_max_rcu_stall_to_panic;
> >  extern int sysctl_panic_on_stackoverflow;
> >
> >  extern bool crash_kexec_post_notifiers;
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 0fde39b..228c55f 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -13,6 +13,7 @@
> >
> >  /* panic() on RCU Stall sysctl. */
> >  int sysctl_panic_on_rcu_stall __read_mostly;
> > +int sysctl_max_rcu_stall_to_panic __read_mostly;
> >
> >  #ifdef CONFIG_PROVE_RCU
> >  #define RCU_STALL_DELAY_DELTA          (5 * HZ)
> > @@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
> >  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> >  static void panic_on_rcu_stall(void)
> >  {
> > +       static int cpu_stall;
> > +
> > +       if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > +               return;
> > +
> >         if (sysctl_panic_on_rcu_stall)
> >                 panic("RCU Stall\n");
> >  }
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 287862f..1bca490 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2651,6 +2651,17 @@ static struct ctl_table kern_table[] = {
> >                 .extra2         = SYSCTL_ONE,
> >         },
> >  #endif
> > +#if defined(CONFIG_TREE_RCU)
> > +       {
> > +               .procname       = "max_rcu_stall_to_panic",
> > +               .data           = &sysctl_max_rcu_stall_to_panic,
> > +               .maxlen         = sizeof(sysctl_max_rcu_stall_to_panic),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec_minmax,
> > +               .extra1         = SYSCTL_ONE,
> > +               .extra2         = SYSCTL_INT_MAX,
> > +       },
> > +#endif
> >  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
> >         {
> >                 .procname       = "stack_erasing",
