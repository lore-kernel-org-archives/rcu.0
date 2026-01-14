Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1C2DAFA5;
	Wed, 14 Jan 2026 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363159; cv=none; b=BM5BY1QqaiaAA6mx6fUDrVQD1Y9qCbHFMWM3mmP/7u1JmlZyTHZRBNn8O9CuilAKapj1y00JrEG/f1icI1PSz+3DzOEM1ttzujbR0eOqYStr+CZncjbs+yeKFEDrOg1rop8LcZuox9/wHR86xBBjBsjxsnRXHIYdHfDBSb+QStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363159; c=relaxed/simple;
	bh=aEqf4ZdnnbQSqaiA0fPDkQFu1HUZNlBZQ4PWZpbHwJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaWxWm7aFqs+Ex9xGO2tcLl5nfDfJX67OQ5SiIAr18cruQasyh0jyCNTEnjMyDRLho4ieFyLquC+z1BVLFRPCqDLjwQXTOKkC2Ec61cLkJWWKOjqJgY0GhrsFoE2UUZYZEDTWDyweJfsjVTzK/gdqo+i6QfnooyHD3rKmhgriSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZRaUQq5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZRaUQq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22CAC4CEF7;
	Wed, 14 Jan 2026 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768363158;
	bh=aEqf4ZdnnbQSqaiA0fPDkQFu1HUZNlBZQ4PWZpbHwJI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GZRaUQq5fCgReaO02AaqXriBShuoC3I1Xgh5pPzqYwc3pf2vuxdxrSu8uRVh4usMv
	 2KvYTuHpknJ+DiGF1eIytCESZul3s+2nxe0Ie3ayvNGRpPhEAwTW1hqKjD94NK1ODk
	 eiFrQ6Wq1FnuaAXFf95nDaiAy2ciOUs30hoSJNbkWhgsS/YcWxc6Zj21vzEuAbDpv5
	 vsLxhgRpmLr2pfWTq4AtX51XLNuKp7slM3saqaaO7SmkOtDJ06392ehKaNnKiQTS5b
	 ozDiXt6ZsCE3mGqRuI/CG/MwuoTpz4+/VHAdHTcmnle5IyX9YEQ96ko65FZUAZENeV
	 lqsqJD7/KsBXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26170CE0B7C; Tue, 13 Jan 2026 19:59:18 -0800 (PST)
Date: Tue, 13 Jan 2026 19:59:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <e229ab9d-9e3a-4863-96dc-8f56d2531c30@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>

On Tue, Jan 13, 2026 at 02:46:56AM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 7:01 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Jan 12, 2026 at 05:24:40PM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>> On 1/12/2026 11:48 AM, Paul E. McKenney wrote:
> >>> On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> >>>> 
> >>>> 
> >>>>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>> 
> >>>>> ﻿Hello, Shrikanth!
> >>>>> 
> >>>>>> 
> >>>>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>>>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>>>>>> systems, this process takes significant time, increasing as the number
> >>>>>>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>>>>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>>>>>> waiting for synchronize_rcu().
> >>>>>>>> 
> >>>>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>>>>>> it should complete as quickly as possible.
> >>>>>>>> 
> >>>>>>>> Performance data on a PPC64 system with 400 CPUs:
> >>>>>>>> 
> >>>>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>>>>>> Before: real 1m14.792s
> >>>>>>>> After:  real 0m03.205s  # ~23x improvement
> >>>>>>>> 
> >>>>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>>>>>> Before: real 2m27.695s
> >>>>>>>> After:  real 0m02.510s  # ~58x improvement
> >>>>>>>> 
> >>>>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>>>>>> 
> >>>>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>>>>>> 
> >>>>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>>>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>>>>>> your "expedited switch" improvement.
> >>>>>>> 
> >>>>>> 
> >>>>>> Hi Uladzislau.
> >>>>>> 
> >>>>>> Had a discussion on this at LPC, having in kernel solution is likely
> >>>>>> better than having it in userspace.
> >>>>>> 
> >>>>>> - Having it in kernel would make it work across all archs. Why should
> >>>>>> any user wait when one initiates the hotplug.
> >>>>>> 
> >>>>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>>>>> though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>>>>> We will have to repeat the same in each tool.
> >>>>>> 
> >>>>>> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>>>>> we need to fallback to userspace.
> >>>>>> 
> >>>>> Sounds good to me. I agree it is better to bypass parameters.
> >>>> 
> >>>> Another way to make it in-kernel would be to make the RCU normal wake
> >>>> from GP optimization enabled for > 16 CPUs by default.>>
> >>>> I was considering this, but I did not bring it up because I did not
> >>>> know that there are large systems that might benefit from it until now.>
> >>> This would require increasing the scalability of this optimization,
> >>> right?  Or am I thinking of the wrong optimization?  ;-)
> >>> 
> >> Yes I think you are considering the correct one, the concern you have is
> >> regarding large number of wake ups initiated from the GP thread, correct?
> >> 
> >> I was suggesting on the thread, a more dynamic approach where using
> >> synchronize_rcu_normal() until it gets overloaded with requests. One approach
> >> might be to measure the length of the rcu_state.srs_next to detect an overload
> >> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
> >> lightly loaded conditions, default to synchronize_rcu_normal() without checking
> >> for the 16 CPU count.
> >> 
> >> Thoughts?
> > 
> > Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
> > unforgiving of pretty much any form of contention.
> 
> Makes sense. We could also just have a single list but a much smaller threshold for switching synchronize_rcu_normal off.
> 
> That would address the conveyor belt pattern Vishal expressed.

On a system with more than 1,000 CPUs, any single list needs to be handled
extremely carefully to avoid contention of one sort or another.   At that
many CPUs, the default rule is instead "never have just one of anything".
Unless that "just one" is protected by some contention-avoidance scheme,
for example, like the rcu_node tree protects the root rcu_node structure
and the rcu_state structure from contention.

							Thanx, Paul
