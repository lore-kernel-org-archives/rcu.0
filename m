Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED1C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1F61B51
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 22:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhKQWgN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241240AbhKQWgM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 17:36:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BDD861B5F;
        Wed, 17 Nov 2021 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188393;
        bh=Za4aGPkejDq0o/6QqRhlCJedGEST9Mp+SMRC9Eoz14U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hHSvuEf3undC2JEDL5u3w9AoT+L5bc86RYooFwz/oWHXJezpOcNhEXsrde/u2df8T
         nEZILf7fzuZZZi3WWJ74F7iEQIaf78S09PVSLjDBCuyfB74VBqMh2QiWozQE773+m+
         Dol9+fNQf5lKvcyb8fUWfFN/NWLucz9oAdLnx9V0zvda8Dxl4WJrZAFqwN/yZyK17P
         HLv8XmGnODrwbVh11TZh4icR+nCRK6dm2YbO4lg7RTeqSZbK0aNxLwwK3GP+wflomx
         gvgjsetEpO4DiEhVxrSH+PC/f6e7GL6dYOh6LNADwwoNeyOUthvYefEDo4kUCsFFMy
         hIsFtpk3lIS/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6BB835C06BA; Wed, 17 Nov 2021 14:33:13 -0800 (PST)
Date:   Wed, 17 Nov 2021 14:33:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211117223313.GR641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-6-frederic@kernel.org>
 <20211117194605.GL641268@paulmck-ThinkPad-P17-Gen-1>
 <20211117220230.GC365507@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117220230.GC365507@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 11:02:30PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 17, 2021 at 11:46:05AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 17, 2021 at 04:56:36PM +0100, Frederic Weisbecker wrote:
> > > If a user wants to boot without any CPU in offloaded mode initially but
> > > with the possibility to offload them later using cpusets, provide a way
> > > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > > the creation of dormant nocb kthreads.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 10 ++++++----
> > 
> > Could you please also update kernel-parameters.txt?
> 
> Ah right!
> 
> > 
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 1871f15b8472..3845f1885ffc 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -66,14 +66,16 @@ static bool rcu_nocb_is_setup;
> > >  static int __init rcu_nocb_setup(char *str)
> > >  {
> > >  	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> > > -	if (cpulist_parse(str, rcu_nocb_mask)) {
> > > -		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> > > -		cpumask_setall(rcu_nocb_mask);
> > > +	if (*str == '=') {
> > > +		if (cpulist_parse(++str, rcu_nocb_mask)) {
> > > +			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> > > +			cpumask_setall(rcu_nocb_mask);
> > > +		}
> > 
> > Wouldn't "*str == '='" indicate that the parameter passed in was of
> > the form "rcu_nocbs==8"?
> > 
> > Or am I misreading the next_arg() function in lib/cmdline.c?
> > 
> > If I am reading it correctly, doesn't the test instead want to be
> > something of the form "if (str && *str)"?
> > 
> > 							Thanx, Paul
> > 
> > >  	}
> > >  	rcu_nocb_is_setup = true;
> > >  	return 1;
> > >  }
> > > -__setup("rcu_nocbs=", rcu_nocb_setup);
> > > +__setup("rcu_nocbs", rcu_nocb_setup);
> 
> Don't miss that line, that should probably answer your above question, if
> I didn't miss something from my end (which is not unlikely...)

My next step would be to add a printk() and try booting with different
rcu_nocbs parameter settings.  ;-)

							Thanx, Paul

> > >  static int __init parse_rcu_nocb_poll(char *arg)
> > >  {
> > > -- 
> > > 2.25.1
> > > 
