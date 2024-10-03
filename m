Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CF186E46;
	Thu,  3 Oct 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961946; cv=none; b=KBgShGdJ7b0gmtJqecf1zny11UtXMvF+agtuJfGdqSYZd7y0fYEseF70EvwrvF9ZhgZ2dKcUI3ca1+NSDImAnaPV7aQ1JqBsSuCCES/T5nxz8Ftk950Rf1V9nPYx/AohnoygJ/AhphMForWWt2F0CHUdSI3U3WLDNr37sDcFuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961946; c=relaxed/simple;
	bh=0Bq3tDtnRpX1pbJsNPejO+Bs7zMzKXxBWm7bWQUcwiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuFCUiXeDQCuxuCr9Bqn9EFqOe9Xj1Eyq59VL+p0+xuT5ir2nVEOlZUGNcsbFfbdAKSScIg4uktvyduAikXTrY41fTJGFz5y2iZu4FWKiH8YqDviSdsV7EutZfeR+y/7YrTcmn11nagjPBPnOmiCIl3AIMTjbDeU+Bg/yqoMor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wP35DN2E; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wP35DN2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727961933;
	bh=0Bq3tDtnRpX1pbJsNPejO+Bs7zMzKXxBWm7bWQUcwiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wP35DN2EtpOm07PoWCz0T0mMaUcxto2ytWDs1yziiOGWC+j+FxhxOq3eC1qy+b9q+
	 qLO1bAlnX0N0Zlw1ZGvD7iJMGAVGLmou2zQdfOP+pWMZ4h+xNjWqdvt3jRp/enzwQk
	 tofficLJX+6zWFrzrnXzjz0qiwslONzUNtSt9nQyznJ6Kp3/nJlxI0jmloXbEAzF1S
	 0cCdDSKfA/epuSKCZuuT0eGajBd0gPVIJsWlRUiN5aVMbhR58+K6sTuUyNOwS3R8Z8
	 tj16vbvLgKlkiEk7Y4D2WThHi3pO1STu+DDdJHFH3vL30MOwt/bNO6KWSxegxqIWhT
	 7Z6AB4hAYPUcg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKC992Gdzz4sn;
	Thu,  3 Oct 2024 09:25:33 -0400 (EDT)
Message-ID: <bd93a57c-662f-470e-8ba4-509f27eada6d@efficios.com>
Date: Thu, 3 Oct 2024 09:23:31 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: 'Alan Stern' <stern@rowland.harvard.edu>,
 David Laight <David.Laight@aculab.com>
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <68dc00b3-1ca1-42bc-8f1e-78ace10e4d64@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-03 03:50, 'Alan Stern' wrote:
> On Wed, Oct 02, 2024 at 03:24:45PM +0000, David Laight wrote:
>> I think I know what you are trying to do, and you just fail.
>> Whether something can work is another matter, but that code
>> can't ever work.
>>
>> Inside if (a == b) the compiler will always use the same register
>> for references to a and b - because it knows they have the same value.
> 
> According to the other people in this discussion who have actually tried
> using this code, it _does_ work (at least some of the time).
> 
> However, I'm not one of those people and so I leave it up to them to
> decide how to respond to this critique.

I suspect that David's comment is about this specific example that
was given in this leg of the email thread:

https://lore.kernel.org/lkml/5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com/

> > > > > int fct_hide(void)
> > > > > > {
> > > > > >     int *a, *b;
> > > > > >
> > > > > >     do {
> > > > > >         a = READ_ONCE(p);
> > > > > >         asm volatile ("" : : : "memory");
> > > > > >         b = READ_ONCE(p);
> > > > > >     } while (a != b);
> > > > > >     OPTIMIZER_HIDE_VAR(b);
> > > > > >     return *b;
> > > > > > } 

This indeed cannot work because the hide var is done
on @b after it was compared with @a, so after the compiler
was free to use any of the registers due to the equality.

Another example that does *not* work is if we try to hide
vars on the inputs of the equality, and then proceed to do the
comparison on the resulting temporaries, e.g.:

int fct_hide(void)
{
      int *a, *b;

      do {
          a = READ_ONCE(p);
          asm volatile ("" : : : "memory");
          b = READ_ONCE(p);
      } while (OPTIMIZER_HIDE_VAR(a) != OPTIMIZER_HIDE_VAR(b));
      return *b;
}

The reason why this does *not* work is because the compiler is
free to use either temporaries for *b at the end, because they
were deemed identical.

What _does_ work however are the following two approaches:

1) Perform the equality check on the original variables, creating
new versions (with OPTIMIZER_HIDE_VAR) of both variables for the
rest of their use, therefore making sure the pointer dereference
are not derived from versions of the variables which were compared
with another pointer. (as suggested by Boqun)

2) Perform the equality check on the versions resulting of hiding
both variables, making sure those versions of the variables are
not dereferenced afterwards. (as suggested by Linus)

Thanks,

Mathieu


> 
> Alan
> 
>> Possibly something like:
>> 	c = b;
>> 	OPTIMISER_HIDE_VAR(c);
>> 	if (a == c) {
>> 		*b
>> will ensure that there isn't a speculative load from *a.
>> You'll get at least one register-register move - but they are safe.
>> Otherwise you'll need to put the condition inside an asm block.
>>
>> 	David

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

