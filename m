Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B71D0E27;
	Fri, 24 Jan 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740168; cv=none; b=rsmG56cUgJlbxveVhBWEzQPdyea582yuFN2iCWMt1y/J3F0QteiuTuJ31VuySVM9CKdM4AFY+OFUEOeOKEw4x0tvmfnoQD4U8PRO6ytSrqFigwXun5LDJ6auGNK2pN6Rso6D6CmIRpg813HfX2B6FJVA5OtW7rZuxePsZWpLscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740168; c=relaxed/simple;
	bh=knuY+/lME+LjPKTFspOeQXCR0UATecNAe0qIWJvCMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISqTfQb+hWBRnW92jeUUit1lTpjTJdLg2ckraaea2cfQO8eDfPFSaR+9jxYunqzVxvmAjq+D7lRbj2WP9dCHehrYUty7McgpDjDFyOQi4ck6unrtGntqahkcrNEuiN5K+YjgclcHrBqov4tOfcZw+U1VaFl35iTIg91jhWIvVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmvbnled; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmvbnled"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0562C4CED2;
	Fri, 24 Jan 2025 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737740167;
	bh=knuY+/lME+LjPKTFspOeQXCR0UATecNAe0qIWJvCMOs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PmvbnledFztlIlh6UphFcstf8UhcGPbD/yoeCcp/VnzkLsGlgks4K/bBTlLFeKkOj
	 llfdEn3KSqoy0I0Xj71PdYOlIOB37f60dja9BsMzmP1vjkM7Cpj2FFG8QpFM2390em
	 pU4kwhXFEG1aLx0YdH0AYIUYVFjma+gej2bhabJXyEgrR8HxrYrByB5z86wq0eKPjT
	 VHhElIwS7L/PhQuveMN0ztEDplct3ftnQ09FLANZYkeYhC9Ttfrf5ebP4NHgHQPK9p
	 dlv0ayr6AAW/NdAY9sidzGXfWNzcdgO+IRCIP4z36V6aftUvQcQwo8igSdy0+D3F7+
	 Wj1kH6vheLfJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7FBC7CE11CD; Fri, 24 Jan 2025 09:36:07 -0800 (PST)
Date: Fri, 24 Jan 2025 09:36:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5PMGlDb489VEZ7S@pc636>

On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > This configuration specifies the maximum number of CPUs which
> > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > something higher.
> > > > > 
> > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > the torture test on as many CPUs as many system has.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > You should be able to override this on the kvm.sh command line by
> > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > For example, see the torture.sh querying the system's number of CPUs
> > > > and then specifying it to a number of tests.
> > > > 
> > > > Or am I missing something here?
> > > > 
> > > It took me a while to understand what happens. Apparently there is this
> > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > you need to know about that. I have not expected that.
> > > 
> > > Therefore i removed it from the configuration because i have not found
> > > a good explanation why we need. It is confusing instead :)
> > 
> > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > TREE05, won't each instance of TREE05 consume a full system, for a total
> > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > command line, but that would affect all the scenarios, not just TREE05.
> > Including (say) TINY01, where I believe that it would cause kvm.sh
> > to complain about a Kconfig conflict.
> > 
> > Hence me not being in favor of this change.  ;-)
> > 
> > Is there another way to make things work for both situations?
> > 
> OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> need more CPUs for TREE05.
> 
> I will not resist, we just drop this patch :)

Thank you!

The bug you are chasing happens when a given synchonize_rcu() interacts
with RCU readers, correct?

In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
interacts with rcu_torture_reader().  So my guess is that running
many small TREE05 guest OSes would reproduce this bug more quickly.
So instead of this:

	--kconfig CONFIG_NR_CPUS=128

Do this:

	--configs "16*TREE05"

Or maybe even this:

	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4

Thoughts?

							Thanx, Paul
