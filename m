Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708D17BD9;
	Tue,  8 Oct 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407250; cv=none; b=UJTGLFoGV5+M7i+EgJMn77qowQVFQSiBw8OOBPZCeFDbZ3vREP79eyqdheQpxqyMs+h3DKSTatfBpc0YNT4DyemiQrFU6T/h9V06V6HF9ozabMRihbqM+vamOpDTox5NOLkfpE5fWynpLTdDL3NkMC9KXjyg+ujEQD1X1W2GHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407250; c=relaxed/simple;
	bh=2Cu2u7cO30XRae0Bskr7achoPRjdocogxedNS7mRavU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVo6LCESyNJoZyU8nG6H/PY4kpz7C9bun3jriM7SJ9ugA5GwHFuGFYx6Ty4mM5aXcEYIvq1RUdkl/UTA7pjVFY+5Q91jZWbInw/FropCm+R6aX73JSvE+GJYI2HwMT1hgC9NfE3UyEW67smInKvRBxwtIZyGvJf4gBhcnyjy6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=H5zLS1Ot; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="H5zLS1Ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728407247;
	bh=2Cu2u7cO30XRae0Bskr7achoPRjdocogxedNS7mRavU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5zLS1OtZasAaH/1IGAyNxKEXjaSSeSYQa2f7vI29WUYjwQdTchF6vQOcKjCqXO49
	 0+61pY53Tt7Q1mgach6f208vzP2p/KPENllI1FtGmijqMmHMJeguUCR1h1PctlgeVh
	 /CUnJOsfaFpWgnFaSTL6G8Opjc6ps1kbvoy4lOEU6/z+umGcUah7SjdgePcV108guq
	 aah1ZpBH6kOCQhyma1SHndwekwz0eezb5nXEhC+CRvqdgR7qfoHB+Mgaasg2YpnU/C
	 I/kzlnnYGdYDCK/g+OKPZalyVkfkk8MQHMVN8kY0o/nHBklh8ulJOTxrkcdaEBEHHn
	 YI+B2OAt0ZjIA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNMrt2CVYzN8C;
	Tue,  8 Oct 2024 13:07:26 -0400 (EDT)
Message-ID: <a5cadedd-b462-4964-a1cf-f4623379b43e@efficios.com>
Date: Tue, 8 Oct 2024 13:05:29 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/4] hazptr: Implement Hazard Pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org,
 linux-mm@kvack.org, lkmm@lists.linux.dev
References: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
 <20241008135034.1982519-4-mathieu.desnoyers@efficios.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241008135034.1982519-4-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-08 15:50, Mathieu Desnoyers wrote:
[...]

> +/* Retire the protected hazard pointer from @slot. */
> +static inline
> +void hazptr_retire(struct hazptr_slot *slot, void *addr)
> +{
> +	WARN_ON_ONCE(slot->addr != addr);
> +	smp_store_release(&slot->addr, NULL);
> +}

Actually, comparing this with the literature and past presentations
from Maged Michael, "retire" is not the appropriate name here.

With Hazard Pointers, AFAIU, the "retire" operation is similar to a
call_rcu() memory reclaim. It marks the object for eventual reclamation
when it is safe to do so.

The API here really just releases the recently protected hazard
pointer. So I will rename this to "hazptr_release()".

At this stage, this hazptr API does not implement any retire operation,
and only offers the hazptr_scan() for reader/updater synchronization,
leaving the actual reclaim to the caller.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

