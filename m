Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66754704F
	for <rcu@vger.kernel.org>; Sat, 10 Oct 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791634660; cv=none; b=u1VRuvmI6njL0SWoW83orkGZs5m64t6AYWzc/cfuQpWh3rVpE5OWaBIOrrn1+skYltmg9eUe8BrNToyRwGB0sBHtqyzJUN4U3hK26wGBjFVL1mi/EYULyLDSHqIsdkMNpNE6pS1greVNHO01MmpLg3bbDfyLqt2C2mEeMJ57E6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791634660; c=relaxed/simple;
	bh=/oC5LqvhCIZWoE13YlrWBvbYvUdEQxoB6HLEhcwuDqo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ccaCiT6jkGiabUl2TTdf9eYDs/hCt+s4bFTT3GKtN/SLvECbO4QnltBKgoKGrXY201QBN/OjtRB5EzAcPSZ63mIOk8ifTRRw/jZ/1i8PiU0QLUDo6djpAIGca9g7DRn3LdZt2jRcWy6JYMpz4IR+hVYEAw+dOqJFcRSM7xF/0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2+nxAc8; arc=none smtp.client-ip=95.215.58.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2+nxAc8"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/oC5LqvhCIZWoE13YlrWBvbYvUdEQxoB6HLEhcwuDqo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791634655; v=1; x=1792239455;
 b=t2+nxAc8HwGfwSfMb3KLOB2GvhA8rtvxhQvSLPl9v87A7yHgrE2oRfE+UTKGSMiNIH8ApgI3
 a7KI10WnGMjlLO7J+6WvEW69ttVIH9J53U4gmWUCQCJnwgBKvXhQo9xV8+pIOZpEMeB2zGIcgo2
 7+gDpe/tzdln+JOvFoam8c1M=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cabab91e30cf1091;
	Sat, 10 Oct 2026 12:17:35 +0000
X-Mizu-Trace-ID: cabab91e30cf1091
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Oct 2026 12:17:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <88e9dca361959a297f854200cba0c5c80d26877a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] tools/rcu: Add new APIs to rcu-updaters.sh
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 urezki@gmail.com, boqun@kernel.org, kunwu.chan@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <FCDF3652-74F1-4EA4-B39E-3F74F1EAF5B5@nvidia.com>
References: <20261010083107.15086-1-qiang.zhang@linux.dev>
 <FCDF3652-74F1-4EA4-B39E-3F74F1EAF5B5@nvidia.com>

>=20
>=20>=20
>=20> On Oct 10, 2026, at 4:31 AM, Zqiang <qiang.zhang@linux.dev> wrote:
> >=20=20
>=20>  The following commit introduces some new APIs:
> >=20=20
>=20>  commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> >  commit '8df13f01608e ("rcu: Add full-sized polling for cond_sync_exp=
_full()")'
> >  commit 'd96c52fe4907 (rcu: Add polled expedited grace-period primiti=
ves)'
> >=20=20
>=20>  synchronize_srcu_atomic(), cond_synchronize_rcu_expedited() and
> >  cond_synchronize_rcu_expedited_full().
> >=20=20
>=20>  Sample output when running rcutorture:
> >=20=20
>=20>  @counts[synchronize_srcu]: 48
> >  @counts[synchronize_rcu_expedited]: 74
> >  @counts[synchronize_rcu]: 102
> >  @counts[poll_state_synchronize_rcu_full]: 443
> >  @counts[call_rcu]: 2498
> >  @counts[synchronize_srcu_atomic]: 8717
> >  @counts[poll_state_synchronize_srcu]: 14849
> >=20=20
>=20>  @counts[call_srcu]: 22
> >  @counts[synchronize_rcu]: 103
> >  @counts[start_poll_synchronize_rcu]: 1093
> >  @counts[cond_synchronize_rcu_expedited]: 5339
> >  @counts[cond_synchronize_rcu_expedited_full]: 5375
> >  @counts[synchronize_rcu_expedited]: 8134
> >  @counts[get_state_synchronize_rcu_full]: 17248
> >  @counts[get_state_synchronize_rcu]: 17266
> >  @counts[call_rcu]: 119168
> >=20=20
>=20>  This commit therefore add thems to rcu-updaters.sh script.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >=20
>=20Nice, Thanks!, Could you update the documentation too and include in =
this series?

Hi, Joel

I have already send patch for the Doc API update separately.

Thanks
Zqiang

>=20
>=20>=20
>=20> tools/rcu/rcu-updaters.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20=20
>=20>  diff --git a/tools/rcu/rcu-updaters.sh b/tools/rcu/rcu-updaters.sh
> >  index 8a5df3f22550..a0f03a144f6a 100755
> >  --- a/tools/rcu/rcu-updaters.sh
> >  +++ b/tools/rcu/rcu-updaters.sh
> >  @@ -34,6 +34,7 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
> >  kprobe:synchronize_rcu_tasks_trace,
> >  kprobe:synchronize_srcu,
> >  kprobe:synchronize_srcu_expedited,
> >  + kprobe:synchronize_srcu_atomic,
> >  kprobe:get_state_synchronize_rcu,
> >  kprobe:get_state_synchronize_rcu_full,
> >  kprobe:start_poll_synchronize_rcu,
> >  @@ -44,6 +45,8 @@ bpftrace -e 'kprobe:kvfree_call_rcu,
> >  kprobe:poll_state_synchronize_rcu_full,
> >  kprobe:cond_synchronize_rcu,
> >  kprobe:cond_synchronize_rcu_full,
> >  + kprobe:cond_synchronize_rcu_expedited,
> >  + kprobe:cond_synchronize_rcu_expedited_full,
> >  kprobe:start_poll_synchronize_srcu,
> >  kprobe:poll_state_synchronize_srcu,
> >  kprobe:rcu_gp_init
> >=20
>=20Ack on this patch.
>=20
>=20>=20
>=20> --
> >  2.17.1
> >
>
