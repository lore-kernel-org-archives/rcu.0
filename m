Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D622E1DEFE1;
	Tue,  8 Oct 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390481; cv=none; b=IPx1F+orxU0K1v8W2G5S1rrFVh+PQXCKZNeasP1iS+z0sk3Ezxoz+XTIQWIp+l2QESpd0hGUuY6neWGFKbxXxpfiM8fWOEJaK4VUzsmiII0NnNLkfANttjXoNMC8DT8fQT/FLX94BtHyO2ipkzdcD6rCw4Ca1kmyKpbvetrX680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390481; c=relaxed/simple;
	bh=nbHT3cP3WYMMqE2TSlw5V5n87tenvgeKw3UFNgYUXGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlGAgL8YbhOrj8mFXwk2zEW1HgMNgt4Wetp3Yz4aBIBqm9X0b/Q3Kkxu3P+lfmWUD52uSTlpNm4rp8O+ZUipFzw5YtdO1oLdoTR1IbIAflnX9O7oV5uN/Ghm5rhARour25YRYzbwmBXvCdo5YK8W5mxErOOBZub5IMRPaCJINRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyW8ajgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyW8ajgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F847C4CEC7;
	Tue,  8 Oct 2024 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390481;
	bh=nbHT3cP3WYMMqE2TSlw5V5n87tenvgeKw3UFNgYUXGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyW8ajgDShLQ+H6+/84eMX1JUOj+NYgGBhwwIMis53pnSBq6KsXkNNJnix2fNfMgU
	 jSmo22rNQNdt1+t/+ITBp03ALkOEA+kP0QtzVqnanhaqh1yPAv3f5rWvIvs4v58nXa
	 s6Ekf6FEAleCIimWt5Iej8ZZWhTWyD8V+dgQSAX8A2RLvi1uAKLA5fT7YlaNDqdz9j
	 0bzDoSezNjJWtOV6zpgTZ6G8SbzAloghFRcyXt/PdrfF/r4KcqbhJO3NTKJLqmlZqV
	 dNXm2bp5Dro7GB6BceECq4KOiGLWu2T3p8r4FYzG6mWTp3Na0SQOORqb5Zbqbu+mth
	 G9yHwXn9I8ycA==
Date: Tue, 8 Oct 2024 14:27:58 +0200
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
Message-ID: <ZwUlTiDpvmb9ysfn@localhost.localdomain>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
 <20241008105434.GA9243@willie-the-truck>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008105434.GA9243@willie-the-truck>

Le Tue, Oct 08, 2024 at 11:54:35AM +0100, Will Deacon a écrit :
> On Fri, Sep 27, 2024 at 12:48:59AM +0200, Frederic Weisbecker wrote:
> > When a kthread or any other task has an affinity mask that is fully
> > offline or unallowed, the scheduler reaffines the task to all possible
> > CPUs as a last resort.
> > 
> > This default decision doesn't mix up very well with nohz_full CPUs that
> > are part of the possible cpumask but don't want to be disturbed by
> > unbound kthreads or even detached pinned user tasks.
> > 
> > Make the fallback affinity setting aware of nohz_full. This applies to
> > all architectures supporting nohz_full except arm32. However this
> > architecture that overrides the task possible mask is unlikely to be
> > willing to integrate new development.
> 
> I'm not sure I understand this last sentence. The possible mask is
> overridden for 32-bit tasks on an *arm64* kernel when running on an SoC
> featuring some CPUs that can execute only 64-bit tasks. Who is unwilling
> to integrate what?

Right I've been lazy on that, assuming that nohz_full is a niche, and
nohz_full on arm 32 bits tasks must be even more a niche. But I can make
it a macro just like task_cpu_possible_mask() so that architectures
can override it?

Thanks.
