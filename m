Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFE3A257E
	for <rcu@vger.kernel.org>; Sat, 29 Aug 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788009570; cv=none; b=hxaKS55D6hqCB5CJfd/vI/JzzeRKNZY4TXa2N3UwmhUj8HskI8Cai8D3GRopUAhrzAtnZPWWG7P34n85QiLXb6tl9ILPTKf+c6nDwIjB3/rieddn7AZSp7hmH0lVIIfrempKOeKt3eAzObFVL4ps/3RV4IkPcbB1Um7UO7HP4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788009570; c=relaxed/simple;
	bh=C14v2WGP1xxtMOJJJIjDSF8aD6pnzea40Q7Smx8wkHY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HzMQHio7bY08YL9faGSjBtXnbBz0AH5MKuo89seVjYpXVoVqbUnrs/1GFDe0M6oE3P71O7oyaAl9yRtr+HhVkjWAbZ4RqrL+3lPD6jqd7kWOIWEF+NDnylqgDT5KWtIixvCauWnTHyrEHt1vV7qlwupmnIK0fDHXg3JPWYbaKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bThRVrbL; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bThRVrbL"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C14v2WGP1xxtMOJJJIjDSF8aD6pnzea40Q7Smx8wkHY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788009565; v=1; x=1788614365;
 b=bThRVrbLOLNOEOLfpZE8x584jq/1zCxqYbno0D9yOFPYEHzG8hpugJoT5EHtD11c/y0jglR8
 6J8yPaQWJkUkBhFbyk+Cx+Z2oEP/tcl8KdeVDD/C50eBUUK9OMt6vbau2gtF1mF5lCk3rc7YLdj
 CzSowpG6R8X4o39vRB4qk/3s=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 46316813983bc88d;
	Sat, 29 Aug 2026 13:19:25 +0000
X-Mizu-Trace-ID: 46316813983bc88d
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 29 Aug 2026 13:19:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <1b9d3ddaa26ba6a8ac2ad4c586c2d19a5c1f927e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in 
 cleanup_srcu_struct()
To: "Sunho Park" <shpark061104@gmail.com>, paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, frederic@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Sunho Park"
 <shpark061104@gmail.com>,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
In-Reply-To: <20260827150208.2166775-1-shpark061104@gmail.com>
References: <20260827150208.2166775-1-shpark061104@gmail.com>

>=20
>=20The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
> when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs=
()
> to detect callbacks that srcu_barrier() failed to wait for. However, th=
e
> ->len counter is decremented only at the end of srcu_invoke_callbacks()=
,
> after the invoking loop has finished. Since srcu_barrier() can return
> right after the barrier callback is invoked, cleanup_srcu_struct() can =
see
> a non-zero n_cbs even though the cblist is already physically empty,
> falsely triggering the WARN_ON() together with a still-pending delay_wo=
rk
> timer.
>=20
>=20Use rcu_segcblist_empty(), which checks the actual head of the cblist=
.
> Callbacks that have genuinely not been invoked yet still leave the list
> non-empty, so the WARN_ON() still catches callers that skip srcu_barrie=
r()
> or queue callbacks after it.


You should describe in detail how this scene was triggered like this=EF=
=BC=9A

1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) start a SRCU GP1.

2. The SRCU GP1 end, arms a timer and queue sdp->work, but this sdp->work=
 not yet run.

3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) invoke srcu_segcb=
list_advance()
   to push step1 srcu callback to RCU_DONE_TAIL and start a SRCU GP2.
=20
4.=20srcu_barrier() is called and queues barrier callbacks after step3 sr=
cu callback,
   waits for srcu_invoke_callbacks() to invoke them.

5. The SRCU GP2 end, also arms a timer, and the sdp->work by step2 queued=
 begin run,
   the srcu_invoke_callbacks() invoke srcu_segcblist_advance() also push =
step3 and step4
   srcu callback to RCU_DONE_TAIL, all srcu callback execution completed,
   but the not yet invoke rcu_segcblist_add_len() to update srcu_cblist's=
 len.

6. The srcu_barrier() return, cleanup_srcu_struct() begin run, after then=
, find
   the step5 timer still pending and the srcu_cblist's len not zero, trig=
ger
   WARN_ON()
=20=20=20
Thanks
Zqiang


>=20
> Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762=
d3c@linux.dev/T/#t
> Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd4faf7db59e11f6fd1ab
> Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is suc=
cessfully deleted")
> Signed-off-by: Sunho Park <shpark061104@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index ed204b3f4b84..ad27880dd690 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -704,7 +704,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  // Call srcu_barrier() before this cleanup_srcu_struct()
>  // to avoid triggering this WARN_ON().
>  if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> - rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> + !rcu_segcblist_empty(&sdp->srcu_cblist)) &&
>  rcu_cpu_beenfullyonline(sdp->cpu))
>  queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>  flush_work(&sdp->work);
> --=20
>=202.43.0
>
