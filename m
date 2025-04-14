Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0177163;
	Mon, 14 Apr 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647428; cv=none; b=ifAdj586LNf0XR73XHC6LIZ7WvIJqdA0Tb7LbgkvV1syYOEsrhznpJdZatTx7z2AAKuWXLYXYldX+zIlQr3aujQiLXiVDSHihIbJNQL6d3Dzz99F3d+D2TWbW1z5bD69W9OydDaEu1oFB09lB0ESWxVISeGfTz4WgUgZDHP055U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647428; c=relaxed/simple;
	bh=tA3sogfwKwFLBYjnEW7HJ+5Ul9kbPJcrtcxak2kCQxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPRNaNV1XXu374EVac2E1h/zWWbZJRJ5cpJZp71ILkzdMfpoXfr5Q04IH1Cy58UuNBiXsCSj+28A0N4Dmaz5Dhftb67DymNjDCUlDgiglWFYSrTIJ6rteVJ+7s67uRPWXZbtfDppUa8ABeYg6P3UYCmfZmM+3cGXi1xHobd+YvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9l1lkkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9l1lkkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266BFC4CEE2;
	Mon, 14 Apr 2025 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744647428;
	bh=tA3sogfwKwFLBYjnEW7HJ+5Ul9kbPJcrtcxak2kCQxI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=f9l1lkkPsCF1Tj+bCom0ZRX4T3HLG7IpKudZjScN6m+5ikAl3ol4CzqKeugnnuc0v
	 FqvNPim0UAtboE4GoQp3Oc2d1BTzr9ZMGqRdpYFTU7mMl9O2Urr8tyz6oCiDc5T9Ut
	 /PmYaFj+TTiZS5z1goQXBYXofgIINSrwFP3h9oZyhXjp8CkEJhaFQF8HWCKtECBQIX
	 mokgYQTVlRKGX4ZcD8iSXC6DmHZgu8RPGS7IgMDKsdoyGBp3MVJi4KDuz63u3V1hgr
	 LtQC0TEb92pAkHRLSDFxUALGXUW9Jv+uumjpdnpouufbg0wDIk5NKr6NHRlLKE0G60
	 ibpWJZ7xDa0bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AC6DACE0848; Mon, 14 Apr 2025 09:17:07 -0700 (PDT)
Date: Mon, 14 Apr 2025 09:17:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu <rcu@vger.kernel.org>
Subject: Re: [v3,1/2] rcutorture: Perform more frequent testing of ->gpwrap
Message-ID: <cd213b7e-a2fe-4005-8d28-0e3998e32d5a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71ab408c-a01b-43a9-993c-4a55294e15ef@paulmck-laptop>
 <BE7C948D-5238-48C4-93E1-1BAE4CBBD391@joelfernandes.org>
 <75bdde29-55f7-4210-a3ea-ea859a0e3a1a@paulmck-laptop>
 <8435b865-289a-488d-baab-3ba819b3cad5@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8435b865-289a-488d-baab-3ba819b3cad5@nvidia.com>

