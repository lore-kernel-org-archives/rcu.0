Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824863749FD;
	Sun, 13 Sep 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789303647; cv=none; b=APONFmR5EZjqXpL5xE/MPLkRsNme3xhTXr+L5I6/7kHXb47v6Ns/DeFxzwC1MkpMV6BpmKh6ANB8F9bXi8mhIK0sO63KRyRPLqVIfi8nDWbTDDYZxXIGRK1y5TNDrRliQYSDAMmWl9oOSVVOCs+NejF0JRA4HO1I9TAJ8nOXKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789303647; c=relaxed/simple;
	bh=ZIX3tVKTCuTX00l6xXoe1yuerRjaXwZfhuAO0nxVqbU=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ftgV+9EpqOHvtdJYo5oBd8YYfUGlicwrGecXHR1uwFnTwLxtCrXXrmN5+EMYqL52ysBMR3dNzT93SmLe/YyD3FG+kvspGPy3kcLzD2bAFw8GvqbOqVMldxGGKezpKvFmzG5h/zSSDCTIlI+89bTa/SXdMG59S7S2GjtYQWudNG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YUdBMQIE; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=v5F1X/Hn; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YUdBMQIE";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="v5F1X/Hn"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789303626; bh=QJtBQCTKsuUhAszcZD6yyU/
	pdahOrkRMClmeO/H7HZI=; b=YUdBMQIEbYQosAC1rM5TauT4/fP2ZZDCxsXruEFn0JPeESqKOS
	hOEif79r0VgBCZYic81UwCPLMEqIAC+HASRsRklr0lCqedQLINYKkzdR+Y/C3/88Jn+qTle4azl
	o5I91B3jWiEezUc+QI0mSelkmaLX8gZvtZYYmLWhF5qQxJB6eYqML9cwmMCY1Xg1cOwJRwn0zrx
	NhoNCliEpcHN9AgIdNtRWocmaW24diVGX6sec2j/WUFT+dJx0/NzHkZT2x/kepfdfDRTulzYeWX
	1Rrvrp+j+TTssGoFOuGZLv4mgms7/x7Aa5k3iNDfefeIx9oMJdj6wnsmEoqjlViVCTg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789303626; bh=QJtBQCTKsuUhAszcZD6yyU/
	pdahOrkRMClmeO/H7HZI=; b=v5F1X/HncCWv/iPNFem5xpKlHnp2uwhQg9aT8D4y/tPl/RRI9z
	IxJEwUqDTQ1TbWWfDPiVU3fQWxecfLK0tVDg==;
Date: Sun, 13 Sep 2026 13:47:05 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kunwu.chan@gmail.com
CC: jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, rcu@vger.kernel.org,
 rostedt@goodmis.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_srcutree=3A_Don=27t_transit?=
 =?US-ASCII?Q?ion_atomic_SRCU_to_big_in_srcu=5Fgp=5Fend=28=29?=
In-Reply-To: <20260911072125.2268530-1-kunwu.chan@gmail.com>
Message-ID: <52A1E6DD-17E3-42AC-B5A4-B2835A288EF8@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 September 2026 08:21:25 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:

Better late than never.

>Atomic SRCU must remain in the small size state. Warn if this
>invariant is violated and avoid transitioning to big in that case.

Fair enough.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>
>Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>---
>Changes since v2:
>- Also prevent the transition when the atomic SRCU size-state
>  invariant is violated, per Paul McKenney's suggestion.
>-v2: https://lore.kernel.org/rcu/20260910084629.3695383-1-kunwu.chan@gmail.com/
>
>Changes since v1:
>- Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
>  per Paul McKenney's suggestion.
>- v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
>---
> kernel/rcu/srcutree.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 84c022ec8e09..07db4e459b30 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -1073,8 +1073,11 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
> 		raw_spin_unlock_irq_rcu_node(sup);
> 	}
> 
>-	/* Transition to big if needed. */
>-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
>+	/* Transition to big if needed, but never for atomic SRCU. */
>+	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
>+	    ss_state != SRCU_SIZE_SMALL) {
>+		WARN_ON_ONCE(1);
>+	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {

I like this fix.

> 		if (ss_state == SRCU_SIZE_ALLOC)
> 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> 		else
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
