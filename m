Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADC1F63F5;
	Sat, 22 Mar 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639104; cv=none; b=Bh+HDpQYBz364vuWXLVTA1UshIH1C3PR4RjCacZ1urYJecvKgPvte9fddYm924F6Fnxj9s4O7kDE+NfY+VcvJhXX8VgA189xsoEsnhr8bWbEx2g4cYBYEyf4Eyc10vDJiYg58Oh5NqMNhywJkKs6EhMRXjezBrDVgHw/CsO7ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639104; c=relaxed/simple;
	bh=mxxZn7PVoMFN5rK7NX+QNEbmUmtTQYDmklCEJalghLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q34+nojmcDotYZ24LV/EmQGNrsahDVdvY5g+e/UQkmxubQv6r+ImE30J/8CnMkuIxMUzyVjR9mPj6YWPkmuxPdDxYSoXBYUy31f+GQMIKZaEJHfpPtnGHgLZpPhsbX68Q1ibP3Uo6uWJ7KtItWod0e+wg+vAZUHmYAVtdY8SYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPKvuJ1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPKvuJ1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CECC4CEDD;
	Sat, 22 Mar 2025 10:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742639103;
	bh=mxxZn7PVoMFN5rK7NX+QNEbmUmtTQYDmklCEJalghLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPKvuJ1ZHKheg2X414FtHCnWiWl5xmbmlDh/fc3s2lF/sHZIkVXJZZto9NBbOGVgv
	 nZnxDiMPSy0rz3+eXy6ANBWHiW/1Gax0Sp7T+q6ColjmpQv10xJokNAT9fdvr+YfoC
	 MbTl4rJVsO+1/OJQxNvN1ppzf17HzCxnfJKPa/ZPlapwbk6ldJSVOhbUV/RgrHvs4n
	 DuP1FnaFBj+Vk3zYeD1fyXuNzFiNTACX2CYJmKE86b4ePflgkGCiZtJM5pjih6dIIc
	 eMkmUElR3WAdUIWoEnM1N+j2NBbhfeZgysZ/vTwR7gK3qmnfVNz6Elwqc1rTMhcc/+
	 RgzV+u4SGTTww==
Date: Sat, 22 Mar 2025 11:25:00 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Message-ID: <Z96P_K0kt-FumSjz@pavilion.home>
References: <20250318135619.4300-1-frederic@kernel.org>
 <20250318135619.4300-2-frederic@kernel.org>
 <322b052d-0f1f-45a3-bfef-226b15f3a8fd@paulmck-laptop>
 <20250319193831.GA3791727@joelnvbox>
 <Z9wjBT3RQDUrFdbE@p200300d06f3e9880e1f174d4afcc9316.dip0.t-ipconnect.de>
 <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c7f1032-f2ba-4fc6-91c0-a07fce1b9c3c@nvidia.com>

