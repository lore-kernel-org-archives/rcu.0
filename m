Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAC55E73;
	Mon, 28 Oct 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132721; cv=none; b=Ke/ReL+U0I1CieghtEiuz91bziTeaAZWNrXMIIh5H6INiCsMBH+41raXxieNJ3dQHJlTzEA8xSGhsG4petM/+ACtpj7pyUM4MNokCm3BKPiFZEFDHoLkcLOGKCBepjVg67HDxbkwHJrMsvMCYANYdjbF46NZKh9pCst9BzAaDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132721; c=relaxed/simple;
	bh=+3DwLMWgTV7KQrD4OZVcBB/q7H6IGSRHKbS/THz4Mpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/GAUGQwHjGQteOtiWU7E3st9WZc2/tndjJmaoe9G7wMLJAe9GzmT9LiMC6WfNwkLY2cK7vIU2tJBhcqijN37r//K8xkq4Y8B/fjLgHEN3ydmZBpstc8UZLrDTPEjZC2o4WNB93MEse8L/tTLyPhga7eS1CPvoOr5zgfTMeg9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPf4Ioyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPf4Ioyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E8C4CEC3;
	Mon, 28 Oct 2024 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730132721;
	bh=+3DwLMWgTV7KQrD4OZVcBB/q7H6IGSRHKbS/THz4Mpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPf4Ioyo2XmGoorJFdpvq/TPayIxdalhSEgvBWNsTZ4w09ucnnTW/Z7b9Zsnf2gQE
	 jepTow5jNtoTTezTXPINX6t4kvTm4NY+TIlzYlexEe5LyCog8vtbKCiUDQTYeFrD5U
	 fl9VWx7nKv+4yX8Dks1jlhuLt7c4Cu6Bef3FkLGTC3O+Z8qrTcTM86Eh0SGNAf04RO
	 Gh7LyY56qO/20wRPNl/gj0jRowUkPDxcJy/md68nzB5Nj9XvcZ8TuCNmW7cQaN24xd
	 GscvoE3ieutGLAsMv9gvGxJbmDlG65B4EThy3/sxbIgUo9OVnAswC2u7LKqK8gJSbS
	 mzUMj/9ji+reQ==
Date: Mon, 28 Oct 2024 16:25:15 +0000
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 11/20] sched: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <20241028162514.GA2709@willie-the-truck>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
 <20241008105434.GA9243@willie-the-truck>
 <Zw5yx6huZvQ5r71_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw5yx6huZvQ5r71_@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Frederic,

Thanks for having a crack at this, but I'm pretty confused now so please
prepare for a bunch of silly questions!

On Tue, Oct 15, 2024 at 03:48:55PM +0200, Frederic Weisbecker wrote:
> Le Tue, Oct 08, 2024 at 11:54:35AM +0100, Will Deacon a écrit :
> > On Fri, Sep 27, 2024 at 12:48:59AM +0200, Frederic Weisbecker wrote:
> > > When a kthread or any other task has an affinity mask that is fully
> > > offline or unallowed, the scheduler reaffines the task to all possible
> > > CPUs as a last resort.
> > > 
> > > This default decision doesn't mix up very well with nohz_full CPUs that
> > > are part of the possible cpumask but don't want to be disturbed by
> > > unbound kthreads or even detached pinned user tasks.
> > > 
> > > Make the fallback affinity setting aware of nohz_full. This applies to
> > > all architectures supporting nohz_full except arm32. However this
> > > architecture that overrides the task possible mask is unlikely to be
> > > willing to integrate new development.
> > 
> > I'm not sure I understand this last sentence. The possible mask is
> > overridden for 32-bit tasks on an *arm64* kernel when running on an SoC
> > featuring some CPUs that can execute only 64-bit tasks. Who is unwilling
> > to integrate what?

I should've been clearer in my reply, but I think the most important thing
here for the arm64 heterogeneous SoCs is that we document whatever the
behaviour is in Documentation/arch/arm64/asymmetric-32bit.rst. There are
a few other kernel features that don't play well (e.g. SCHED_DEADLINE),
so it might be sufficient just to call out the limitations relating to
CPU isolation there.

However:

> Will, how does the (untested) following look like? The rationale is that
> we must deal with the fact that CPU supporting 32-bits el0 may appear at
> any time and those may not intersect housekeeping CPUs (housekeeping CPUs
> are CPUs that are not part of nohz_full=.

In the funky SoCs, all CPUs support 64-bit and we have a 64-bit kernel.
Some CPUs additionally support 32-bit but that should only be a concern
for the scheduling of user tasks.

> If nohz_full= isn't used then
> it's cpu_possible_mask). If there is a housekeeping CPU supporting el0 32bits
> then it will be disallowed to be ever offlined. But if the first mismatching
> CPU supporting el0 that pops up is not housekeeping then we may end up
> with that CPU disallowed to be offlined + later if a housekeeping CPU appears
> that also supports 32bits el0 will also be disallowed to be offlined. Ideally
> it should turn back the previous CPU to be offlinable but there may be
> other things that have forbidden that CPU to be offline so...

I'd have thought the bigger problem would be if the set of nohz_full=
CPUs was defined as the set of CPUs that support 32-bit. In that case,
executing a 32-bit task will give the scheduler no choice but to run
the task on a !housekeeping core.

So perhaps we could turn this on its head and explicitly mark the first
32-bit capable CPU as a housekeeping core when the mismatched mode is
enabled? We're already preventing CPU hotplug for the thing, so it's
"special" already. If that conflicts with the nohz_full_option, we can
emit a warning message that we're overriding it. I think that's ok, as
the user will have had to specify 'allow_mismatched_32bit_el0' as well.

Will
