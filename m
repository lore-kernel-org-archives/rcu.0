Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB831C1ABC;
	Tue, 19 Nov 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013042; cv=none; b=mXXVSYLwUFxHn00XZkvec/0GeiV3q7L16G3m9xyQ4wYfQ2dgb6nbjT4xJA6BtjOLRwt6IHIEmG0xDmN+tnCNwO6ZhOW4nuEliBPzVbAlsyeP6n3j5rJxC002smlZoBdrQh3DnNmL8JQlX+hrE97Kr0DKwNKDJwn9M6qlnps58oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013042; c=relaxed/simple;
	bh=QipxtI9sgPh0v6Sb4OCkds7xvdtuYriAhhk7Siku4pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc3Y09jQSoomVNhe1XWn7O6R+BCPA+cxKctlc1KmOagBo9mWwB4ChpUE3J8NWZwRNRjvCCXtGq261CXKdlWgLc47ADnkCEJ9D5QjLbM9JTQn0tKvVdjtgPa2mpYVHQE69HYOY9EzC7MEX7V1D5FQSyn6Wn3JXrDuWRQSK9xPjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRz6wpk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRz6wpk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F29C4CECF;
	Tue, 19 Nov 2024 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732013042;
	bh=QipxtI9sgPh0v6Sb4OCkds7xvdtuYriAhhk7Siku4pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRz6wpk3rtAPmqvaU7DQ+zTBeK4L0bQ+TSxqmQivKG8vj7BaZoUqGGuDlhOznXSFN
	 da9p8dWsCH5kUVR9cTD5Uitzy7eH8DUttpTYbn4bULiTqscwEm2Z2GHM+MOPT31sO7
	 l5LvP3c5M1TMnZKHUnbck4a+gPlwbNy6rLDmgufTLd3Sweqt69Z2tsz5o5Pvt9l3rN
	 q1bMWmUB50LKV9TWmCc4/lwd/8KM94XexHoyfb50IH2qq3J2r0E/fXPeeO/0bVvXkY
	 uFhSY4YQciHt5O83ceBXcF5jcptOesyxuZsM9UyIZCdQVmsrdQYYBwf5Qgp/IzMhcO
	 5TNpqayQdPPug==
Date: Tue, 19 Nov 2024 11:43:59 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
	sakiiily@aosc.io, Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
Message-ID: <Zzxr72hkv8DAwjMG@pavilion.home>
References: <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
 <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
 <ZyyQuTfMMSLwStf_@pavilion.home>
 <a7fc57a1a49b5f710c4354ca21c91dba@aosc.io>
 <Zy4WKKq18GunXa6S@localhost.localdomain>
 <814ca9e3-df3b-45ce-ad36-9659b445c499@paulmck-laptop>
 <ZzNPIOR8aaxfrLE2@localhost.localdomain>
 <720576d090304a33b7d9ba3348056717@aosc.io>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720576d090304a33b7d9ba3348056717@aosc.io>

Le Fri, Nov 15, 2024 at 11:01:25AM +0800, Mingcong Bai a écrit :
> Hi Frederic,
> 
> <snip>
> 
> > Just in case, Mingcong Bai can you test the following patch without the
> > revert and see if it triggers something?
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 35949ec1f935..b4f8ed8138d3 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -5170,6 +5170,7 @@ void rcutree_migrate_callbacks(int cpu)
> >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	bool needwake;
> > 
> > +	WARN_ON_ONCE(1);
> >  	if (rcu_rdp_is_offloaded(rdp))
> >  		return;
> > 
> 
> Please find attached the dmesg with your patch (and no revert) against
> 6.12-rc7.

The added WARN_ON_ONCE() doesn't trigger so the function/path changed by this patch
isn't taken.

My only guess is that the patch changes some code layout that makes a bug more
likely to appear in networking...

Thanks.

> 
> Best Regards,
> Mingcong Bai
> 
> > 
> > 
> > Thanks.
> > 
> > > 
> > > 							Thanx, Paul


