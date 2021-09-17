Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19CFC433F5
	for <rcu@archiver.kernel.org>; Fri, 17 Sep 2021 18:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B13A61029
	for <rcu@archiver.kernel.org>; Fri, 17 Sep 2021 18:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhIQSLs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Sep 2021 14:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233022AbhIQSLr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Sep 2021 14:11:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1B8661029;
        Fri, 17 Sep 2021 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631902224;
        bh=zBWfmOM2pXUJCqk+liGb2j6sPPLvloaGWUXYS9v8Cxg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AEg+F2obGkSaa/ClmC4lWEh1MjekN6tRb228PkHsIehnULO0M+Fy2KaAjwZmIWGH1
         4sSHQkVyPHAUnYPlxRoh1uIHOHOqMTSDX4Np1YG2f0EtFcs3yHUhkGzqb4ogu8ph89
         fLbto8z6SKNhygbAQM0jX7ZIE8t8J/MBkLJGWY/o5/RQxrAjEa5wpcp9WzmUDamOWa
         zCeI62zZfWSBauoljI0VPc8Kp1B5YquH6CEhReOV86BZuli/Jmu1w907w4+1HOeW8Z
         xdANa90Qz0kfHEWQ2KDMM3iIkEPYjlV+1FKD6uDqbH2nFWu7YIzAH+tafDKIDFsYVu
         uN8MsQNp2iv6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9441C5C014A; Fri, 17 Sep 2021 11:10:24 -0700 (PDT)
Date:   Fri, 17 Sep 2021 11:10:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 2/4] rcu: Remove useless WRITE_ONCE() on
 rcu_data.exp_deferred_qs
Message-ID: <20210917181024.GS4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210916121048.36623-1-frederic@kernel.org>
 <20210916121048.36623-3-frederic@kernel.org>
 <20210916164340.GF4156@paulmck-ThinkPad-P17-Gen-1>
 <20210916210514.GA40064@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916210514.GA40064@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 11:05:14PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 16, 2021 at 09:43:40AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 16, 2021 at 02:10:46PM +0200, Frederic Weisbecker wrote:
> > > This variable is never written nor read remotely. Remove this confusion.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  kernel/rcu/tree_exp.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index f3947c49eee7..4266610b4587 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -255,7 +255,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
> > >   */
> > >  static void rcu_report_exp_rdp(struct rcu_data *rdp)
> > >  {
> > > -	WRITE_ONCE(rdp->exp_deferred_qs, false);
> > > +	rdp->exp_deferred_qs = false;
> > 
> > Are you sure that this can never be invoked from an interrupt handler?
> > And that rdp->exp_deferred_qs is never read from an interrupt handler?
> > If either can happen, then the WRITE_ONCE() does play a role, right?
> 
> Well, the only effect I can imagine is that it can partly prevent from an
> interrupt to report concurrently the quiescent state during the few
> instructions before we mask interrupts and lock the node.
> 
> That's a micro performance benefit that avoid a second call to
> rcu_report_exp_cpu_mult() with the extra locking and early exit.

I am not claiming that current compilers would mess this up, though I
have learned to have great respect for what future compilers might do...

> But then that racy interrupt can still happen before we clear exp_deferred_qs.
> In this case __this_cpu_cmpxchg() would have been more efficient.

Except that __this_cpu_cmpxchg() would have a possibility of failure,
and thus an extra branch not needed by WRITE_ONCE().  Or am I missing
your point here?

I should hasten to add that getting rid of ->exp_deferred_qs is quite
attractive!

							Thanx, Paul

> > >  	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
> > >  }
> > >  
> > > -- 
> > > 2.25.1
> > > 