On Mon, Apr 14, 2025 at 10:56:24AM -0400, Joel Fernandes wrote:
> On 4/14/2025 10:24 AM, Paul E. McKenney wrote:
> > On Mon, Apr 14, 2025 at 08:07:24AM -0400, Joel Fernandes wrote:
> >>> On Apr 11, 2025, at 3:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> ﻿On Fri, Apr 11, 2025 at 05:36:32AM -0000, Joel Fernandes wrote:
> >>>> Hello, Paul,
> >>>>
> >>>>> On Fri, 11 Apr 2025 05:33:16 GMT, "Paul E. McKenney" wrote:
> >>>>> On Thu, Apr 10, 2025 at 11:54:13AM -0700, Paul E. McKenney wrote:
> >>>>>> On Thu, Apr 10, 2025 at 11:29:03AM -0700, Paul E. McKenney wrote:
> >>>>>>> On Thu, Apr 10, 2025 at 11:03:27AM -0400, Joel Fernandes wrote: >
> >>>>>>> Currently, the ->gpwrap is not tested (at all per my testing) due to
> >>>>>>> the > requirement of a large delta between a CPU's rdp->gp_seq and its
> >>>>>>> node's > rnp->gpseq.  > > This results in no testing of ->gpwrap being
> >>>>>>> set. This patch by default > adds 5 minutes of testing with ->gpwrap
> >>>>>>> forced by lowering the delta > between rdp->gp_seq and rnp->gp_seq to
> >>>>>>> just 8 GPs. All of this is > configurable, including the active time for
> >>>>>>> the setting and a full > testing cycle.  > > By default, the first 25
> >>>>>>> minutes of a test will have the _default_ > behavior there is right now
> >>>>>>> (ULONG_MAX / 4) delta. Then for 5 minutes, > we switch to a smaller delt
> >>>>> a
> >>>>>>> causing 1-2 wraps in 5 minutes. I believe > this is reasonable since we
> >>>>>>> at least add a little bit of testing for > usecases where ->gpwrap is se
> >>>>> t.
> >>>>>>>>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >>>>>>>
> >>>>>>> Much better, thank you!
> >>>>>>>
> >>>>>>> One potential nit below.  I will run some tests on this version.
> >>>>>>
> >>>>>> And please feel free to apply the following to both:
> >>>>>>
> >>>>>> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>>
> >>>>> And this happy situation lasted only until I rebased onto v6.15-rc1 and
> >>>>> on top of this commit:
> >>>>>
> >>>>> 1342aec2e442 ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.1
> >>>>> 6' and 'rcu/torture-for-6.16' into rcu/for-next")
> >>>>>
> >>>>> This got me the splat shown below when running rcutorture scenario SRCU-N.
> >>>>> I reverted this commit and tests pass normally.
> >>>>>
> >>>>> Your other commit (ARM64 images) continues working fine.
> >>>>
> >>>> Interesting.. it seems to be crashing during statistics printing.
> >>>>
> >>>> I am wondering if the test itself uncovered a bug or the bug is in the test
> >>>> itself.
> >>>
> >>> Both are quite possible, also a bug somewhere else entirely.
> >>
> >> I may not get to debugging it for this merge window so I am leaning to defer it.
> > 
> > The usual cause is use of an rcu_torture_ops function pointer without
> > having first checked that it is non-NULL.  But I suspect that you already
> > checked for this.
> 
> Oops, I am not! You are right I think it broke since the movement into ops and
> needs this which I missed for this call site (though I did it for the other). I
> could repro SRCU-N without it and with the fix it passes:
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 74de92c3a9ab..df6504a855aa 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2412,7 +2412,8 @@ rcu_torture_stats_print(void)
>                         pipesummary[i] += READ_ONCE(per_cpu(rcu_torture_count,
> cpu)[i]);
>                         batchsummary[i] += READ_ONCE(per_cpu(rcu_torture_batch,
> cpu)[i]);
>                 }
> -               n_gpwraps += cur_ops->get_gpwrap_count(cpu);
> +               if (cur_ops->get_gpwrap_count)
> +                       n_gpwraps += cur_ops->get_gpwrap_count(cpu);
>         }
>         for (i = RCU_TORTURE_PIPE_LEN; i >= 0; i--) {
>                 if (pipesummary[i] != 0)
> 
> I will squash the fix into the patch and repost as v4.

Been there, done that!  And looks like a proper fix to me.

							Thanx, Paul

> >>>> Looking forward to your test with the other patch and we could hold off on this
> >>>> one till we have more data about what is going on.
> >>>
> >>> This one got lot of OOMs when tests of RCU priority boosting overlapped
> >>> with testing of RCU callback flooding on TREE03, as in 13 of the 14
> >>> 9-hour runs.  Back on v6.14-rc1, these were quite rare.
> >>>
> >>> Ah, and I am carrying this as an experimental patch:
> >>>
> >>> 269b9b5be09d ("EXP sched: Disable DL server if sysctl_sched_rt_runtime is -1")
> >>>
> >>> Just checking to see if this is still something I should be carrying.
> >>
> >> I think since it exposing boost issues, we should carry it! However since it is also noisy, maybe for short term we not carry it in any trees since we are getting close to posting the topic branches.
> > 
> > I am carrying it in -rcu, but marked "EXP" so that I don't post it or
> > send it along in a pull request.
> 
> Sounds good to me.
> 
> >> Do you see the same boost issues or frequency of them when carrying it on 6.15-rc1 without any of this merge windows changes?
> >>
> >> By the way I have to rewrite that EXP patch at some point based on a review of it but functionally that patch is good.
> > 
> > I just now started a short test with it reverted.
> > 
> > Oh, and yours and Boqun's latest passed overnight tests except for a
> > few Kconfig issues including the PREEMPT_RT pair:
> > 
> > 75cf58ef310a ("Merge branches 'rcu/misc-for-6.16', 'rcu/seq-counters-for-6.16' and 'rcu/torture-for-6.16' into rcu/for-next")
> > 
> > This is a known Kconfig issue in torture.sh, fixed by this -rcu commit:
> > 
> > 2e26af16b7b6 ("torture.sh: Force CONFIG_RCU_NOCB_CPU=y for --do-rt configurations")
> 
> I already merged this change
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=rcu/for-next&id=a3204f778cf7e37c7344404768398b4f9d43a368
> 
> But you saw issues in your testing even with this?
> 
> Could you rebase on top of my for-next branch so we are on the same page? Tag
> next.2025.04.11a
> 
> I believe you said you were going to rebuild your tree, but were waiting on testing?
> 
> > 
> > There are also Kconfig issues with a few of the KCSAN rcutorture scenarios
> > that I am looking into.  And torture.sh needs to be more aggressive about
> > reporting these...
> Ok sounds good, happy to add these to my torture-for-6.16 topic branch once you
> post them.
> 
> thanks,
> 
>  - Joel
> 
> 
