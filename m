Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03337C10A
	for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404715; cv=none; b=Q7C6BSu8DQxk8z5OojStnLFLYNGacksSurBcy0A4kS5hkbjKVWKyoqJ3mrQ5xWwIMLh19QORBdvjHsOLrXj/4fqc9T7PDwDXss+mbQ+hZbxbnC8l/HNVcfNBadbkIWvPC68+JFgkZowyjPvPCGTVVF2tMugMZ2JN7o8kNDwLtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404715; c=relaxed/simple;
	bh=/QoyO3kXkJYTuO+BIWCC4cwyZ+d91kzAyCi6VF93zlo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=oGJzqdth6mpiQDGJaHRrKi+xkho8os5RbIUKBK7RPfjwTkqVTRZRfNAX4i4AHx3NHNAMNa/fXDxYc6rY3u8FqTAkOgvGz/HGG9fdK9C+aTj//bQ1K/obYK946U4DSMbACi7aK9Rgdw3d1h1vizRmonDH5b776i+5td5nPQEF9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=patuzsHX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="patuzsHX"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786404710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdQyPja7My9KJWn1QQQ+yA4cgkeswVtuyU2AoY6Nnpc=;
	b=patuzsHXNZToCfjPoA6kLSCxUg8EIS8trBT4VPSjhSm14r2PobLkZ/zrITCm6ziJRPtiPT
	yQDCnaQAxfp2LRWJlmjh0uDyezFdfutJzIYrDF9z7VJDoh/z/XcvxqcfldMrNFSZ2/UPr2
	yKChnFo3jqWc2WyK5GhGZfATPEW1PSQ=
Date: Mon, 10 Aug 2026 23:31:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <3e8f3aa2badb3eb667c43443f642e9b17aa0a484@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in
 cleanup_srcu_struct()
To: "Breno Leitao" <leitao@debian.org>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <annZejMO4k33rdn9@gmail.com>
References: <20260810105522.19022-1-qiang.zhang@linux.dev>
 <annZejMO4k33rdn9@gmail.com>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Mon, Aug 10, 2026 at 06:55:22PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> The WARN_ON() for timer_delete_sync() means that the caller forgot =
to
> >  call srcu_barrier() before cleanup. however, it still can trigger ev=
en
> >  when srcu_barrier() was properly called.
> >=20=20
>=20>  When a SRCU grace period ends and ss_state < SRCU_SIZE_BIG, the ma=
sk=3D~0
> >  causes delay_work timer be queued on every online CPU regardless of
> >  whether it's sdp->srcu_cblist has callbacks. srcu_barrier() only wai=
t
> >  srcu_barrier_head's callbacks to complete, however, the srcu_barrier=
_head
> >  will not be inserted into an empty sdp->srcu_cblist. after that, whe=
n
> >  cleanup_srcu_struct() finds a pending delay_work timer on a CPU with=
 no
> >  callbacks, triggering a false positive.
> >=20=20
>=20>  This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make=
 the
> >  warning triggers only when the timer is still pending and there are =
actual
> >  outstanding callbacks.
> >=20=20
>=20>  Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer i=
s successfully deleted")
> >  Reported-by: Breno Leitao <leitao@debian.org>
> >  Reported-by: kernel test robot <oliver.sang@intel.com>=20
>=20>  Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@i=
ntel.com/=20
>=20>  Tested-by: kernel test robot <oliver.sang@intel.com>
> >  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >  ---
> >  kernel/rcu/srcutree.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >  index 35fface51d50..090dddfc7463 100644
> >  --- a/kernel/rcu/srcutree.c
> >  +++ b/kernel/rcu/srcutree.c
> >  @@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp=
)
> >=20=20
>=20>  // Call srcu_barrier() before this cleanup_srcu_struct()
> >  // to avoid triggering this WARN_ON().
> >  - if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> >  - rcu_cpu_beenfullyonline(sdp->cpu))
> >  + if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
> >  + rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
> >  + rcu_cpu_beenfullyonline(sdp->cpu))
> >=20
>=20This is quite hard to read, mainly with this indentation.
>=20
>=20You probably want to rewrite the checks , otherwise the indentation
> should be something like, which is horrible (although correct?):
>=20
>=20 if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
>  rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
>  rcu_cpu_beenfullyonline(sdp->cpu))

Will update and resend (I still mark v2 because v1 has not been sent befo=
re).

Thanks
Zqiang

>=20
>=20Would something like this work?
>=20
>=20 if (rcu_cpu_beenfullyonline(sdp->cpu) &&
>  WARN_ON(timer_delete_sync(&sdp->delay_work) &&
>  rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>
