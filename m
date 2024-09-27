Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C51C0DEE;
	Fri, 27 Sep 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459591; cv=none; b=kg9+ReXl/DmW8FMzuYLUyU1s1NU6wXFB0oXsQHpImwGnGJyAAyPdZrh6d73ha0y/287KRaoclxLtYAon5a+qkyuaKPXucL7nqQnVmfhjN+QntS4S4xi9tahGK31IhlyJRV8mPNKZBX72aMNFal5L/+1dctRaykszJFdVjDcE9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459591; c=relaxed/simple;
	bh=B95OindKXLVMUgZ0DnE2pN33eeTCKFPMp1bnPOx7T1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKOHXx3q7xOK6sOZBSomL62+ZtlbXNfMwfK0T87N5rCXIgU637yjNYOOwkpPFcMuHywWyGNGoqQh+rROTydGD+2kTuXFs4nD8zAubEIlqjtcL7fLr0y/k2oV9vJRi+syrEBPk1Uc38wYAk/+BZum0n94Phc9dVEhO884gHK2+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lRcJMXoL; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lRcJMXoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727459589;
	bh=B95OindKXLVMUgZ0DnE2pN33eeTCKFPMp1bnPOx7T1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lRcJMXoLNLKyGh1mgeZ4yvB5sYPUBJIkzBwSFoqmXozL/aio3E8vgxH5eySSHkwH1
	 ePW9UBcso2hLuTlELFNcj7j6HUVntd/DLvimpgd0wPcQMujGjWgMAVLVGSuX6QMKxv
	 lb5CG4DYHbKrMF4bMfuIZl4bFNlpas5eUGvQbI8qpEC+CqT1CQU0Nt6yCqBvlGbw6Y
	 J0Wqi1xHk1lstlnjoEKonZhm19XvbnLpAjuvtM1fnS4D+XcbodDHJHzmJ9QMMhmFlF
	 Qpx6qK8y96WD/hOon0SsDwJ/mSPHIYckvXNUf+t5oHEtEq5HagRCrczzCqvLA7wHdl
	 hw4wFDzsDnPjw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFdNh5T6Hz1QLR;
	Fri, 27 Sep 2024 13:53:08 -0400 (EDT)
Message-ID: <34ec590c-b109-44a0-8bfe-8aafc6e7ad64@efficios.com>
Date: Fri, 27 Sep 2024 13:51:04 -0400
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
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
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
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wgBgh5U+dyNaN=+XCdcm2OmgSRbcH4Vbtk8i5ZDGwStSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 19:23, Linus Torvalds wrote:
> On Fri, 27 Sept 2024 at 10:17, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> The barrier() is ineffective at fixing the issue.
>> It does not prevent the compiler CSE from losing the
>> address dependency:
> 
> Ok. Thanks for actually specifying code.
> 
> That needs to be
> 
>   (a) in a comment

OK. I'll add the code/asm examples to the comment above ADDRESS_EQ().

> 
>   (b) the value barrier needs to be on *both* values so that the order
> of the equality testing doesn't matter.

If we use OPTIMIZER_HIDE_VAR() on both parameters, it indeed minimizes
the odds that someone get the order wrong, but it disallows using
ADDRESS_EQ() with a constant parameter
(e.g. ADDRESS_EQ(ptr, &mystruct)), which would be nice to cover. It
works fine with using OPTIMIZER_HIDE_VAR() on the first argument,
but it opens the door to misuses.

Perhaps there is a trick with compiler builtins we could do to only
use OPTIMIZER_HIDE_VAR() on non-constant arguments, but I can't get
it to work so far.

> 
>> I'm preparing a small series that aims to show how a minimal
>> hazard pointer implementation can help improve common scenarios:
> 
> I want actual numbers on real loads. Just so you know.  Not "this can
> help". But "this actually really _does_ help".

Noted, thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

