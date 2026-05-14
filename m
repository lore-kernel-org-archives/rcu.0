Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF33A168E;
	Thu, 14 May 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751596; cv=none; b=MQGkQnIwn2/s0uVUvNqRXZ4Kr6a/+Z1i2Ue/UuQzvyc5l48NvN+Yp7Jzq1viNtu9flXHWmWXsdtcrS4EAvubsDfvYJixsnSZJqn4EL3X4EwcyGvfPKLzJHoZ4B54KvWl4yVvbt/nsqzlG8o1Wpgy6MIrCGJyEYYSPL/RvkIeg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751596; c=relaxed/simple;
	bh=DHcx3aovbP+JoCVxu3/iNaP1b/668QSCA4X5z26cpnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIzsj+LclrZrZhZUStAVeKXx44mPOE6KqX0j2kUqNDP8x6hr3VSZaTCz2b+dSpMFCQG+7b+qTYeCfNgX8cVjLACOpPc6jhcFvdu4YLsYDxbENzSqry2Z8jJQYRWtlIOFlKba9gBnnESdHYROhbCJI+bY2BOFCzBuaFNmSGdxNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrHn2EdG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrHn2EdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8FC2BCB3;
	Thu, 14 May 2026 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778751595;
	bh=DHcx3aovbP+JoCVxu3/iNaP1b/668QSCA4X5z26cpnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DrHn2EdGsspMBh2RrrWhrLAljxmtslTNgsHeSXvJBMB18gfDiPJ9Td2Y2IK4xZhQA
	 qE5HLJfeiXZvmedFAy3Xq0KzPIhPda8LnVsrr2x+oleaVOD3e1VqvoznttLj6HwRg8
	 QU003yTYN8bFfcxsrtXob/WbfqeQ4Rm38L9bqcgYyL/us3X7VzjJM/82HhNjEyuVe7
	 +DEQH+q8xgTwYiVN7VanG2hA2bbJ6amG6GUexo1H371Qohsk44afdjzfT9gI8y0flM
	 8zWpEk8CyFmyc7xp/Qj1jOdUCe2fcZmFnPjKt/+z17RAEa6kmUdrTmErS2C32d2Lfs
	 mS3Ia8T0nivgQ==
Message-ID: <be7a2a06-cd81-446c-9875-fafb198caf78@kernel.org>
Date: Thu, 14 May 2026 11:39:50 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>, Levi Zim <i@kxxt.dev>
Cc: linux-mm@kvack.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
 <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
 <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>
 <2dhbxmhg4l35gupk3wgwtufsf735rnk4czmcoyspzckvexie3z@nswohkoipx44>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <2dhbxmhg4l35gupk3wgwtufsf735rnk4czmcoyspzckvexie3z@nswohkoipx44>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 11:25, Harry Yoo (Oracle) wrote:
> On Wed, May 13, 2026 at 09:34:01PM +0800, Levi Zim wrote:
>> On 5/13/26 9:42 AM, Harry Yoo (Oracle) wrote:
>> > On Tue, May 12, 2026 at 09:46:33PM +0800, Levi Zim wrote:
>> >> I don't know how could we fix it otherwise after removing BPF memory allocator completely.
>> >> Could we find a path to move forward without causing regressions on architectures without HAVE_CMPXCHG_DOUBLE?
>> > 
>> > Probably we can. Could you please see if this works for you?
>> > 
>> > https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log/?h=slab-kmalloc-nolock-without-cmpxchg-double-rfc-v1r1-wip
>> 
>> Thanks a lot! I tested it and could confirm that it could fix the failure of
>> bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE) on riscv64.
> 
> Thanks for confirming!
> 
> I will add this to TODO and post them and Cc you when submitting it to
> the mailing list.
> 
>> The commit message says that the allocation may still fail if the slab lock
>> acquisition fails upon the first try.
> 
> kmalloc_nolock() can always fail, unfortunately.
> We can only make it less likely to fail.

There's still the fallback to the larger bucket, right?
That pretty much guarantees that if we fail due to a local lock in one
bucket (due to preempting its holder), a local lock in another bucket won't
be locked at the same time.
However if local sheaves are exhausted, we might need a shared lock (barn,
list_lock, slab bit lock when no double cmpxchg) and that might be held by
another cpu in both buckets. But should be very rare.

>> But this is still a great improvement
>> compared to the previous always failing code.
> 
> Yup. Thanks!
> 

