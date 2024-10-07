Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1D18BB90;
	Mon,  7 Oct 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307396; cv=none; b=AvJ9Ay6S0msgK/1MOGppGMBjqM793gPDs/mD730/ONVuUMVRyEO24IKhdUQaOCAP/Upu5h/ldY/TG0XxP/JBOG0wkYAnDqELXvUj2sYcDgccyPQZoYLOr6qLGHm7B94zv67vlhmL8puomiScs/q7SSVy748y07BPbhbtFQShgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307396; c=relaxed/simple;
	bh=sRmBF0SeDxIe13YKtx2EtfkkIJUtFxsFcv9CqtdHrWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4kjdrNYS/9L7VvBV1iVaUx+kanln1fcO+XoWupLfbDC58YEb5mkE4gL/0IL4hAPyawTYd4XGk12uRFh4epGGkCGakvHb6jet5+mk0zRMyfhwxXXkd9n50riBcvlQ3A2vst2m9jmKBvvr0rpn4e0ckKDq5ruJp0aRd9MkbeTRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AyWYXTwJ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AyWYXTwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728307387;
	bh=sRmBF0SeDxIe13YKtx2EtfkkIJUtFxsFcv9CqtdHrWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AyWYXTwJOIFfM7YA1yH4qyX7HNVcKXqEM4mCxsjzbyARw0JbSu6tFCQQ0Sb+4dlqy
	 jRZPbEZYqmCHCjthBX20tX0mRy5Ep4EtS/oSxnpF5mFsqJAa0Nr3N1cfyV15Kt97HY
	 03gWmio+WUfLakdU6X5Faq04FaFQurydsCXRm96/eynaKzgyDrCQpkB49u8SF37r4Z
	 d0G4N8+u9zBPCTVTTe1QSMYn5JPmledg4ZDThF3pQU2+pym6uXP5Tz9crKGDB4A+3v
	 GqeaJsozz8mnEVjNf6Xa/wGYiPTtoFlSmw6/yhhxd8E2jjW3Il7cDFDXp/ccGZBH4E
	 xyjyfI+YHyiqQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XMfwV3qDnz2kt;
	Mon,  7 Oct 2024 09:23:06 -0400 (EDT)
Message-ID: <b9e83fb9-c413-4b81-be7d-ddd5f670c773@efficios.com>
Date: Mon, 7 Oct 2024 09:21:09 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: David Laight <David.Laight@ACULAB.COM>,
 'Jonas Oberhauser' <jonas.oberhauser@huaweicloud.com>,
 'Alan Stern' <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 "maged.michael@gmail.com" <maged.michael@gmail.com>,
 Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
 "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "lkmm@lists.linux.dev" <lkmm@lists.linux.dev>
References: <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
 <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
 <e39c6e5975f345c4b1a97145e207dee4@AcuMS.aculab.com>
 <68dc00b3-1ca1-42bc-8f1e-78ace10e4d64@rowland.harvard.edu>
 <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
 <6ae2461a-e509-4c4d-8959-ae17eb214419@huaweicloud.com>
 <43788527053542e78001820857445e4d@AcuMS.aculab.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <43788527053542e78001820857445e4d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-07 15:18, David Laight wrote:
> From: Jonas Oberhauser
>> Sent: 07 October 2024 12:55
>>
>> Am 10/3/2024 um 3:23 PM schrieb Mathieu Desnoyers:
>>> What _does_ work however are the following two approaches:
>>>
>>> 1) Perform the equality check on the original variables, creating
>>> new versions (with OPTIMIZER_HIDE_VAR) of both variables for the
>>> rest of their use, therefore making sure the pointer dereference
>>> are not derived from versions of the variables which were compared
>>> with another pointer. (as suggested by Boqun)
>>
>> This should not be guaranteed to work, because right after the
>> comparison the compiler can do b=a, then it doesn't matter how much you
>> hide afterwards.
>>
>> However it might work if you escape the addresses of a and b first, in
>> which case the compiler will not do b=a anymore, but it might force the
>> compiler to put a and b on the stack, which has some performance impact.
> 
> Nope, as pointed out last week, the compiler can move the 'a == b'
> check to before the OPTIMISER_HID_VAR() and then use the same register
> for both of them.

Yes.

> 
>>> 2) Perform the equality check on the versions resulting of hiding
>>> both variables, making sure those versions of the variables are
>>> not dereferenced afterwards. (as suggested by Linus)
> 
> That (and other things) could usefully use:
> #define OPTIMISER_HIDE_VALUE(x) \
> 	({ __auto_type _x = x; OPTIMISER_HIDE_VAR(_x); _x; })
> You'll almost certainly end up with a register-register move
> even if 'x' isn't used afterwards.

Yes.

> 
> The calling could just become:
> 	if (a == OPTIMISER_HIDE_VALUE(b) ...
> since it is likely that you only care about one of the pointers.
> (Actually isn't hiding one of them always enough?)

Linus asked that we hide both inputs, otherwise it's really asking
for trouble in terms of API misuse.

Thanks,

Mathieu

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

