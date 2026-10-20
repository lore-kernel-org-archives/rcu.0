Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513129;
	b=CMNHwXAC4vM7kze8YVaCjrNUzG4J6V2jCx9jshs/0kX2OyuHZVu3iNn8Z9/zdKYGk+h1
	 KNGd0gE21Q9SUy6CxLN3W5LvJTVraf4SBaG0oheAEWEmhoJtgp17l+phAZ11a4t1uQAwo
	 DFH8OsZsNSrg4/uwLEdI4A8wiDW4mdT+a91dugxzYy2oi+uAs1rous6jTUyKc8YYhlvcD
	 89nt+ewPN/duHaF/uItFpCOvW97jF3PnsvdSHfiq0jzhLGHCtG+yU+l7BIybbMMNt9Ddi
	 Qqb0Lu6UiqRi7JW7LEVWJkG7Tf1Tdf1P3Bw/7Q2t1LOqQpTPWtNUrq17EyI2FDtafcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513129;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HDHLVURJlZ0OyavP+yVh87qyK/wkUYysdpJSAYO5tK8=;
	b=Re25H9egHzdPT/YJPT6fmY+mQGYl4x69q0ACLkjEQsL/y0oclAWsgUyG9+6C+DKGfD/p
	 oFNWZJfL1I6SYOegZEoHwPf617FUu62Yek49KYW+FCqGLkpXwr2eWHb3aPfhVWAPt5QZb
	 tuy2NVo68aBep/ahhnvkBaieBxnzGVFMAtQWQ5c8BCDjnM5r1i2cjI3i7kIdaCN/LMsTy
	 aduAFRnvHDXN/tqv8MTSIrnPuZkevnyjvZoYSnMw/AKVe+TqZEkcD/Dlna6lJiOXlsP/C
	 FAKtV7ruMmERIAqGf5sliLtuth6iNcjdZ2d9Mwr453wGbFp4QsAysK0RzrlymSKkNtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05E606A339
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 16:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A2A1F000CB;
	Tue, 20 Oct 2026 16:18:49 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DE4ABCE1B83; Tue, 20 Oct 2026 09:18:18 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:18:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-mm@kvack.org,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH] mm/slab: Call call_rcu() directly from
 __kfree_rcu_sheaf() in any context
Message-ID: <43ba22f4-f7c0-40c0-b327-a71d07f02280@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261016155340.3304319-1-puranjay@kernel.org>
 <3225a379-a959-44b2-a2e8-02ca93759316@kernel.org>
 <CANk7y0jHbggDHB_68MjZNq4h=Gu_N_G-Ytf0YLrKM_B8A=qsoA@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0jHbggDHB_68MjZNq4h=Gu_N_G-Ytf0YLrKM_B8A=qsoA@mail.gmail.com>

On Tue, Oct 20, 2026 at 11:06:23AM +0100, Puranjay Mohan wrote:
> On Tue, Oct 20, 2026 at 10:23 AM Vlastimil Babka (SUSE)
> <vbabka@kernel.org> wrote:
> >
> > On 10/16/26 17:53, Puranjay Mohan wrote:
> > > __kfree_rcu_sheaf() can run with allow_spin == false, e.g. from
> > > kfree_rcu_nolock(), where it may interrupt call_rcu() itself on the same
> > > CPU. call_rcu() was not reentrant, so commit 69abda97a09b2 ("mm/slab:
> > > extend deferred free mechanism to handle rcu sheaves") added a fallback:
> > > when !allow_spin and IRQs are disabled, the full rcu sheaf is put on a
> > > per-CPU llist and submitted to call_rcu() later from irq_work.
> > >
> > > call_rcu() now handles this itself. When it is called with IRQs disabled
> >
> > That's great! can you reference which commit does that? I assume it will be
> > merged in this 7.4 merge window?

Glad you like it, and thanks to Puranjay for making this happen!

> It is part of the RCU pull request for 7.4:
> https://lore.kernel.org/all/720d335d-17f1-48e7-b5e6-49352712cdca@paulmck-laptop/

More specifically, these guys:

af78eca13b035 rcu: Make call_rcu() safe to call from any context
0ed912d346fdb rcu: Make Tiny call_rcu() safe to call from any context
35a26d87042b7 srcu: Make call_srcu() safe to call from any context
a04b2854bedc7 srcu: Make Tiny call_srcu() safe to call from any context
d23e30d76c32d rcutorture:  Disable fragile readers during overload testing
813f2ad270032 rcutorture: Exercise ->call() from NMI context
0464f587c61af selftests/bpf: Add a call_srcu() re-entry reproducer

							Thanx, Paul
