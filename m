Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8F31E112
	for <rcu@vger.kernel.org>; Wed, 27 Aug 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299736; cv=none; b=q4rDC+HI5ITmswPVlT0znLegCIOk6sCsVumpAtGS2wr214Jn+l6109m4+BK34t6fWwAC3XZKmqnwagRT94LrRdadwdGke+urZ2tYc6/tIkAqWpYOwFTPHMlfiv5IwnfmXYdT55S+6EApF3VH0gh3+tWNR/Ukgd8vmPjS4PMs2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299736; c=relaxed/simple;
	bh=vq1R/56sr0pc75ur4fZo1SpR8fFqtryj5Ms4TbSl0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXiXA2owYBmQdjEf4HTuFmd8peSYDpzzDjbHhjIJfxOjwosLDnqi/mTdHHiXBToXKCPAuYKMwig/rwH1drwNcKax1fuH1/3aFDluYSeQWCrM9+zaC/8jNxz82zdTHwMmr2qNXvxWfs7kmZP77MQLhRSq+czSfVzlpX5Pe4WdQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/4Dr3aj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/4Dr3aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A6C4CEEB;
	Wed, 27 Aug 2025 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756299735;
	bh=vq1R/56sr0pc75ur4fZo1SpR8fFqtryj5Ms4TbSl0eo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q/4Dr3ajg4WuNCA8mVArPim1tVR7ZqiXP8hzmrnywAFvl2Ou5CcNqCS1d5KlzIgXC
	 /pjRPfc5oVcn+l30pe9jePmdVC5PwwLW7X15NHrvqlOuD11lrqqENRpGe4t3qPjDGE
	 CZSUCnrUcIm7bHlovOiwdFiLQmoY8FMt72ryVqbrMUJDBWbeuqW+jKwvxmUr7KDCDS
	 d0zxpKGM+T82q6SHHx8qQGbgF9XBVaO2mm4yyPWF+AyaHpY+GBV2VQ4bTPiGVnYeiM
	 4QWVLLUEcSemE9ayZDsjWYvUexL5UUu+9iMblhqeZI2aAjBgDZTm7ToJ05wmLthAHw
	 riJ5L10QNsOVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7D676CE11BD; Wed, 27 Aug 2025 06:02:15 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:02:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: cybersnow_2001@tutamail.com
Cc: Rcu <rcu@vger.kernel.org>, Ankur A Arora <ankur.a.arora@oracle.com>
Subject: Re: Kernel 6.12 RT freeze at boot issue
Message-ID: <0ed65083-7665-45ed-a877-216aa2b9dcfd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <OYco0Vo--F-9@tutamail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OYco0Vo--F-9@tutamail.com>

On Wed, Aug 27, 2025 at 01:56:50AM +0200, cybersnow_2001@tutamail.com wrote:
> Hello,
> 
> Since Kernel 6.12, using PREEMPT_RT, I experience Kernel boot freeze issue. It doesn't kernel panic or any crash log at all.
> I'm using an old laptop IBM Intel Core 2 Duo T7700 Lenovo T61P from 2007 with a Nvidia 8400 integrated card.
> Non-RT kernels work fine.
> 
> So, the freeze issue is random and it doesn't freeze at the same kernel loading position.
> Often, it freeze near The message:
> 
> SMP Bringing Up Secondary CPU (CPU#1)
> OR
> Smpboot x86 Booting SMP configuration
> 
> 
> Do you think it has something to do with this bug? :
> https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/

That bug happened during runtime rather than early boot, so I suspect
that you are seeing something else.  From what I can see the fixes would
not affect early boot, but please feel free to try them out.

							Thanx, Paul
