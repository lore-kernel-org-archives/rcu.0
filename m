Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD055AA683;
	Fri, 11 Sep 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161497; cv=none; b=OOJV6SrZ+cXChAMzrhJhASBujJjQuww/cEB8tO4B0yByCfCUDfuZBWG2gORdTO3biU7QK8eex2M153Gi5EUURuuhKqEhWWotko7/K+qQR/NXZLnjjoXrJWmY8/HJjRZLd6GTAFj/ga1M953SYhaE42FvY0fj+bwHAX2o3Hmaz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161497; c=relaxed/simple;
	bh=29zXPc7HjdfNS/WfIhVAWB0v5ZO0utJh9QvSggjZEtU=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rw1QP2Lekdpb3CfEhD5dpY2mMCTrH0NrgVTbzdxCxN3JKjSNUmLZeg1IVg/y5hndhU42uESNhWEnAewSUCJPM5g493Kje2LIn/Rf4jhHvZJiKmTn18hGsyETZ3dxz+KJWVGFMaqAfR3V6Cq+z4/Lxtta8fC6hjDQ7J1rko2nOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sJkOBX+H; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bdYaLNTT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sJkOBX+H";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bdYaLNTT"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789161484; bh=/1TKQ1r2wEalNz00TdVoScd
	Kwgx1RM7HlZVOCXvKupE=; b=sJkOBX+HlzlAQ8J9pXbqWbyyTKXV0NGXPEb6GnYQikNy64Q3MH
	vbopjCxWm/0YqSeXDTBGho3Ws8gNOI0VeuiFr+6I4fCzKiSW5TNjg7jIcRrDSegoCIdDG6qo1P/
	SLjMbdFvdbayY5AfD0FUTF8HZoSdchwJw+pen7PR/iEEXkhbVGjDvc8XOOIdNdfGKq0yTpo75mr
	phV44l9C9uabTwD3GJGDo0lLnWCpDdmfwA13MS/gkmMOjoTUK6I7jn2J+V87VLhv9dfpIGKKg9u
	C1/+jRY4NX7y0pL8/9m98Tg5l6GJ1hvDniRfHNYEXIANj9Dgd4ugqBXe1LwF6+99utA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789161484; bh=/1TKQ1r2wEalNz00TdVoScd
	Kwgx1RM7HlZVOCXvKupE=; b=bdYaLNTTEKZ2NKsuiLRVwWLCzwHl01JKiy1oCHFjAL5fYh6Ees
	vC1m5yh80ozyecIkNSCyL9xQSprEQYrdYhDw==;
Date: Fri, 11 Sep 2026 22:18:04 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kunwu.chan@gmail.com
CC: jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, qiang.zhang@linux.dev,
 rcu@vger.kernel.org, rostedt@goodmis.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_srcutiny=3A_Add_lockdep_and_earl?=
 =?US-ASCII?Q?y-boot_checks_to_synchronize=5Fsrcu=5Fatomic=28=29?=
In-Reply-To: <20260911160913.2859713-1-kunwu.chan@gmail.com>
Message-ID: <3CFBAB18-70BF-48DA-9CE2-77F7C89F2DCC@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 September 2026 17:09:13 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
>Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
>gained, srcu_lock_sync() was already present.
>
>Suggested-by: Zqiang <qiang.zhang@linux.dev>

Ok.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>---
> kernel/rcu/srcutiny.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>index 99f8bfd98b04..76411562366f 100644
>--- a/kernel/rcu/srcutiny.c
>+++ b/kernel/rcu/srcutiny.c
>@@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> 
> 	srcu_lock_sync(&ssp->dep_map);
> 
>+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
>+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
>+
>+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>+		return;
>+

Wow!

> 	if (IS_ENABLED(CONFIG_PREEMPTION))
> 		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
> 				   // And in Tiny RCU, it is near zero cost and doesn't block.
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
