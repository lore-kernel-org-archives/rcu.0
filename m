Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F22063FD;
	Wed, 26 Feb 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593076; cv=none; b=n5IhUBgkByCCBuj2pgaSEOev8NJSPCdY4Rz9p8E/FG7RpKuRxM4crLZpHJ1D1XXuQWFNXxI0/qwXkr8E2QY71RHtDNDzAwvnN0GtnQAovdY3BUfb1EcQJg4qHbVcHQAur/hGERwy+9bRQKmzRx98uJsFsYDocOUoZy6+u6XdwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593076; c=relaxed/simple;
	bh=k9YMZX0DfU8c/uTdxAb90MdvrVC9IpX7UL32YOtzo3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtOf4dWaBCBxpzdtrPqrVZov2kLgSfjH0S5/dR+wRqmHz9t4M+tRSw1vFU/qAuFFEr1CzwyB0uFISTfmC9GbiZ4ES8xK8TEM0KIoltA71Hchv5s8qa98/pQW/IZFFUrB4pWqkroa9ZRRU29223J89X0ke3JMKsGTp5CjsGCCqDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFdpQdUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFdpQdUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B374C4CED6;
	Wed, 26 Feb 2025 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593076;
	bh=k9YMZX0DfU8c/uTdxAb90MdvrVC9IpX7UL32YOtzo3w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PFdpQdUaJE2mTTgcDkyvfL2gFpQTjbuivZVxfftIMDIUTylRvY9IZUOH5zq4JPmvX
	 uYxvnpY0HfIUp34xVJe/1JLEsqi7+rMaDs5zXUtVRTDfmP1MrU4iKXg+edvf8ilu8H
	 Jd12GA6Ozg+Fvvl2jUKMSYAiodCPSdoXuqwA2NjZ/1YFmQYc6lXngBeucAdjgA5Tbv
	 EAGdt1SgYb7w5EFkRNNLoNBsq9XiYMLvM7ETV4sOkA9jPGhY6ynXMZ6Q7nvP9Q1Ypk
	 ImQBx3JaZkmX5hjusxi8OUKKqy1GbrCYyendbYQOiqQMnmPpcERlF0BCshCcZ3QNec
	 bHHGJyf4ITLFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3474CE04E3; Wed, 26 Feb 2025 10:04:35 -0800 (PST)
Date: Wed, 26 Feb 2025 10:04:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 1/3] rcutorture: Allow a negative value for
 nfakewriters
Message-ID: <a3892fc3-f0a7-47d1-a7ea-d82bb7c88d05@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250225110020.59221-1-urezki@gmail.com>
 <20250225212409.GA1807836@joelnvbox>
 <Z78lNRKjLQKigyLw@pc636>
 <a26d4cc5-ff54-4f9f-b2df-aa423c112487@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26d4cc5-ff54-4f9f-b2df-aa423c112487@nvidia.com>

On Wed, Feb 26, 2025 at 12:49:41PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/26/2025 9:29 AM, Uladzislau Rezki wrote:
> > On Tue, Feb 25, 2025 at 04:24:09PM -0500, Joel Fernandes wrote:
> >> On Tue, Feb 25, 2025 at 12:00:18PM +0100, Uladzislau Rezki (Sony) wrote:
> >>> Currently "nfakewriters" parameter can be set to any value but
> >>> there is no possibility to adjust it automatically based on how
> >>> many CPUs a system has where a test is run on.
> >>>
> >>> To address this, if the "nfakewriters" is set to negative it will
> >>> be adjusted to num_online_cpus() during torture initialization.
> >>>
> >>> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>> ---
> >>>  kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
> >>>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >>> index d98b3bd6d91f..f376262532ce 100644
> >>> --- a/kernel/rcu/rcutorture.c
> >>> +++ b/kernel/rcu/rcutorture.c
> >>> @@ -148,6 +148,7 @@ MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
> >>
> >> IMO, this should also be updated to reflect the possibily to set it negative
> >> and hence to number CPUs:
> >>
> >> torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
> >>
> > You can set it to a negative as well as to number of CPUs or any other
> > number.
> Sorry I just meant amend the description to something like "Number of RCU fake
> writer threads (or set to -1 for NR_CPUs)", so user does not have to read code
> to know that (and update the kernel cmdline params document as well).

Should we also adjust the string for nreaders?

							Thanx, Paul