Le Sat, Mar 22, 2025 at 03:06:08AM +0100, Joel Fernandes a écrit :
> Insomnia kicked in, so 3 am reply here (Zurich local time) ;-):
> 
> On 3/20/2025 3:15 PM, Frederic Weisbecker wrote:
> > Le Wed, Mar 19, 2025 at 03:38:31PM -0400, Joel Fernandes a écrit :
> >> On Tue, Mar 18, 2025 at 11:37:38AM -0700, Paul E. McKenney wrote:
> >>> On Tue, Mar 18, 2025 at 02:56:18PM +0100, Frederic Weisbecker wrote:
> >>>> The numbers used in rcu_seq_done_exact() lack some explanation behind
> >>>> their magic. Especially after the commit:
> >>>>
> >>>>     85aad7cc4178 ("rcu: Fix get_state_synchronize_rcu_full() GP-start detection")
> >>>>
> >>>> which reported a subtle issue where a new GP sequence snapshot was taken
> >>>> on the root node state while a grace period had already been started and
> >>>> reflected on the global state sequence but not yet on the root node
> >>>> sequence, making a polling user waiting on a wrong already started grace
> >>>> period that would ignore freshly online CPUs.
> >>>>
> >>>> The fix involved taking the snaphot on the global state sequence and
> >>>> waiting on the root node sequence. And since a grace period is first
> >>>> started on the global state and only afterward reflected on the root
> >>>> node, a snapshot taken on the global state sequence might be two full
> >>>> grace periods ahead of the root node as in the following example:
> >>>>
> >>>> rnp->gp_seq = rcu_state.gp_seq = 0
> >>>>
> >>>>     CPU 0                                           CPU 1
> >>>>     -----                                           -----
> >>>>     // rcu_state.gp_seq = 1
> >>>>     rcu_seq_start(&rcu_state.gp_seq)
> >>>>                                                     // snap = 8
> >>>>                                                     snap = rcu_seq_snap(&rcu_state.gp_seq)
> >>>>                                                     // Two full GP differences
> >>>>                                                     rcu_seq_done_exact(&rnp->gp_seq, snap)
> >>>>     // rnp->gp_seq = 1
> >>>>     WRITE_ONCE(rnp->gp_seq, rcu_state.gp_seq);
> >>>>
> >>>> Add a comment about those expectations and to clarify the magic within
> >>>> the relevant function.
> >>>>
> >>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >>>
> >>> But it would of course be good to get reviews from the others.
> >> I actually don't agree that the magic in the rcu_seq_done_exact() function about the
> >> ~2 GPs is related to the lag between rcu_state.gp_seq and root rnp->gp_seq,
> >> because the small lag can just as well survive with the rcu_seq_done()
> >> function in the above sequence right?
> >>
> >> The rcu_seq_done_exact() function on the other hand is more about not being
> >> stuck in the ULONG_MAX/2 guard band, but to actually get to that, you need a
> >> wrap around to happen and the delta between "rnp->gp_seq" and "snap" to be at
> >> least ULONG_MAX/2 AFAIU.
> >>
> >> So the only time this magic will matter is if you have a huge delta between
> >> what is being compared, not just 2 GPs.
> > You're right, and perhaps I should have made it more specific that my comment
> > only explains the magic "3" number here, in that if it were "2" instead, there
> > could be accidents with 2 full GPs difference (which is possible) spuriously
> > accounted as a wrap around.
> 
> Ahh, so I guess I get it now and we are both right. The complete picture is - We
> are trying to handle the case of "very large wrap" around but as a part of that,
> we don't want to create false-positives for this "snap" case.
> 
> A "snap" can be atmost  (2 * RCU_SEQ_STATE_MASK + 1) away from a gp_seq.
> 
> That's within "2 GPs" worth of counts (about 8 counts)
> 
> Taking some numbers:
> 
> cur_s	s	delta (s - cur_s)
> 0	4	4
> 1	8	7
> 2	8	6
> 3	8	5
> 4	8	4
> 5	12	7
> 
> The maximum delta of a snap from actual gp_seq can be (2 * RCU_SEQ_STATE_MASK +
> 1) which in this case is 7.
> 
> So we adjust the comparison by adding the  ULONG_CMP_LT(cur_s, s - (2 *
> RCU_SEQ_STATE_MASK + 1)). i.e.

3, right?

> 
> after a snap, if we blindly do ULONG_CMP_LT without adjustment, we'll falsely
> conclude that the GP has completed thinking it was due to wrap around, where as
> it is possible we just snapped and got a false positive.
> 
> So I think your comment is mostly correct then. But I think it may be better to
> clarify that the reason we need rcu_seq_done_exact() and that ULONG_CMP_LT is
> because we want handle very large wrap around not being stuck in "false
> negative" territory as we would with rcu_seq_done(). But that also means we
> can't break the "snap" usecase to the introduction of ULONG_CMP_LT.

Indeed.

> 
> Unless you beat me to it, I may modify your patch for v6.16 augmented with this
> reasoning ;) (Also since I am also working on adding that forced wrap around
> test to rcutorture).

Please do, I appreciate!

> 
> Also it is still not fully clear to me what the root node has to do with all
> this in your example, because the rcu_seq_done_exact() needs to be what it is
> (that is having that 2 GP adjustment) even if the rnp->gp_seq and
> rcu_state.gp_seq were in sync?

Yes, this is only to explain that the maximum drift between the snap on rsp
and the current state on root rnp can be at most 2 full GP. And that explain the "3"
magic in the function. But if they were in sync it's all fine.

Thanks.


> 
> thanks,
> 
>  - Joel
> 
