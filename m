Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B88F66;
	Mon,  5 May 2025 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481524; cv=none; b=W+SJCnc/geEbw/JY/o34lcvAJkHDJgdRMv67fOxdb4oGgrDTJQPokR8YHZ71cotfj/cNmXTaetmxHLXozpb+7oNWJ5JmpVLCo9DOJ1pslDGib9cI3JgwcbY0Rb++sV5seNkdFcNtNtqDVMtSkGK8dhutnqoTW0CCqlOOlpkiYIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481524; c=relaxed/simple;
	bh=CahsuzGP8dclaXFz+knFgcQXHHqAzaQBNmxGDlAkIL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+bYcdk4o1cGmjbN9VreKXxQNiDLfPmyQsce3Q/KwOQTJiAqb7Pgpgy+QOD4r0/9KuYaxx6B+zIiFpqs1A0VZETl/n1FaQ9KQ3QWvQfIMMVTuKzysut9SBjLSjnM3v5GkkGibCXCO6vCBTbK/wiBMFq5iB+Iz2ii9f/Fi0wXq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtwYcLYX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtwYcLYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FB1C4CEE4;
	Mon,  5 May 2025 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746481523;
	bh=CahsuzGP8dclaXFz+knFgcQXHHqAzaQBNmxGDlAkIL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtwYcLYXjRqNIOVkspHeOA5jcmAG+AI8w7iuDC5UjI4oGeiCVtujq4P3SWD55vpR9
	 AiMkCnNN+cKeI62Wy8C7Jf7QTwl1IZVTFlwWxnGc0PNr7OMwMoV+smjMRdwBC4YTXF
	 WeK84DGTx47JfYOXV5NeRl4sZ+IdYLDgoH55pdCKaRWvOjNVmLJH3WsiTaAFm9PHCQ
	 w37PNHSwKHv1kiS1o6LCBJZ7NiwwjZ3TimmbQKzLB08nIOUO/gRbLDBfIVY+Xtqde2
	 i6ZbrRB8j0yj+7tpAMiWEX0LEZp6c9lYWNuxNbaMSGx9ws+mOtS0ehv543wm220phy
	 frWnZlgAMAVIg==
Date: Mon, 5 May 2025 23:45:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
	neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Add Safe checks for access offloaded rdp
Message-ID: <aBkxcKPYOPCvfN7J@pavilion.home>
References: <20250428095403.22889-1-qiang.zhang1211@gmail.com>
 <aA9U9QvB2t2MLuU2@pavilion.home>
 <CALm+0cW2tXM-HvzoMsNBk4DNyZ-LuUkGj5M4wVLJixSvUDP+Dw@mail.gmail.com>
 <b1d6d155-de0a-4715-9de6-45d3d9e5c9a6@nvidia.com>
 <CALm+0cUx2siBvaRYwWGsN21PC=UUUy1EqLTRe5HmRW2ECWtUWA@mail.gmail.com>
 <2c8098f0-2010-4714-97ca-7f46629d67f8@nvidia.com>
 <6dc114e4-83d3-40ff-9642-114552f40a75@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dc114e4-83d3-40ff-9642-114552f40a75@nvidia.com>

Le Mon, May 05, 2025 at 09:38:02AM -0400, Joel Fernandes a écrit :
> Frederic, there are a couple of ways we can move forward hear. Does the
> softirq_count() approach sound good to you? If yes, I can fixup the patch
> myself.

That approach looks good yes.

> 
> I am also Ok at this point to take it in for 6.16, though I've also stored it in
> my rcu/dev branch for Neeraj's 6.17 PR, just in case :)

I'm fine either way. To me it's neither too late nor too early :-)

Thanks.

> 
>  - Joel
> 
> 

-- 
Frederic Weisbecker
SUSE Labs
