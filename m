Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569849;
	b=fX6rbibF8KxNx6kVMv4gd57MJMXPRBMJkm1yhOnvNn2DIZWvnigSutiS9PPJG1+4SGy0
	 IE9Is3QaEYD6rXQ7VYJf1KmIReyNhrElxVb+Xp3rhvlY70MIYQuSNGeCc0vtrMf31o8Ph
	 co3Klof3+elEqdtANaRHhA1jFO+fC4HKSkk/7wCyQL7DOqNSHEt5/ibnE7p8PUI81kAkc
	 MQZFyRI9yqwQW+h/X/B9Moc3GNJIro21JDylBk4t6OO7MSYaUYHBk4g2fWCSpDDCESmGm
	 GMH4Rth/LIz5MVsIanvwqxTl1hGOJS7IWowWL4ILtSkBCmAKfMq1ucC1FAf8f4RnryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1rpLIWcyWHAMoTm8HDUZRR/yftBEok5XqQa7jTiyf8Q=;
	b=4H/nft48HpgMvex0YGh6YvbDX4bgLNG/Vyz3Arwje8py3j9jA2SVZslvLadRCvxqvM2E
	 bmVmwRmVvUDaia7sypfdl78owLTsnbpfSf69h155rCzL46RgEskUnr2MCd2m1y7e20zgt
	 a35vy0rPzJzA/O0AxSFFNHCohRCsZdJV6+gczXePFbkxyfnpnjqYc3Yw9Et8Vp3jMNWE1
	 2FyDM6FjjAQBqbWCN5/Xkf3XLtIYTn/QFSqRRGdjOCuRk0squz1jkUklrDb3nUy//iZU2
	 tOWDA3DY5BdecIMjPs5JgmNGlxtxpfcnhzYvJbC350qP/uUcASNCkF/MvTCZy6j9HMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Fbwn3Tr+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D9606A324;
	Sun,  1 Nov 2026 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Fbwn3Tr+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C01F00A02;
	Sun,  1 Nov 2026 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793569848;
	bh=1rpLIWcyWHAMoTm8HDUZRR/yftBEok5XqQa7jTiyf8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fbwn3Tr+FrE2+twWvc96h6eL4CmfV+55YRhlwCU67jh+2ijXjc+sS1d6Vs72iSVnt
	 9pThhklCkVEpSZevtZfIcg1fa6R/6r51jf56V4MNhNwT1CtWLVsdiI92zpPMX2BsIT
	 tczuWds92tQZEf8i+WAhNaHBo8mIGCmU9QZMuCAM=
Date: Sun, 1 Nov 2026 13:50:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, kasong@tencent.com,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/mglru: cache the last memcg node, make tail
 insertion constant time
Message-Id: <20261101135047.61fc3f209b3235ed6fc96183@linux-foundation.org>
In-Reply-To: <CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com>
References: <20261012205447.2717801-1-max.kellermann@ionos.com>
	<20261012205447.2717801-4-max.kellermann@ionos.com>
	<a64f6a98-de70-4004-aac0-312cb05aaf92@linux.dev>
	<CAKPOu+83bH2CRtiAio+1VTTQrYFF9th5XfG5wL45ujEavPS3Dg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 05:58:28 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> On Wed, Oct 14, 2026 at 5:31 AM Ridong Chen <ridong.chen@linux.dev> wrote:
> > I've also submitted an RFC patch that addresses this issue.
> 
> Oh, interesting!  I did not know but your patch, but it looks very
> similar to mine (but without the hlist_nulls refactoring so yours
> comes with some code duplicating the hlist_nulls header).
> 
> Too bad your RFC went nowhere, that would have saved us from a
> production incident...  Anyway, even if neither gets merged, I'll keep
> my patches on our internal kernel fork, because they do help a lot
> with our workload.

hm, this was a bit of a fail, sorry about that.

We had a fairly modest RFC-stage patch which would have addressed the
issues you've encountered in 6.18.x.  That got waylaid into more
ambitious re-engineering project which wouldn't have been backportable
and now this series which also won't be backportable.

So.  Can someone please propose a nice simple quick-fix which we can
backport into the -stable stream while we work on the larger
rearchitecting projects?

I think that might be Max's [5/5]?  Max, do you know whether that patch
alone will fix up 6.18.x, or do we also need to addressed that lengthy
spinlocked tail insertion?

If you think [5/5] is sufficient for -stable then please propose that as
a standalone cc:stable thing then we can look at the broader changes on
top.

