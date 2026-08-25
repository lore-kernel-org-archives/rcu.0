Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15655437130
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661188; cv=none; b=I+Uy0EvqPC1iaA/qGBGCX+v3tp3XtZGH7m8R42TeQsfeZzHEo2iuEpN8UZRL7AlOM4wDou6SBl+DR1DOZ6qUuTy7LdyR9tJxWgycf9i8qzF8R9Qd1sQG9UxkDQsVE3+9sATytlWiCzi4nxsCnt3jmDmp+9w9idsCfHoHods3zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661188; c=relaxed/simple;
	bh=/wnW7DbYIJvddAqh3pqpM7I09WXnxpDrlHu1DS0K5pQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=YOPqHVyHHxEyVMX82M2wSPVFjNSnWcQoN0JYkSNhesAG9g7ycQUg7npSw0VzvARcH6txCODd6Nt1F1wV6HRgr7I65fHKzl4HVf7SVSWcQkn8V1tf+PKEdcUCH4UsPWavO5ZLEnZuY/q1ka6KHQT1RVNKe3aSXAh0Ty8FhmwRNNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VuJbQduI; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VuJbQduI"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/wnW7DbYIJvddAqh3pqpM7I09WXnxpDrlHu1DS0K5pQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787661183; v=1; x=1788265983;
 b=VuJbQduIeA61S1pu8u/fJUgb1tbk7eJ4uGa6OLEpdTsWVQgEl/yZfGcyyJpnXwn0SHJGstX/
 StmPTdUP/MCHmMx0k935GoiVmDqfLoNJhTlWTwUeh8YLyjMBcjClgPMjXo1aRvrMxLogYwb/1r3
 9pMkk8sL/pPACEsWooZlMuCA=
X-Envelope-To: rcu@vger.kernel.org
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 1d302fce12a8bbff;
	Tue, 25 Aug 2026 12:33:03 +0000
X-Mizu-Trace-ID: 1d302fce12a8bbff
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 12:33:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <494f3e0cdb3692bf13690f4cddd3b40098b51627@linux.dev>
TLS-Required: No
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after 
 78a38cbf6f20
To: "Sunho Park" <shpark061104@gmail.com>, rcu@vger.kernel.org
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, "Sunho Park"
 <shpark061104@gmail.com>,
 syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
In-Reply-To: <20260824105625.3725157-1-shpark061104@gmail.com>
References: <20260824105625.3725157-1-shpark061104@gmail.com>

>=20
>=20The main crash report [1] which is tested on non-merged commit 6b8c8a=
f514d7
> is caused by the single-condition WARN_ON(timer_delete_sync(&sdp->delay=
_work))
> in cleanup_srcu_struct(&kvm->irq_srcu). As discussed in [2], it is a fa=
lse
> positive because irq_srcu does not use call_srcu().
>=20
>=20However, the merged WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> rcu_segcblist_n_cbs(&sdp->srcu_cblist)) is also triggered in
> cleanup_srcu_struct(&kvm->srcu) which is called after srcu_barrier() pr=
operly.
> Although my syz test command [3] failed to reproduce, it was reproducib=
le
> in my QEMU environment built with the .config of the report.
>=20
>=20I found out that the return value of rcu_segcblist_n_cbs can be nonze=
ro
> even after srcu_barrier() because of the srcu_barrier_cb() that srcu_ba=
rrier()
> inserts at the end of the queue. The length of cblist is decreased afte=
r
> srcu_invoke_callbacks() finishes invoking all callbacks in a batch. But
> srcu_barrier() may return when all the srcu_barrier_cb() are called, br=
inging
> the counter to zero, even if srcu_invoke_callbacks() has not yet decrem=
ented
> the length. So checking cblist length before flush_work() is inaccurate=
.

If srcu_barrier() be invoke before srcu_cleanup(), and after srcu_barrier=
()
completion, there are no concurrent srcu grace period start again (e.g. c=
all_srcu() calls),=20
the=20timer_delete_sync() should return false, the rcu_segcblist_n_cbs()
will not be check.

Or did I miss something?

Thanks
Zqiang


>=20
>=20By the comment of srcu_barrier(), it guarantees that all the previous=
ly
> registered call_srcu() callbacks are completed. Therefore srcu_barrier(=
)
> did what it said, only the length of cblist was not updated. I think th=
ere
> are two options:
>=20
>=201) Not to check the length of cblist before flush_work()
> 2) Make srcu_barrier() guarantee the length of cblist is adjusted when =
it returns
>=20
>=20[1] https://lore.kernel.org/all/6a78d191.b50370da.49fe0.0042.GAE@goog=
le.com/T
> [2] https://lore.kernel.org/rcu/01484cd339ea024dd7c01f02a9781f00e67cb52=
d@linux.dev/T
> [3] https://lore.kernel.org/all/6a8bc111.91706f20.16b6e3.02cd.GAE@googl=
e.com
>=20
>=20Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
>
