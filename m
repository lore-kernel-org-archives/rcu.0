Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D84CF471
	for <rcu@vger.kernel.org>; Fri, 16 Oct 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194884; cv=none; b=lGY5CokTe2/n4TxDDehQ56g2HdTuTbSsn1Z1g4OM4KiQ5ULflZCJF2mMPeCUtk1tRxGsxu3LRNlQzWmLe1o/eZcSYH1JhZFlUcH3EANwHbvaSYgWWq9Y/PDRFbOMhxcp60jf11tpUcvke9gVbkoRT9UFuKkhX/iLD4i81NanfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194884; c=relaxed/simple;
	bh=glmlURYt/66/W0faZNHQUPd2RNei1RW0c69o8sfVZ3Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=imYNWk7515hYUtgyE5i5Ph7LhVU0kAJ16TZFwgGambfna8lk6deXth7JNRBdzKr2ARbvon2s6l2ht+oYSCXoaqlMmZ60FNhPy8qodBhO7yPPuuzjO09vjzhU7n7ON8psqIEO3sSIAOGItm0Elo3WOxb0kNWzKYZqd4vxyNPEVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwJpaKkE; arc=none smtp.client-ip=95.215.58.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwJpaKkE"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=glmlURYt/66/W0faZNHQUPd2RNei1RW0c69o8sfVZ3Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792194879; v=1; x=1792799679;
 b=lwJpaKkEE+DQS6vcWYxlFQP9Q8YjDOoeP88Jd2mwprXSibakah7qjxbIeG14uHywNkCaidec
 NhPMI6rAWdq9w7yy16jC8INYuNQGShfgytVK8+aIM1nMDc0au09FaI330a87/Pe0UCOgWuZod4s
 zfQRtQJ9vmEP119QbrXkaUGg=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 385ac02cd79412a0;
	Fri, 16 Oct 2026 23:54:39 +0000
X-Mizu-Trace-ID: 385ac02cd79412a0
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 23:54:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <f6509555c4e1abfc3bf67643d568887a7f9b7215@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] doc: Fix stale RCU_GP_WAIT_FQS value in stallwarn.rst
To: "Randy Dunlap" <rdunlap@infradead.org>, "Yonghao Zhang"
 <hyz3367@gmail.com>, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: rcu@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <363ea835-81bd-4045-bf1e-f5a460fd698b@infradead.org>
References: <20261014063130.3691735-1-hyz3367@gmail.com>
 <363ea835-81bd-4045-bf1e-f5a460fd698b@infradead.org>

>=20
>=20On 10/13/26 11:31 PM, Yonghao Zhang wrote:
>=20
>=20>=20
>=20> The sample "kthread starved" splat in stallwarn.rst shows
> >  RCU_GP_WAIT_FQS(3), which was correct when the example was captured,
> >  but has been stale since commit fea3f222d352 ("rcu: Record ->gp_stat=
e
> >  for both phases of grace-period initialization") inserted
> >  RCU_GP_ONOFF (3) and RCU_GP_INIT (4) ahead of it, shifting
> >  RCU_GP_WAIT_FQS from 3 to 5.
> >=20=20
>=20>  Update the sample output to show (5), matching the current tree.h
> >  values and the later "kthread timer wakeup" example in the same file=
.
> >=20=20
>=20>  Fixes: fea3f222d352 ("rcu: Record ->gp_state for both phases of gr=
ace-period initialization")
> >  Signed-off-by: Yonghao Zhang <hyz3367@gmail.com>
> >=20
>=20Acked-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Zqiang <qiang.zhang@linux.dev>

Thanks
Zqiang

> Thanks.
>=20
>=20>=20
>=20> ---
> >  Documentation/RCU/stallwarn.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/s=
tallwarn.rst
> >  index b888e13c02a4..049694b9c681 100644
> >  --- a/Documentation/RCU/stallwarn.rst
> >  +++ b/Documentation/RCU/stallwarn.rst
> >  @@ -379,7 +379,7 @@ If the relevant grace-period kthread has been un=
able to run prior to
> >  the stall warning, as was the case in the "All QSes seen" line above=
,
> >  the following additional line is printed::
> >=20=20
>=20>  - rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_W=
AIT_FQS(3) ->state=3D0x1 ->cpu=3D5
> >  + rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAI=
T_FQS(5) ->state=3D0x1 ->cpu=3D5
> >  Unless rcu_sched kthread gets sufficient CPU time, OOM is now expect=
ed behavior.
> >=20=20
>=20>  Starving the grace-period kthreads of CPU time can of course resul=
t
> >=20
>=20--=20
>=20~Randy
>
