Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC1212D8D;
	Wed, 26 Feb 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581404; cv=none; b=BoQwaCiRPkaQMMgTNWGKOkRHScrQxTjo5uzIxMfXaYqF7xqFCWL5hGtP967Fso4PlBGgjRnib2QxFhXMk/RmaV5TI2IZKX1+r5fHwIe7QDXYLJz6n5Wr6EtfYSPg4c++X2NdhSbVYc2jF9HVEgY2xa6GYxvuvNbEhgjvvTj4REU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581404; c=relaxed/simple;
	bh=HmSgbdxGZBRe4WyLHWh09Yz9t+yKtVE7V7CriNOcFvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T77k8Mk2chXyIolcofEY7Svez89uUoy+32zAY/nUo1kRHCbsj5YXx9MomDQdKJF17BfLZkCfjNbyYUszpqTIn6chaBqLwEfiT4nee8tWJfTVT+iUwFFuLr3dAudfabienQKf7Dyc6X1oQuZHDJnyY7hWM8/YZyA/MBAVu67pBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umTgH/Rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umTgH/Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58247C4CED6;
	Wed, 26 Feb 2025 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581403;
	bh=HmSgbdxGZBRe4WyLHWh09Yz9t+yKtVE7V7CriNOcFvs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=umTgH/RpumYXh0bnIVVx87FSdS6j4Ss98FYC7euaoakNdmajpF5KS/uCOb1K8NMSk
	 njFmFVBa9W0kVcIR2J1xsMkZ9R/L2D4Q7eVDRVvLTkJymCNQw0RZJbHOSroicfHgPz
	 1V3l04Z5HCGfeWbD0BpTug38H7erLg/8RLvHvHGFriXWvyi+h3qqNMJtYuvB8LtLps
	 N89bvsSySwK2DzSeVp3D5o4GYzjB/y0CjFBQE2n2gDS4xz5RfY8I+d196a2IRS0jmh
	 CjALlYqQyOMmtGlnUmpAJzlTPSfdGNlG2S1wykkQZDfuXGl6n1HwaeopAODqGk4zDb
	 dmwtn6CHLgcbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA313CE0928; Wed, 26 Feb 2025 06:50:02 -0800 (PST)
Date: Wed, 26 Feb 2025 06:50:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <186b2fd7-587d-4647-bbbf-7f6940de30b4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox>
 <Z78lNRKjLQKigyLw@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78lNRKjLQKigyLw@pc636>

On Wed, Feb 26, 2025 at 03:29:09PM +0100, Uladzislau Rezki wrote:
> On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
> > On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Currently "nfakewriters" parameter can be set to any value but
> > > there is no possibility to adjust it automatically based on how
> > > many CPUs a system has where a test is run on.
> > > 
> > > To address this, if the "nfakewriters" is set to negative it will
> > > be adjusted to num_online_cpus() during torture initialization.
> > > 
> > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index d98b3bd6d91f..f376262532ce 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
> > 
> > IMO, this should also be updated to reflect the possibily to set it negative
> > and hence to number CPUs:
> > 
> > torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
> > 
> You can set it to a negative as well as to number of CPUs or any other
> number.

Joel does have a good point, though.  Could I interest one of you in
updating the Documentation/admin-guide/kernel-parameters.txt entry for
rcutorture.nfakewriters?  The rcutorture.nreaders entry is a decent guide.

							Thanx, Paul
