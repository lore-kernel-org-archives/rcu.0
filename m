Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1628370;
	Thu,  3 Oct 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978564; cv=none; b=F61xVEL+lEC1fN5sXEQs+dnBkWMzlqvFTzqjKo/9+hqGAagDVN05oi6BKg/y4HloB/yV2ZQOu9c7psu1gtA0Hi8AmzAPHBoKEf8gC5nq7tXsiNdCdwKukmDdu0UksI0+YOlXHUJXnx4qxbtVefdA7mLTjQCZrRnkcGJ7yGDWr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978564; c=relaxed/simple;
	bh=HNpqj2LAI7uBi+EmJxWZgOWPeLGVvAZIHpXsFU6OCzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WshRRNjifpWtZW7BCeoQ2GDcwEzjOppsxul8ojWXurdCAU7lo5uUVQCxHDGrdHSDgOr2zCISQUM51ZwebXGT/dMmYWBzmqKrn3Mq0EGZQxR7RoCn8Av6CpwzkZ6Cjh+K6xNF9QOcXsd8KTyUuAkxgY+TRrW9OrOunSPJ4a/bo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EsuFjsfi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EsuFjsfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727978561;
	bh=HNpqj2LAI7uBi+EmJxWZgOWPeLGVvAZIHpXsFU6OCzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EsuFjsfi0tJGARLyFENnM/KPllKTKVUFOqXqIvZ96lFuTElWnaRQoZ5ie9s4M5lu2
	 bkJJ3HEyZTmzyQDPN5IZ7eh4rr3s25Dtq/+QxQyzbcXDGdM8gcFXLlwoszavHm4H+s
	 N1oqU8jfxwGLKL5o6MHY5LAtIrkMY5WoMGX/3PRGoEPi6Te/UXlGtWU1b/93LM6+pr
	 wDvgAFFplTe90z7+N/CrPFT97TQRGYDH3ZtpKY9P/rVoO0g6nflOoBM49lssmWN6q3
	 M+gvN6ikw279UQ0Hf1Vxuw0wcmWS/Op3Lj3JTn/DcsZeXlxVMSUq4VT78vgjIzjK7g
	 RdiolnQ52ILsQ==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKKJx1Q9yz78q;
	Thu,  3 Oct 2024 14:02:41 -0400 (EDT)
Message-ID: <c1fbec54-a2e3-418b-b1fb-14fd16092613@efficios.com>
Date: Thu, 3 Oct 2024 14:00:40 -0400
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
 'Alan Stern' <stern@rowland.harvard.edu>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 <498f11de5a024f0ca0b70aba4e28b17b@AcuMS.aculab.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <498f11de5a024f0ca0b70aba4e28b17b@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-03 19:07, David Laight wrote:
> ...
>> What _does_ work however are the following two approaches:
>>
>> 1) Perform the equality check on the original variables, creating
>> new versions (with OPTIMIZER_HIDE_VAR) of both variables for the
>> rest of their use, therefore making sure the pointer dereference
>> are not derived from versions of the variables which were compared
>> with another pointer. (as suggested by Boqun)
> 
> If that is
> 	a1 = a; OPTIMISER_HIDE_VAR(a1);
> 	b1 = b; OPTIMISER_HIDE_BAR(b1);
> 	if (a != b}
> 		return;
> 	// code using a1 and b1
> then can't the compiler first flip it to:
> 	if (a != b)
> 		return;
> 	a1 = a; OPTIMISER_HIDE_VAR(a1);
> 	b1 = b; OPTIMISER_HIDE_VAR(b1);
> and then replace the last line with:
> 	b1 = a; OPTIMISER_HIDE_VAR(b1);
> which isn't intended at all.

Good point, so I suspect Boqun's ADDRESS_EQ() suggestion did not work:

https://lore.kernel.org/lkml/ZvX12_1mK8983cXm@boqun-archlinux/
> 		
> 	
> OTOH if you do:
> 	a1 = a; OPTIMISER_HIDE_VAR(a1);
> 	b1 = b; OPTIMISER_HIDE_VAR(b1);
> 	if (a1 != b1)
> 		return;
> 	// code using a and b
> (which I think is)

This is in line with Linus' suggestion, which is the approach I
retained.

> 
>> 2) Perform the equality check on the versions resulting of hiding
>> both variables, making sure those versions of the variables are
>> not dereferenced afterwards. (as suggested by Linus)
> 
> then the compiler can't possibly reverse the asm blocks.

Indeed.

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

