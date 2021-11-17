Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A5C433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 21:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61856128A
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 21:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhKQWBb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240856AbhKQWAz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 17:00:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3258361265;
        Wed, 17 Nov 2021 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637186275;
        bh=iizMCf2ybDmdY66l5CHX/+GO08n+cp3Azrqi1mw+hKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpflLjKdY4OwmUxGLY3pSODgczn7y8p8/qONCN/YdQH+0dSbHCIj3bv7wl4sjmlJq
         ZK+OYAD/T2ndLa29BKh8LRfes0fmi+A2V5rIAtdPmOPj+EFbydU2ImWQdYu9Gi+elK
         tzn7PruJHLLklaiov1rlMWBYTCygSje0c+4dgSMtPTjHE+Y0qNtDX5nyilqpFPKUpU
         CijvsrmhqxUetKEZuyuwapkG8M6mtUv7YhYaZ7EpKNmb2A9uyuJkpG+FghKokuZad7
         FDv+BHVHLOglVpRDAxroOyZsJpBiGWa8wnfVk0rBaXUDl/L1Y7OUSj7O4xlwkNDp/H
         NHrrSxlqPF65Q==
Date:   Wed, 17 Nov 2021 22:57:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 4/6] rcu/nocb: Create nocb kthreads on all CPUs as long
 as the "rcu_nocb=" is passed
Message-ID: <20211117215753.GB365507@lothringen>
References: <20211117155637.363706-1-frederic@kernel.org>
 <20211117155637.363706-5-frederic@kernel.org>
 <20211117192710.GK641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117192710.GK641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 11:27:10AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 17, 2021 at 04:56:35PM +0100, Frederic Weisbecker wrote:
> > In order to be able to (de-)offload any CPU using cpuset in the future,
> > create a NOCB kthread for all possible CPUs. For now this is done only
> > as long as the "rcu_nocb=" kernel parameter is passed to avoid
> > the unnecessary overhead for most users.
> 
> The "nohz_full=" kernel parameter would also cause these kthreads to
> be created, correct?  (Yeah, a nit, but...)
> 
> And some fallout of my forgetfulness below.  :-/

Ah right, that too!
> >  
> > @@ -1268,7 +1265,7 @@ static void __init rcu_spawn_nocb_kthreads(void)
> >  	int cpu;
> >  
> >  	if (rcu_nocb_is_setup) {
> > -		for_each_online_cpu(cpu)
> > +		for_each_possible_cpu(cpu)
> 
> Gah...  I had forgotten.  :-/
> 
> Some firmware lies about the OS instance's age.  Other firmware lies
> about the number of CPUs, sometimes claiming large multiples of the
> actual number of CPUs.
> 
> So this needs to stay "for_each_online_cpu".  Otherwise, Paul Gortmaker
> will once again be afflicted with hundreds of unnecessary rcuo kthreads.
> 
> The later calls to rcutree_prepare_cpu() from rcutree_prepare_cpu()
> will take care of any CPUs that first come online later.

Ok that makes sense.

> 
> >  			rcu_spawn_cpu_nocb_kthread(cpu);
> >  	}
> >  }
> > @@ -1303,7 +1300,7 @@ static void __init rcu_organize_nocb_kthreads(void)
> >  	 * Should the corresponding CPU come online in the future, then
> >  	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
> >  	 */
> > -	for_each_cpu(cpu, rcu_nocb_mask) {
> > +	for_each_possible_cpu(cpu) {
> 
> This needs to change, but to for_each_online_cpu() instead of
> for_each_possible_cpu().  That handles the case where the boot CPU is
> not initially offloaded, but where the sysadm later needs to offload it.

I'm less sure about that one. This is called early from rcu_init_nohz(). Only
the boot CPU should be online at that point. We really need to integrate all
possible CPUs within the nocb groups.

Thanks.

> 
> >  		rdp = per_cpu_ptr(&rcu_data, cpu);
> >  		if (rdp->cpu >= nl) {
> >  			/* New GP kthread, set up for CBs & next GP. */
> > @@ -1327,7 +1324,8 @@ static void __init rcu_organize_nocb_kthreads(void)
> >  				pr_cont(" %d", cpu);
> >  		}
> >  		rdp->nocb_gp_rdp = rdp_gp;
> > -		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
> > +		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
> > +			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
> >  	}
> >  	if (gotnocbs && dump_tree)
> >  		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
> > -- 
> > 2.25.1
> > 
