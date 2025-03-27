Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4E1E868;
	Thu, 27 Mar 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094112; cv=none; b=hzqzKq8nOml2NLh11KzyU4avE1QaizJBF++MJiKXPmRqE3olF4zb8wJlnZ7QjxN0xHumKRXXjhEXG2fvDkuknj5HzDt1BLO6zsIQn/gHb0XGpI7x1LRMXahimGGn0T2TfcHyarHKY+genVZgVqXvY2uUNHGuACLZsSRQqtjBH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094112; c=relaxed/simple;
	bh=Q1VClPiEhm2KERhaBBnNpJyjepNFFGsY6HXvriZmw+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ0oh3fB9VV2MbpsVcAXL6AdrFglHxif5CjQcr/j6dFzudUDlTegHtIKFpoy7BtYRFkpaHemzoLQXgTUwZJap5QjT1G/EXV5Hc5Jps9V9iWfYkcKSpL1kiCqBcwgTPTrUyA3TanrH37RIZKX3ZeNBGCCzNjMfqWHupFhqAc94gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rkup6TJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rkup6TJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A03EC4CEE5;
	Thu, 27 Mar 2025 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743094112;
	bh=Q1VClPiEhm2KERhaBBnNpJyjepNFFGsY6HXvriZmw+M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Rkup6TJ+T3kGnflvR8jZcaTC+JvVSUk+XD1mdy4+N+HB9EAr0ANsiPQDUAiB/P6im
	 ZBKHL7ALYSiPZ6NqE+bg14Ow3a3PV/W+M8GFXAHguoAC+sI3ulXNp40yrrNmnaGryq
	 vbPrcOTaZmQgkWVrXJUztAnM/IDrcYb0pOS/SEHex9YyhQ7lCwlGKMdYoXJIZW6tm1
	 NFN28E7QI8Olbc4KwOBgKgohcI6CCWBFGke7sXyMa/q/EtqRaEog9jEiFFByceUEHk
	 voIwTLsJCLJX2olCD9KSBJx3cpJg4P8OPArlA4Vo3jyIK09d1qyqeol9w2vMw05S/6
	 BaY64CgjNHgVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3460CE0843; Thu, 27 Mar 2025 09:48:31 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:48:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <f7349c37-1496-4d23-8863-3cb75b538a23@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
 <20250310183809.3576320-5-paulmck@kernel.org>
 <CALm+0cWn_wh_QnR0k-QDVTwgdBdXTEd1Xtk5SM+T27ejCchPJw@mail.gmail.com>
 <762ee713-a38f-49e5-aa4a-57e4a4da687c@paulmck-laptop>
 <9ac94cda-3962-44d4-80e7-94555b104cf2@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac94cda-3962-44d4-80e7-94555b104cf2@nvidia.com>

On Thu, Mar 27, 2025 at 12:22:12PM -0400, Joel Fernandes wrote:
> Paul,
> 
> >> If rtorsu_hrt timer is still in timer_queue, invoke hrtimer_cancel() will
> >> remove it from timerqueue and directly return, so the rcu_torture_updown_hrt()
> >> will not be executed and the rtorsup->rtorsu_inuse cannot be set false.
> >>
> >> How about modifying it as follows:
> >>
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 04d7a2173b95..ecf3d3797f7e 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
> >>         for (rtorsup = updownreaders; rtorsup <
> >> &updownreaders[n_up_down]; rtorsup++) {
> >>                 if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
> >>                         continue;
> >> -               (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
> >> -               if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> >> +               if (hrtimer_cancel(&rtorsup->rtorsu_hrt) ||
> >> WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> >>
> >> rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs,
> >> -1);
> >>                         WARN_ONCE(rtorsup->rtorsu_nups >=
> >> rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n",
> >> __func__, rtorsup - updownreaders);
> >>                         rtorsup->rtorsu_nups++;
> > 
> > Good eyes, thank you!  I have applied this fix with attribution.
> 
> Could you re-send the series, or should I apply the fix the patch myself? Or
> provide the new patch inline here.

Your choice, just let me know.  If you have modified any of the other
patches in that series, it will probably be easier for you if I either
resend just that one patch or if you apply the changes.  If you haven't
done any modifications, it might be easier for you if I re-sent the
series.

I have the delta patch below, which I have pushed out for kernel test
robot ministrations and which I expect to merge into the original
later today.

							Thanx, Paul

------------------------------------------------------------------------

commit 55fcac5cb3fc96479d935db648c98503cb0a944b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Mar 27 07:29:48 2025 -0700

    squash! rcutorture: Add tests for SRCU up/down reader primitives
    
    [ paulmck: Apply Z qiang feedback. ]
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 04d7a2173b95d..ecf3d3797f7e1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
 	for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
-		(void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
-		if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
+		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
 			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
 			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
 			rtorsup->rtorsu_nups++;
