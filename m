Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A801DED59;
	Mon, 28 Oct 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134288; cv=none; b=odLV3VT9r440f7zYPBShBdhK7vwuoYeyQNA80T2TZOA3diMi5JXHY9su09y+lVg1WvhvPmKPolNMk5lIQb+KixG4L/g78ZGdATxYLqbSJMo6aiIy04l+A+A2gRZ0JX1LbDRBgK/PbDrNMrzfaBad+5ZwBw6w/uNAk67XwAI2FaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134288; c=relaxed/simple;
	bh=1NN6ffzBZ/igF1kFakQ8HkvRhIcxRSm7pDv+OvVYx0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvqunpMVT1XqgfVtpHPGntsCXS3ecpARBM43EenJQxgNhdM5GjoZGo8boPMUvX/yLG3jr6uGMErG40k06bv5/W2EbrCubnQKSvEFrCA4vGNe4kNxay0JLgwV/QvbrKIFtqPqlDVdoCC01fEdTAXh4JwmlSuh7BYnJgnDuA06n3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulz0SehD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulz0SehD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AACC4CEC3;
	Mon, 28 Oct 2024 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134287;
	bh=1NN6ffzBZ/igF1kFakQ8HkvRhIcxRSm7pDv+OvVYx0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ulz0SehDvLJIXyXX70iE/KyUF6ovsP8i9NemHlOJ/FPq/adoNoCGEOEu22i3mHcIG
	 7F0/NA3cIVN+2rmVLlsWXmfavq4NZAr0HPlO/zUaKcaCUN+35I+ehq2zYp6jl0wl/v
	 wcDlftVqvj0ofdaJs25MUnMZNjeA34JCLhB3QufFzmNQ8T91TLT5JFRry9H831hfmj
	 1UaLDYmIJJAf9vlvyB538lk3+mMvPgWDU2GDTAnu+LAwzKL6D2jGKL2titbTLyKwQR
	 zP448Hf9OphVMkM+jui0kZbnvWrGaP8j4x0Lnd5ZRNX/hzV7x/R/YEmqQjfjvW4nzT
	 9QgHn5p26HmRQ==
Date: Mon, 28 Oct 2024 17:51:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Will Deacon <will@kernel.org>
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
Message-ID: <Zx_BDLUDmL-3tLtd@localhost.localdomain>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
 <20241008105434.GA9243@willie-the-truck>
 <Zw5yx6huZvQ5r71_@localhost.localdomain>
 <20241028162514.GA2709@willie-the-truck>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028162514.GA2709@willie-the-truck>

Le Mon, Oct 28, 2024 at 04:25:15PM +0000, Will Deacon a écrit :
> > If nohz_full= isn't used then
> > it's cpu_possible_mask). If there is a housekeeping CPU supporting el0 32bits
> > then it will be disallowed to be ever offlined. But if the first mismatching
> > CPU supporting el0 that pops up is not housekeeping then we may end up
> > with that CPU disallowed to be offlined + later if a housekeeping CPU appears
> > that also supports 32bits el0 will also be disallowed to be offlined. Ideally
> > it should turn back the previous CPU to be offlinable but there may be
> > other things that have forbidden that CPU to be offline so...
> 
> I'd have thought the bigger problem would be if the set of nohz_full=
> CPUs was defined as the set of CPUs that support 32-bit. In that case,
> executing a 32-bit task will give the scheduler no choice but to run
> the task on a !housekeeping core.

Right.

> 
> So perhaps we could turn this on its head and explicitly mark the first
> 32-bit capable CPU as a housekeeping core when the mismatched mode is
> enabled? We're already preventing CPU hotplug for the thing, so it's
> "special" already. If that conflicts with the nohz_full_option, we can
> emit a warning message that we're overriding it. I think that's ok, as
> the user will have had to specify 'allow_mismatched_32bit_el0' as well.

It's very complicated to revert a CPU once it is set as nohz_full. But we can
retain a 32 bits capable nohz_full CPU from offlining until we finally find
a non-nohz_full 2bits capable CPU. I was about to repost the whole kthread
patchset but lemme post just the specific bits of interests here, it's "just"
two patches.

Thanks.
