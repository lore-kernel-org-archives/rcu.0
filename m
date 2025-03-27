Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81921A28D;
	Thu, 27 Mar 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095914; cv=none; b=I3HArX71AKOM+xSCipdGPRx5GI4J0+fKJjQK905dm1clgENKifKZ1meXZ1G8r7oh8UNLaxbBGnuQycStZePUUr9PP0fJgYE93IrCt2+JPPkT8eHOdZ92XzRWxwpompdK7z36ZuKdWEeW5O7nCP22RqGcjsW+UJKEcRRUyhUvUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095914; c=relaxed/simple;
	bh=NwuTPr3CNn00JTM1/QP5oKWr4H2J8NwcpymOBvDJebM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ale2cbsDW70dqbjZFf+oDsvqbGcb0vDtBi+xn4WM43M5SxJWwMTZMdr4ZvTd4e6VK65GMRx/EXXu311b9yrDip4S/y9TxBkUpRnL9BIAI6X5/JuxAV0NNoF1g9ekBcwTsKyqqpXdaKN1s++/ETEPMAO7ujIca3ErRQLpcGjC/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA1FldOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA1FldOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C4C4CEE5;
	Thu, 27 Mar 2025 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743095913;
	bh=NwuTPr3CNn00JTM1/QP5oKWr4H2J8NwcpymOBvDJebM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jA1FldOuPkwVlg+JyxpryOQA3TO1eIxoS4+zEbaqWzireyQEpJDFzjJdTmG/iPQ0U
	 FgreMpVNBUIMOItGI9z4v4qlnc0VHux4ar+jbGhQf4POVeItDE+f5nfN++xGfLLk0J
	 eg0JW9KiEiiIcBUIckyOqPMMvPR4SqUOqOlE0ffCtFJT2KISE/Q0vgIVGyykz14JPE
	 juTnA9fm7v2cD0xq6WbrZPA0ztjSJezDfsa/VGI7xzEYdQAs1xSFUP+2Sl32vWilA3
	 /ID61sw4vszhHzlMkME0rExmBLY4JklNrdgDwFdMfWpiHjvYcTWpUdVZdeRwZB93/i
	 6hXBrX487jMOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 09C08CE0A70; Thu, 27 Mar 2025 10:18:33 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:18:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: qiang Z <qiang.zhang1211@gmail.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 5/9] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <2a31e0f3-9451-4c34-9b14-31e35b1edc88@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
 <20250310183809.3576320-5-paulmck@kernel.org>
 <CALm+0cWn_wh_QnR0k-QDVTwgdBdXTEd1Xtk5SM+T27ejCchPJw@mail.gmail.com>
 <762ee713-a38f-49e5-aa4a-57e4a4da687c@paulmck-laptop>
 <9ac94cda-3962-44d4-80e7-94555b104cf2@nvidia.com>
 <f7349c37-1496-4d23-8863-3cb75b538a23@paulmck-laptop>
 <1F552A07-5799-4228-ACE2-0A8706F1D814@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1F552A07-5799-4228-ACE2-0A8706F1D814@nvidia.com>

On Thu, Mar 27, 2025 at 05:08:35PM +0000, Joel Fernandes wrote:
> 
> 
> > On Mar 27, 2025, at 12:48 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Thu, Mar 27, 2025 at 12:22:12PM -0400, Joel Fernandes wrote:
> >> Paul,
> >> 
> >>>> If rtorsu_hrt timer is still in timer_queue, invoke hrtimer_cancel() will
> >>>> remove it from timerqueue and directly return, so the rcu_torture_updown_hrt()
> >>>> will not be executed and the rtorsup->rtorsu_inuse cannot be set false.
> >>>> 
> >>>> How about modifying it as follows:
> >>>> 
> >>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >>>> index 04d7a2173b95..ecf3d3797f7e 100644
> >>>> --- a/kernel/rcu/rcutorture.c
> >>>> +++ b/kernel/rcu/rcutorture.c
> >>>> @@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
> >>>>        for (rtorsup = updownreaders; rtorsup <
> >>>> &updownreaders[n_up_down]; rtorsup++) {
> >>>>                if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
> >>>>                        continue;
> >>>> -               (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
> >>>> -               if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> >>>> +               if (hrtimer_cancel(&rtorsup->rtorsu_hrt) ||
> >>>> WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> >>>> 
> >>>> rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs,
> >>>> -1);
> >>>>                        WARN_ONCE(rtorsup->rtorsu_nups >=
> >>>> rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n",
> >>>> __func__, rtorsup - updownreaders);
> >>>>                        rtorsup->rtorsu_nups++;
> >>> 
> >>> Good eyes, thank you!  I have applied this fix with attribution.
> >> 
> >> Could you re-send the series, or should I apply the fix the patch myself? Or
> >> provide the new patch inline here.
> > 
> > Your choice, just let me know.  If you have modified any of the other
> > patches in that series, it will probably be easier for you if I either
> > resend just that one patch or if you apply the changes.  If you haven't
> > done any modifications, it might be easier for you if I re-sent the
> > series.
> 
> Thanks, you could resend as I have not changed other patches.

Will do!  I expect to get that to you by end of this coming Monday
at the latest.

							Thanx, Paul

> - Joel
> 
> > 
> > I have the delta patch below, which I have pushed out for kernel test
> > robot ministrations and which I expect to merge into the original
> > later today.
> > 
> >                            Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 55fcac5cb3fc96479d935db648c98503cb0a944b
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Mar 27 07:29:48 2025 -0700
> > 
> >    squash! rcutorture: Add tests for SRCU up/down reader primitives
> > 
> >    [ paulmck: Apply Z qiang feedback. ]
> > 
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 04d7a2173b95d..ecf3d3797f7e1 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2502,8 +2502,7 @@ static void rcu_torture_updown_cleanup(void)
> >    for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
> >        if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
> >            continue;
> > -        (void)hrtimer_cancel(&rtorsup->rtorsu_hrt);
> > -        if (WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> > +        if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
> >            rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
> >            WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
> >            rtorsup->rtorsu_nups++;
