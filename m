Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B5253359;
	Thu, 14 May 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753380; cv=none; b=scG6/F7/SlMvVjteLUDBC3pN5MD0eDrjkOvOwj+4Wg7Sh30jNJcVjf0ig9W4RQFxMqJn2fS1WE4g1vFNxJ2iKDYgQpvMFD+ug5BcwXD7b6PD0VT0iy9iRYynSKwS+3ATCZWb9uTTVzlBwHsg2R7lb/9lX3kwB4V4QxvSprLvBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753380; c=relaxed/simple;
	bh=NHFi+ZN0DxhqAObytOz95z+znYJzoFR8tNEwrKza858=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suUzOmRNPTv7Z5Ptp/iDpcWkf6ho7SfYMiR6T9Je8KHqgpiAswlnLQcxS2exeC75C0sRNswRNqWHSOBfqISjH/MGSsdQ8pPRKVjaQv+aVKnoNi1cCUBfqLcbgvjKOtY5rN5DpL2FzNRfRsfz8TaInVs5cOCtSOG9lR0x/NtXEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB8ilueI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB8ilueI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6FBC2BCB8;
	Thu, 14 May 2026 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778753379;
	bh=NHFi+ZN0DxhqAObytOz95z+znYJzoFR8tNEwrKza858=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QB8ilueIZ8dtkFqneoDKaezRhf/3GiLsA9b5zMPjGKXGJL+9UR5aC+ARkNkj6ZRnH
	 RclT5APtND4inI+KfpZgMrJQGy25w4H8b8qXH2FR8/EQg4uE73guKww/qBAonDWl5s
	 F/ufNuCEPoOmbMjqVg4nna+qCXMWGXR5W29BQEGn/6t38iFGD9r+9j8GBs9QOAJ8BV
	 FRvWKhKVDCUaG892h+7cHWHaRQPbf/+iSnAMikP5nYNGZgiE/smvfkkzYpn7zVLLAV
	 cusxM4UYYs+AKSXotZyGzXdlgXZFqjhnOJuMKfnjM1+G+eY5M8bHq1PeNjwDg8o7IC
	 0rpPhV8uZegPw==
Date: Thu, 14 May 2026 19:09:37 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Levi Zim <i@kxxt.dev>, linux-mm@kvack.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, Hao Li <hao.li@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Message-ID: <3aza75jldxj4g3o4kqdif3hubsnzkv53jvj52y2crohfxzto74@ofzzq2wfc4tz>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
 <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
 <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>
 <2dhbxmhg4l35gupk3wgwtufsf735rnk4czmcoyspzckvexie3z@nswohkoipx44>
 <be7a2a06-cd81-446c-9875-fafb198caf78@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7a2a06-cd81-446c-9875-fafb198caf78@kernel.org>

On Thu, May 14, 2026 at 11:39:50AM +0200, Vlastimil Babka (SUSE) wrote:
> There's still the fallback to the larger bucket, right?
> That pretty much guarantees that if we fail due to a local lock in one
> bucket (due to preempting its holder), a local lock in another bucket won't
> be locked at the same time.

Right.

> However if local sheaves are exhausted, we might need a shared lock (barn,
> list_lock, slab bit lock when no double cmpxchg) and that might be held by
> another cpu in both buckets. But should be very rare.

I'm not sure what makes trylock failure on a list_lock rare?

When the local sheaves are exhausted, we're relying on either:

1) another kmalloc or buddy user on that CPU (w/ allow_spin = true)
   refills the local sheaves or PCP 

2) trylock on list_lock or zone->lock succeeds

Without async refills unlike the BPF memory allocator.

-- 
Cheers,
Harry / Hyeonggon
