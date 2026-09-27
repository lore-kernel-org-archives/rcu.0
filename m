Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852793B42F0
	for <rcu@vger.kernel.org>; Sun, 27 Sep 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790525715; cv=none; b=JssM8Aa3l5wYZCfWM0ir+IiEc2cc1m/zOHCq4bG4R+X1FEgIqnSn/nGKZLEPo/i4sqXefLwj7FDXQDHpYEUSM+dlGJ7sfPJARnZ3UETiJcMpFnNfVLeacWUnttPBSxZ/MENzpAIMp1bwcQPpYMt7mn79xK9nQAm4xAGLQOL6Woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790525715; c=relaxed/simple;
	bh=4oJJg53K+pxMTNQEe4L9ro/SENc8x0a6mzqI3yQ3F6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl8ZANrI6B8nBESkqh5+CvxAU0h75OmFTZUWGVITUgeWGxQ7w3US7Z5j9ob7aiWh+j0bkppKkcRvrhV+rtaKq3X6YO5eyz4p9lYztJGG/P1WJOx3XDQFJDcnWTVmPyFQWmz7WpV5jabuXmUElVl09Ma/OAVZ8d9oAvHrHa9rVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkea6Q9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkea6Q9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD51F1F00893;
	Sun, 27 Sep 2026 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790525713;
	bh=vZ6H7IiyvYyntVUzvl7HLajMO9G5hhJACQdayaFIY/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kkea6Q9Wq8/u1id3cXaz8IVp2l/eQjjHbNpzUAAoS52zuTgDzfC/478MCcLq6eo59
	 v0+UsBGl6zfQruANm5i9jGnbSBCUB9lFur51f86KOTaNr+rXxXMc5fjBcPu6zNScUV
	 eptle6nd9vhPLqyMGVgBX+GFmH5ogOUp/ZGb+wsYEmdrWXYkZzdwx8c5smE1O/AeaJ
	 luZaHjrvw5+QEyHSR6Y63DbYcsIwl9DEksxqFxnn09YOACOnhhdKsBRGyTj86S0rax
	 xYM3/hZPJFk9Q92hjHf+ncENT95N1WtRW8keabWjYQOYnk+WbPMpcRgCrriX9EFsCo
	 jBBzOWnVNImTA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DCFEFF40067;
	Sun, 27 Sep 2026 12:15:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 27 Sep 2026 12:15:11 -0400
X-ME-Sender: <xms:D0G5asvsIdfWg7Dm_dokaOgGTJLRSd_4Zfm0S7iGUjuiE2VvwGyYmA>
    <xme:D0G5averVkJ_HAmSWX-EJ2G9XxMSR7_jMvdwEr2KRrqhm_KjKKGTORoJm5JuV2XJQ
    pfIFNqlpZk3kEuAK435yNqGlfC-94NajbNqohU5XwPQwt7_ieFEjw>
X-ME-Received: <xmr:D0G5aimL22qY4VC2i40fuDHiyIRONS7siT5tWIp4yNG4VIY8wd2wrlpM3SZi>
X-ME-Proxy-Cause: dmFkZTEDhJ05NPw1hKFdju+RIxwKxN+WpUXjuokIAxOw8xJphL8e97BK22PWt1cML77Gdv
    BTaWIdXHdfjmBhnYw3MYWZLPDm/D/mTRDu1IhExN55zPS1Q45P0oDoG5+ODwWJ8xosDLtN
    DhjlK+CtwqupRcHStv84XfpsxIsWzl92QMBB/wxhfl/Gi1tc/eCoxjtJqMvd4FvJ1LQBmP
    ttw1bKMRTqA0Z7QISW+12A2df5NsN127TlcFBQYuFfMR2/KLTaJpi6d6BVpIW0ihNBzDXL
    MEmm7CgRwEmySBXXZo1fyifWOBK8/PxSVjnhhHnTwiYUN51TQWThvqDp3mAm3DJKrlsbJu
    3t+qhy+C0ZfSFLsXbLMk2w1Nn5GMrwSln+gC6KWqZfHryePx+BsV06rKKT/3vtwShI17Yk
    Lp9iM9J0o4b/PpLzcWcT52km7S/oYOkTuhCI8r0zDaECnX16Pnt6F3ZEW6FvgDHZ2y/Bxx
    weuI90n6RporZG5kUCxgj61dy4hWOmqEzTU6PhxQpawvs2JcLUl7aMW+E/OTwUiL3u/+Jr
    k79+JidQ0U5DCEzmBqnXVECl5MMWbSRv2XccJEJMUYByFzcV7TvVCMXFgSp/neH+/i2tt1
    MSbDNkYRgys6Rq2aZFgezAuLr9v8Z0wdK+WTb0tU83bS3DawFHPNkbM+gtjg
X-ME-Proxy: <xmx:D0G5aiAnv1gA8eRBInB6ihOJwRIfb-9zikYyYKrEi8s7dVIWiGrsKw>
    <xmx:D0G5asMqheFGVqO4YoiuCXha3mG_zSw6CBKjgoOfKHm9FFo_6kfHEQ>
    <xmx:D0G5ahPtWpKk1CZRaAZI8jotszWok9bUr1icDmXzJ7KeT_eSTaN9ng>
    <xmx:D0G5aslGiADyzGkFWYibkSf6mJjvtlgA94BJC2o1kXH1KJHRhqYeyw>
    <xmx:D0G5anuMzy9uKOmwO1UnXTWNi6VWZZQXg6C0W23Nhd9nKnnBWzC1Zz2A>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 12:15:11 -0400 (EDT)
Date: Sun, 27 Sep 2026 18:15:09 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
Message-ID: <arlBDX_907OBM5WY@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>

On Sun, Sep 27, 2026 at 11:51:27AM -0400, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> This series applies on top of "hazptr: handle NULL address in
> hazptr_detach" you have in your rcu dev tree.
> 
> This first patch addresses a race identified by Boqun Feng in the
> two-phase wildcard scheme.
> 

Thank you! That looks good from a quick look. I will give a deep look
later on (I was traveling).

For the following versions/patches, could you also Cc Kuwu Chan and
Liang Wang (Cced) ? They are helping on the scan thread and lockdep
integration, so it'll be good to keep them in the loop. Thank you!

> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
> Those were discussed at length in a prior version of hazard pointer
> patches.
> 
> Patch 4 introduces a "try acquire" helper to allow the fast path
> to not rely on wildcards, while keeping the wildcard forward
> progress guarantees in the acquire slow path, used on fast path
> failure.
> 

Nice! I want to point out that later on if the reader can handle the
race with the updater (i.e. the readers don't need the progress
guarantees from hazptr, then we can expose a hazptr_try_acquire() for
exactly that). Although I do have some design trade-off questions for
patch 4.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (4):
>   hazptr: Fix two-phase hazptr_synchronize race with detach
>   compiler.h: Introduce ptr_eq() to preserve address dependency
>   Documentation: RCU: Refer to ptr_eq()
>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> 
>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>  include/linux/compiler.h              |  63 ++++++++++++
>  include/linux/hazptr.h                |  47 +++++----
>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
>  4 files changed, 203 insertions(+), 80 deletions(-)
> 
> -- 
> 2.43.0
> 
