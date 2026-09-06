Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CA3C1D73;
	Sun,  6 Sep 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788691522; cv=none; b=SfVUWXUGqJyIFtpkYeGEuuZSqBIpgfi7a0e7M12I9MuDNGewfmo41C1p+mK3WievKofaR6FH9BmMMFJIpEs1Z+lyb7U3usGXLCl/naIeGz0+y5LwJAHvGd2uN9MpMTmqHIklX674tCO/Zq5AeWFkWs1dscc9H7M/f1C7ie9M6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788691522; c=relaxed/simple;
	bh=v/noHguVJ77dc/ycrCbGgQ6qgmtGDRgf2gscj/IIKWU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J79uDTBqVktaxCFsfML8aRi2T6Db3zsjAN0Jg1rG4eKUP/efIMOT/2nvU7kmCblHYf1ULi43haXDKBqYCAQexYBLtKkR57REor+uHfrIx9Ht6iSIj/8DtzUWmcXFA2cpkhXGN8Tak2YzylpZExkPNDwIljbiRCPsiKDwuPjPs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=b4W4fRQS; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bpH/1oEV; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="b4W4fRQS";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bpH/1oEV"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788691490; bh=PMnH6FCBZHoFqvsVuGs8J2Z
	WYfUE+eIkvUD0aBlIEgs=; b=b4W4fRQSkApp9S+BYtz7P9HQN5t0XLOXN0tkLJuX6ACwFdF7fo
	nVp6ot+niKlYFw9W+bnYdqQ/bpIiF2it1VqZWx5RkYeyKt1PjpIKNU9+g9Um+qWpQkBJRH4/MWp
	8R+GLGI+1LZGgJOZJRSFPUUXRn+WKrq3DWD/E26RXELxWGJRwXF/AJgksyKvC9hIDLOGphq03XF
	jUtlsKF50s1J5hSVC46I/c4AD525lMrgQewpwn6mbK9Nzz3czBg48co6fz7bhjuaPo+z8hYIhSc
	P7ZPDUsal9yDWua+HQaMBtiUAV7x/pXSrtykJa2iTpOFsx83zK2Fjjy5fxynic9uJoQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788691490; bh=PMnH6FCBZHoFqvsVuGs8J2Z
	WYfUE+eIkvUD0aBlIEgs=; b=bpH/1oEV7J4I75wamMPY+iLcmbzX+xqR8LlhIXzY3eIwTAtsO/
	VrDLIZmbJX6E5nc9IEl7waqV542NDxIMD0Bg==;
Date: Sun, 06 Sep 2026 11:44:48 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <34021ed4-1a18-4cb6-8027-a8c919086ec0@paulmck-laptop>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop> <AF26CA5B-6766-4682-A6A4-61F14F8B81F0@mainlining.org> <34021ed4-1a18-4cb6-8027-a8c919086ec0@paulmck-laptop>
Message-ID: <09BD5394-BF9D-46AF-BED3-CF16B7667716@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 23:54:38 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sat, Sep 05, 2026 at 10:08:30PM +0100, Bradley Morgan wrote:
>> On 5 September 2026 21:40:28 BST, "Paul E. McKenney"
><paulmck@kernel.org>
>> wrote:
>> >On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>> >> On 4 September 2026 17:00:22 BST, "Paul E. McKenney"
>> ><paulmck@kernel.org>
>> >> wrote:
>> >> >On Fri, Sep 04, 2026 at 09:01:05AM -0400, Mathieu Desnoyers wrote:
>> >> >> On 2026-08-03 20:03, Bradley Morgan wrote:
>> >> >> > The do_pending kthread never sleeps. Its supposed to.
>> >> >> > kthread_do_pending_ms sets the gap between cleanups, and the
>docs
>> >> >> > say so too. But the sleep sits behind torture_must_stop(), and
>> >thats
>> >> >> > false while the test runs. So the kthread never sleeps. It just
>> >loops.
>> >> >> > It drains the pending lists over and over, no pause, and burns a
>> >full
>> >> >> > CPU for the whole test.
>> >> >> 
>> >> >> Paul, I just found this patch in my junk email folder. Maybe
>relevant
>> >> >> for you ?
>> >> >
>> >> >We got it in my -rcu tree:
>> >> >
>> >> >15b9fca2f5ce ("hazptrtorture: Fix inverted sleep condition in
>> >do_pending
>> >> >kthread")
>> >> >
>> >> >But I do appreciate your checking for missed patches, thank you!
>> >> >
>> >> >							Thanx, Paul
>> >> >
>> >> >> Thanks,
>> >> >> 
>> >> >> Mathieu
>> >> >> 
>> >> >> > 
>> >> >> > Flip the check. With !torture_must_stop() it sleeps for
>> >> >> > kthread_do_pending_ms between passes. When the test stops it
>does
>> >one
>> >> >> > last cleanup and exits. Nothing left to do, so no sleep needed
>> >then.
>> >> >> > 
>> >> >> > Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release
>> >deferred
>> >> >hazard pointers")
>> >> >> > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> >> >> > ---
>> >> >> >   kernel/rcu/hazptrtorture.c | 2 +-
>> >> >> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >> > 
>> >> >> > diff --git a/kernel/rcu/hazptrtorture.c
>> >b/kernel/rcu/hazptrtorture.c
>> >> >> > index 72aeb50668e9..7c8b5899fb01 100644
>> >> >> > --- a/kernel/rcu/hazptrtorture.c
>> >> >> > +++ b/kernel/rcu/hazptrtorture.c
>> >> >> > @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void
>*arg)
>> >> >> >   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>> >> >> >   			hazptr_torture_do_one_pending(cpu, &rand);
>> >> >> >   		}
>> >> >> > -		if (torture_must_stop())
>> >> >> > +		if (!torture_must_stop())
>> >> >> >   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>> >> >> >   		// Omit stutter_wait() because this function needs to do cleanup.
>> >> >> >   	} while (!torture_must_stop());
>> >> >> 
>> >> >> 
>> >> >> -- 
>> >> >> Mathieu Desnoyers
>> >> >> EfficiOS Inc.
>> >> >> https://www.efficios.com
>> >> >
>> >> >
>> >> Hi, new email.
>> >> 
>> >> Could I ask where the heck hazptr is? Its not in next, would you
>like,
>> >> help???
>> >> 
>> >> --- Thanks!
>> >>
>>
>>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> >
>> >It is still in my -rcu tree.
>> >
>> >I would not say "no" to a fix for this issue:
>> >
>>
>>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> >
>> >Once that is in place, I would be happy to put this back into -next.
>> >
>> >At some point, we will need to get rid of the concept of wildcard
>hazard
>> >pointers, as those end up instead emulating RCU, but I don't see that
>> >as an immediate obstacle.
>> 
>> Well, okay, tell me more and I'll develop it.
>
>I must confess that I have not looked much into that bug report, so I
>don't have much more to tell.

No, like the getting rid of wildcard hazptrs?

>
>						Thanx, Paul
>
>> --- Thanks!
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> 

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
