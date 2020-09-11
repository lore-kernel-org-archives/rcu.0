Return-Path: <SRS0=/mld=CU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED833C433E2
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94AB206BE
	for <rcu@archiver.kernel.org>; Fri, 11 Sep 2020 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840059;
	bh=LjRDiylts7q6dZKcMRvThFmI0JzgRUaAQ0Zu9SWC8cM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SMamO0LyiOUsUM4ZPhPz1hZ7JKdU4q39EHUySuZYv1bcTePSOiGa428dSsZiyH2qe
	 mZ90DouLUKUJyLOgAoPu7xg2RrTHMP3JR9QnHbdRXwvAsVJlULELLcQICR5sPnTP4/
	 7kBvb7hqEUDb5iu9RXTDxOwiZV9QxBF3RYSAk7cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgIKQAr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgIKQAm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Sep 2020 12:00:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484C521D92;
        Fri, 11 Sep 2020 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599832329;
        bh=LjRDiylts7q6dZKcMRvThFmI0JzgRUaAQ0Zu9SWC8cM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G5S6/nCShLAwtjYpYZ/sM6FbyJH0ARlqvOpABTac5+ViMQ2glNr5jV/WVKCDHfAUU
         PaA2zyNBo+YVCHMGgUpEUVDBQWZJ1i4fbBU/PbBFethII4/munr/J+4gkiRZ3HfDkP
         NUgPxtx6zG1bBypf1Yc7A26cDrkl5ghXvhiaD0rI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 042A43522679; Fri, 11 Sep 2020 06:52:09 -0700 (PDT)
Date:   Fri, 11 Sep 2020 06:52:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] srcu: Fix static initialization
Message-ID: <20200911135208.GX29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200908144306.33355-1-aik@ozlabs.ru>
 <cc25257d-804e-8cf7-150b-e6bdbaf184be@ozlabs.ru>
 <20200909115010.GG29330@paulmck-ThinkPad-P72>
 <37f76aac-d8e3-8ab1-24e9-c417b719e2a6@ozlabs.ru>
 <20200910185353.GS29330@paulmck-ThinkPad-P72>
 <611a6a87-f673-c5b7-3b60-58805fba580a@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611a6a87-f673-c5b7-3b60-58805fba580a@ozlabs.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 11, 2020 at 03:09:41PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 11/09/2020 04:53, Paul E. McKenney wrote:
> > On Wed, Sep 09, 2020 at 10:31:03PM +1000, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 09/09/2020 21:50, Paul E. McKenney wrote:
> >>> On Wed, Sep 09, 2020 at 07:24:11PM +1000, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 09/09/2020 00:43, Alexey Kardashevskiy wrote:
> >>>>> init_srcu_struct_nodes() is called with is_static==true only internally
> >>>>> and when this happens, the srcu->sda is not initialized in
> >>>>> init_srcu_struct_fields() and we crash on dereferencing @sdp.
> >>>>>
> >>>>> This fixes the crash by moving "if (is_static)" out of the loop which
> >>>>> only does useful work for is_static=false case anyway.
> >>>>>
> >>>>> Found by syzkaller.
> >>>>>
> >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>> ---
> >>>>>  kernel/rcu/srcutree.c | 5 +++--
> >>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >>>>> index c100acf332ed..49b54a50bde8 100644
> >>>>> --- a/kernel/rcu/srcutree.c
> >>>>> +++ b/kernel/rcu/srcutree.c
> >>>>> @@ -135,6 +135,9 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
> >>>>>  				   levelspread[level - 1];
> >>>>>  	}
> >>>>>  
> >>>>> +	if (is_static)
> >>>>> +		return;
> >>>>
> >>>> Actually, this is needed here too:
> >>>>
> >>>>  if (!ssp->sda)
> >>>>          return;
> >>>>
> >>>> as
> >>>> ssp->sda = alloc_percpu(struct srcu_data)
> >>>>
> >>>> can fail if the process is killed too soon - it is quite easy to get
> >>>> this situation with syzkaller (syscalls fuzzer)
> >>>>
> >>>> Makes sense?
> >>>
> >>> Just to make sure that I understand, these failures occur when the task
> >>> running init_srcu_struct_nodes() is killed, correct?
> >>
> >> There are multiple user tasks (8) which open /dev/kvm, do 1 ioctl -
> >> KVM_CREATE_VM - and terminate, running on 8 vcpus, 8 VMs, crashes every
> >> 20min or so, less tasks or vcpus - and the problem does not appear.
> >>
> >>
> >>>
> >>> Or has someone managed to invoke (say) synchronize_srcu() on a
> >>> dynamically allocated srcu_struct before invoking init_srcu_struct() on
> >>> that srcu_struct?  
> >>
> >> Nah, none of that :)
> >>
> >> init_srcu_struct_nodes() assumes ssp->sda!=NULL but alloc_percpu() fails
> >> here:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/percpu.c#n1734
> >> ===
> >> 	} else if (mutex_lock_killable(&pcpu_alloc_mutex)) {
> >> 			pcpu_memcg_post_alloc_hook(objcg, NULL, 0, size);
> >> 			return NULL;
> >> ===
> >>
> >> I am still up to reading that osr-rcuusage.pdf to provide better
> >> analysis :) Thanks,
> > 
> > Ah, got it!  Does the following patch help?
> > 
> > There will likely also need to be changes to cleanup_srcu_struct(),
> > but first let's see if I understand the problem.  ;-)
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c13348e..6f7880a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  	INIT_DELAYED_WORK(&ssp->work, process_srcu);
> >  	if (!is_static)
> >  		ssp->sda = alloc_percpu(struct srcu_data);
> > +	if (!ssp->sda)
> > +		return -ENOMEM;
> >  	init_srcu_struct_nodes(ssp, is_static);
> >  	ssp->srcu_gp_seq_needed_exp = 0;
> >  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> >  	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
> 
> The line above confuses me a bit. What you propose returns without
> smp_store_release() called which should not matter I suppose.

The idea is that if init_srcu_struct() returns -ENOMEM, the structure
has not been initialized and had better not be used.  If the calling code
cannot handle that outcome, then the calling code needs to do something
to insulate init_srcu_struct() from signals.  One thing that it could
do would be to invoke init_srcu_struct() from a workqueue handler and
wait for this handler to complete.

Please keep in mind that there is nothing init_srcu_struct() can do
about this:  The srcu_struct is useless unless alloc_percpu() succeeds.

And yes, I do need to update the header comments to make this clear.

> Otherwise it should work, although I cannot verify right now as my box
> went down and since it is across Pacific - it may take time to power
> cycle it :) Thanks,

I know that feeling!  And here is hoping that the box is out of reach
of the local hot spots.  ;-)

							Thanx, Paul

> > -	return ssp->sda ? 0 : -ENOMEM;
> > +	return 0;
> >  }
> >  
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > 
> 
> -- 
> Alexey
