Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18A1C2DC9;
	Fri, 27 Sep 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467472; cv=none; b=NOGISc4fJ7Zs6rzflwfWB+BKvC7TLIMBTDm3v9Eo5DHkfcx0QqbHaJZ9NpWpjzzfNZBNLWJpoQA/NlRSfpDTlMXzgJhQA1VJwfjSTpy+3PJyF/yaSKIlZFY5rkeJ+12svxhcQLb0GULonyRK9tt375iiIYn3YuleWMSshWULE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467472; c=relaxed/simple;
	bh=ZyzKzMwioxUsX4rJkQ2DEpZ6Xf1fCqB/veO3g/+mn2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7kwWSZS+bm0erxP4kErRtI6eLrtzkSO96U9yju2se2UrAUUKYsuRtbmx2r5lBtMO+B60AOsEUQXzfiohI7OhGJbLvyyxBrzBflr+JoE+lgorijBsC8CdjeJRZXgJ0p0RjRR3P3dgxW0aMgGaetQjIti/c9605VF8PccOaV7fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JcEpl4Wq; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JcEpl4Wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727467469;
	bh=ZyzKzMwioxUsX4rJkQ2DEpZ6Xf1fCqB/veO3g/+mn2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JcEpl4WqXJQjtF7BSqtzi1zilLR2MrFkyOxiVUGDqxv8V3U03iUURCDM5spMotSCg
	 QqUmZi3N43WlhwYtWnD4h2gnI5VmRpPEk3CxxXDE2j8a+N3aJf3s9awSpB/WkFd4ha
	 9nuDa4+6eO3Yem7kTKf4UY9k4ffQ1VRIgBYCxXxJYwngUHAXOnvRnbWWMn2x70B95z
	 /6tWt72V64np4nqgU79JBLw1F9+lrQ8PPisaFdeAJp7GE7TBQR5zLEc97n2bEunijt
	 0tpbWEybDD2eWSgOhoACJo2nuii7Xt2V87y0SuQU/U8+JKe9TmfGmm4h3rpuHyJWbB
	 4r1csMNzskdRA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFhJF1W9xz1RH7;
	Fri, 27 Sep 2024 16:04:29 -0400 (EDT)
Message-ID: <8b45d5bd-b36d-4703-8a75-81e6bc871a9b@efficios.com>
Date: Fri, 27 Sep 2024 16:02:24 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
 <CAHk-=wgQyXOt_HjDZHNqWMmyvv74xLAcMw88grfp4HkKoS2vLw@mail.gmail.com>
 <7e1c8a5e-c110-414c-8fb2-022eacc2bd4a@efficios.com>
 <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
 <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
 <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wi_hz8Whs2ogRUQEfMBk=OkZ3usmvJkzb5YyEKwqEJBmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 20:13, Linus Torvalds wrote:
> On Fri, 27 Sept 2024 at 10:53, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>>>    (b) the value barrier needs to be on *both* values so that the order
>>> of the equality testing doesn't matter.
>>
>> If we use OPTIMIZER_HIDE_VAR() on both parameters, it indeed minimizes
>> the odds that someone get the order wrong, but it disallows using
>> ADDRESS_EQ() with a constant parameter
> 
> No it doesn't.
> 
> This is trivial - just hide the source of the *comparison*, so that
> the compiler doesn't know what you are comparing, and can't use it to
> then replace one with the other:
> 
>     static __always_inline bool compare_ptr(const volatile void *a,
> const volatile void *b)
>     {
>          OPTIMIZER_HIDE_VAR(a);
>          OPTIMIZER_HIDE_VAR(b);
>          return a == b;
>     }

Cool! It works! Thanks!

> 
> compares two arbitrary pointer values without allowing the compiler to
> then use the comparison result to use either of the original values as
> a replacement for the other.

Yep. And the static inline is much cleaner as it allows users to pass
constants as well.

> 
> And yes, that "hide both" model will cause a bit more register
> pressure, because the compiler will now compare two values that it
> really thinks are potentially different from the originals. So you'll
> have two "useless" temporaries that contain the same values as the
> source pointers, but if that's the cost of having a comparison that
> the compiler can't see, that's fine.

I've tried it and it seems that the compiler only leaves one "mov"
extra there, since the extra register movement on the input that is
not used afterwards can then be optimized away.

> 
> Making it a bit less obvious, you can hide just one of the variables -
> you don't actually need to hide both m(but for clarity, maybe you want
> to).
 >
 > Because even hiding the value one from the compiler will mean that it
 > can't use the comparison to decide that the originals are equal, even
 > if one of them is unhidden.
 >
 > No?

I would prefer hiding the two input variables.

Hust hiding one variable might work for CSE (and light
godbolt attempts seem to confirm this), but I'm worried that
it eventually breaks when compilers start making SSA GVN
optimizations smarter.

AFAIU, in the SSA GVN model, if we just hide @a before the
comparison and don't hide @b, we'd be in a situation where the
compiler could know that the version of the variable generated
by hiding @a (call it a') is equal to @b, and therefore when using
@b afterward could instead use a', which is derived from @a
rather than @b.

It may not happen in practice just because why would a sane
optimization would prefer using a version that is deeper in
the dependency chain (a') rather than @b, but that would be
based on assumptions on how specific heuristics work, and
would therefore be fragile.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

