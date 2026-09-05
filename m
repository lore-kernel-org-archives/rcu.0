Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A8165F1A;
	Sat,  5 Sep 2026 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788642515; cv=none; b=dKAbc1LcAWeX6TxTDqxj9FjfcCDfs7EFoXJnQIpuZGTeCwd9mJ8n5n7D4hK66c36Ae2yOn0jHVrA2XL8hKQvUd8coCor+Bb2hi8z5uQ5PM0Qu13GPyENKNY1rqPP7BthJ+81I9+rdFJKJUA6SfaPCAcOmgHULziJ/IUKABafgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788642515; c=relaxed/simple;
	bh=coqKxEHGz58G7WBSlpjca2ynqwIJPJeBf0JAKUvMmBo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=djQkJfKHcEJNWKAX41O2ja7u+0NUote24KCnIeMcRDwy+68P7te07gfSvipK9sua/GKww0OFeGc3pKa9dauwUeXLk/hJ5g4Jf252tnkgkAshIJJAVzvVcRsMxKyPD4KXDdB2mAZQZjxuK5g1Tq7VHFjttkf+HzMrbxj9hSsNHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JFo9IAl+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=3Af9f8ZT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JFo9IAl+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="3Af9f8ZT"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788642511; bh=UUhZ1wCZnhdDLz5L8ffmRJC
	jhXT8HSeCKMYUSeReD2M=; b=JFo9IAl+MQuQTNrJNEbkHeALw3jOa/BQwWHUQrpkHH9ztOj0lY
	sPfM2wWxdu9MzNZ3rnhKqaRapWF+/PiV0/BVvfi3Lw2Jr/CsWKvQt+xgI2SzvPBKSAVNQWIqD0+
	HfglMLE1lSjSdw1k+Gb1/Mltx88Hm1iY3pvKnpM/QD7V5wxeL2n3T8OV0ZFY1NbecY8ue6oOF52
	7IryoF/ir2PiIQSlXP/JH4yhIOhMRf2yisJ/itV68V8WHAK2sbZIU0d8/2b2K9JjRUjxC9fxzJz
	/LssJZvwo+Xvdw3mnde1SGG5L/U+NOis0wB92kIEzhsKvcbMqRodzzbHLwCQm/Rw8hQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788642511; bh=UUhZ1wCZnhdDLz5L8ffmRJC
	jhXT8HSeCKMYUSeReD2M=; b=3Af9f8ZTp5BV7iLSnWeIRT+f/OiFMDp25IzDf5aQLlegtIJPv8
	i6u2HlAAjotrcCWQGJacX0gZohe1BevOVvDA==;
Date: Sat, 05 Sep 2026 22:08:30 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop>
Message-ID: <AF26CA5B-6766-4682-A6A4-61F14F8B81F0@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 21:40:28 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>> On 4 September 2026 17:00:22 BST, "Paul E. McKenney"
><paulmck@kernel.org>
>> wrote:
>> >On Fri, Sep 04, 2026 at 09:01:05AM -0400, Mathieu Desnoyers wrote:
>> >> On 2026-08-03 20:03, Bradley Morgan wrote:
>> >> > The do_pending kthread never sleeps. Its supposed to.
>> >> > kthread_do_pending_ms sets the gap between cleanups, and the docs
>> >> > say so too. But the sleep sits behind torture_must_stop(), and
>thats
>> >> > false while the test runs. So the kthread never sleeps. It just
>loops.
>> >> > It drains the pending lists over and over, no pause, and burns a
>full
>> >> > CPU for the whole test.
>> >> 
>> >> Paul, I just found this patch in my junk email folder. Maybe relevant
>> >> for you ?
>> >
>> >We got it in my -rcu tree:
>> >
>> >15b9fca2f5ce ("hazptrtorture: Fix inverted sleep condition in
>do_pending
>> >kthread")
>> >
>> >But I do appreciate your checking for missed patches, thank you!
>> >
>> >							Thanx, Paul
>> >
>> >> Thanks,
>> >> 
>> >> Mathieu
>> >> 
>> >> > 
>> >> > Flip the check. With !torture_must_stop() it sleeps for
>> >> > kthread_do_pending_ms between passes. When the test stops it does
>one
>> >> > last cleanup and exits. Nothing left to do, so no sleep needed
>then.
>> >> > 
>> >> > Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release
>deferred
>> >hazard pointers")
>> >> > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >> > ---
>> >> >   kernel/rcu/hazptrtorture.c | 2 +-
>> >> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >> > 
>> >> > diff --git a/kernel/rcu/hazptrtorture.c
>b/kernel/rcu/hazptrtorture.c
>> >> > index 72aeb50668e9..7c8b5899fb01 100644
>> >> > --- a/kernel/rcu/hazptrtorture.c
>> >> > +++ b/kernel/rcu/hazptrtorture.c
>> >> > @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
>> >> >   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>> >> >   			hazptr_torture_do_one_pending(cpu, &rand);
>> >> >   		}
>> >> > -		if (torture_must_stop())
>> >> > +		if (!torture_must_stop())
>> >> >   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>> >> >   		// Omit stutter_wait() because this function needs to do cleanup.
>> >> >   	} while (!torture_must_stop());
>> >> 
>> >> 
>> >> -- 
>> >> Mathieu Desnoyers
>> >> EfficiOS Inc.
>> >> https://www.efficios.com
>> >
>> >
>> Hi, new email.
>> 
>> Could I ask where the heck hazptr is? Its not in next, would you like,
>> help???
>> 
>> --- Thanks!
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>
>It is still in my -rcu tree.
>
>I would not say "no" to a fix for this issue:
>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>
>Once that is in place, I would be happy to put this back into -next.
>
>At some point, we will need to get rid of the concept of wildcard hazard
>pointers, as those end up instead emulating RCU, but I don't see that
>as an immediate obstacle.


Well, okay, tell me more and I'll develop it.

>
>							Thanx, Paul

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
