Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345D48CD72;
	Fri,  4 Sep 2026 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542957; cv=none; b=BOYl0B8hw28t0GaxKh1/l0Q6F242lMt8xi7YlYfdhCx+sqO6G616Jq6UIy5ThdPKImeWsOzLMsH/mW6u4cJnBFLzx6Yhilaqjc0N57aJ6QqzI8haguGErj5suKxdwdzXv0SGosSnfyq75hluBys6DhJrhAyKgNuqIvHOs65YNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542957; c=relaxed/simple;
	bh=wHFYardv28r7PAsa9mEH9zcWscTl5PwvQA2rvSE+wF0=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=TO0rRUOdG7/ujrCYOjkXZeD79VOcqEsuyYg4Edsz0b+GQU1X2NQDY6ZxyBcyN3YqHNXVLwiJxfmd7vnBMMnO7i7d85j2A7jsKfd12YAI255mdlx7poqC8l0Gj05xhFuh3OxvYRU3KN+JQu8vQ8uEBE85QWXt4pHG2wPUc63/DAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=K1Eaiji8; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=NnMDPWPi; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="K1Eaiji8";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="NnMDPWPi"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788542926; bh=rn5Bn9v9ZksB+gqoKWS1uqd
	jwbyFxQqMRjDvMvXcvR0=; b=K1Eaiji8b02fIexNYf9pZ0PM8103TAOAM6SGxZlXYKBfQ3gVI9
	3gqobv2IXFwTS/HDNQ4qJRfgU2aXryjlfN8NXKWVT7hFV2i5/tOJvCgdQrXc8xRziSYVvf/ajHj
	uJ2j5QS97V9cIqyaib8vVid36Phrsy+uY8hPOuqlncKfOjJ5tZcscgItiIATI2OM9NgdwDhiQcr
	/YVi7pUHduoScujrT5i+zVt/nd9ZJANwxlAizhUeQTMWvlqQ4HDQpSKFbV2OnscC9D6SG0AZRAR
	EGzCLKWozL+jM3Zj0XIfTr/8UoRnTnu9e8YZKasnS79idWfkDXE9A1OVsObuo3Rw1ow==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788542926; bh=rn5Bn9v9ZksB+gqoKWS1uqd
	jwbyFxQqMRjDvMvXcvR0=; b=NnMDPWPiuTL6VavG7+rrE24iP0B2CSQeqNhHbd3qRWh2hX8klT
	4zrVEoJ+SzLzF0UnUbixeUsC4hAyH8UVEaCg==;
Date: Fri, 04 Sep 2026 18:28:45 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org
CC: boqun@kernel.org, frederic@kernel.org, include@grrlz.net,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop>
Message-ID: <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 September 2026 17:00:22 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Fri, Sep 04, 2026 at 09:01:05AM -0400, Mathieu Desnoyers wrote:
>> On 2026-08-03 20:03, Bradley Morgan wrote:
>> > The do_pending kthread never sleeps. Its supposed to.
>> > kthread_do_pending_ms sets the gap between cleanups, and the docs
>> > say so too. But the sleep sits behind torture_must_stop(), and thats
>> > false while the test runs. So the kthread never sleeps. It just loops.
>> > It drains the pending lists over and over, no pause, and burns a full
>> > CPU for the whole test.
>> 
>> Paul, I just found this patch in my junk email folder. Maybe relevant
>> for you ?
>
>We got it in my -rcu tree:
>
>15b9fca2f5ce ("hazptrtorture: Fix inverted sleep condition in do_pending
>kthread")
>
>But I do appreciate your checking for missed patches, thank you!
>
>							Thanx, Paul
>
>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> > Flip the check. With !torture_must_stop() it sleeps for
>> > kthread_do_pending_ms between passes. When the test stops it does one
>> > last cleanup and exits. Nothing left to do, so no sleep needed then.
>> > 
>> > Fixes: 94d2e93c222e ("hazptrtorture: Add kthread to release deferred
>hazard pointers")
>> > Signed-off-by: Bradley Morgan <include@grrlz.net>
>> > ---
>> >   kernel/rcu/hazptrtorture.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
>> > index 72aeb50668e9..7c8b5899fb01 100644
>> > --- a/kernel/rcu/hazptrtorture.c
>> > +++ b/kernel/rcu/hazptrtorture.c
>> > @@ -555,7 +555,7 @@ static int hazptr_torture_do_pending(void *arg)
>> >   			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
>> >   			hazptr_torture_do_one_pending(cpu, &rand);
>> >   		}
>> > -		if (torture_must_stop())
>> > +		if (!torture_must_stop())
>> >   			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>> >   		// Omit stutter_wait() because this function needs to do cleanup.
>> >   	} while (!torture_must_stop());
>> 
>> 
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>
>
Hi, new email.

Could I ask where the heck hazptr is? Its not in next, would you like,
help???

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
