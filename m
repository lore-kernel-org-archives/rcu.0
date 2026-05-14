Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BE299944;
	Thu, 14 May 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768806; cv=none; b=E2hgcoA/T5CTLXq0j9lZUn98Vtgf11jtF6CFQEAZCZE1IcT+FUafUmY85pakDiunsxf0aZjcOQh0BOF0oeQOBBiqNraBCABjz6BGvYUBckQVyH3Nf9WdWMKs2aZolT9LJnWt1253qY+zMfWWJUllPoIwmynISMOD44MXJNnSjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768806; c=relaxed/simple;
	bh=wdU4t01p2N+3SdPkNhh5voaN25uhvmS7W5q3TIzmMXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vjl1KjnceIER/jy3LP+/g1726CmvxMy6hdJKmUxARAQLho171qZBcaBHXXqt4Z2U/YxM61BmRdVo9qRjv2v244yzsfGX3w+vFIYaZq5zlyzLNsbZwba4ZdkerIvcb1w05JMlSW0pJD6AE9lh9Dq2FxvSznwhL7Z9/kszkfVY4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzH7RFkV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzH7RFkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA83C2BCB3;
	Thu, 14 May 2026 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768805;
	bh=wdU4t01p2N+3SdPkNhh5voaN25uhvmS7W5q3TIzmMXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OzH7RFkV4ENIRU8JkpGeh1mV+DeWUK1kl3bZCJKkKsAn5f1qWrv/eu7dZa0XVgpVe
	 zMXC2xohdUNvVkiYPQqYS94ctD9tBccYKWY5e+VZAnpvAD5chPqYhGDrWy1rj2tKhr
	 yIU+vFoxiZsFvnz3ViwQ0luGRECUp7ITZBWEyT/490u1PuELXXw4Rv16vQi5vV8lMK
	 ac+ZaQi7usmdVVWjiQ76KP9FmS2EABqnqTKkOM1L7QyPUxy8rIU8V+xnTOesUjmZSK
	 NKE2j023QSqTCD6SFDQW8fAii5F1uN9iMsTXMCVlzBgcCo7ZBx2pxeoNepPLPf/gyN
	 Y7XiLAycwJDXw==
Message-ID: <d015da7b-fe08-40e8-b14d-2e012cce3684@kernel.org>
Date: Thu, 14 May 2026 16:26:40 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Levi Zim <i@kxxt.dev>, linux-mm@kvack.org, rcu@vger.kernel.org,
 bpf@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
 <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
 <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>
 <2dhbxmhg4l35gupk3wgwtufsf735rnk4czmcoyspzckvexie3z@nswohkoipx44>
 <be7a2a06-cd81-446c-9875-fafb198caf78@kernel.org>
 <3aza75jldxj4g3o4kqdif3hubsnzkv53jvj52y2crohfxzto74@ofzzq2wfc4tz>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <3aza75jldxj4g3o4kqdif3hubsnzkv53jvj52y2crohfxzto74@ofzzq2wfc4tz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 12:09, Harry Yoo (Oracle) wrote:
> On Thu, May 14, 2026 at 11:39:50AM +0200, Vlastimil Babka (SUSE) wrote:
>> There's still the fallback to the larger bucket, right?
>> That pretty much guarantees that if we fail due to a local lock in one
>> bucket (due to preempting its holder), a local lock in another bucket won't
>> be locked at the same time.
> 
> Right.
> 
>> However if local sheaves are exhausted, we might need a shared lock (barn,
>> list_lock, slab bit lock when no double cmpxchg) and that might be held by
>> another cpu in both buckets. But should be very rare.
> 
> I'm not sure what makes trylock failure on a list_lock rare?

That we can retry on different bucket. But maybe reality is different than
my hopes.

> When the local sheaves are exhausted, we're relying on either:
> 
> 1) another kmalloc or buddy user on that CPU (w/ allow_spin = true)
>    refills the local sheaves or PCP 
> 
> 2) trylock on list_lock or zone->lock succeeds
> 
> Without async refills unlike the BPF memory allocator.

Maybe we'll need those for sheaves at some point? Hope not.
