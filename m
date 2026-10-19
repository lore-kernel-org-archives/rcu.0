Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E650F130
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419131; cv=none; b=peFht/tIWQ2eFrTiE/GiE8VFi/hm/itJDaMjco1QqpA5DPnm+IN+EQ4GPToJXFvZPZPXc7ITyhyRyVRzmkQ6SqziejlJdr4f7/uzlihT8thkGchJTLZqHpbSg9oZ/sCIWNQ1Eg3d2JjW+fYrRG55fdWwc0CV453XnrZ2R1taeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419131; c=relaxed/simple;
	bh=IMvFsrCwn7qeypROvjh1nqoqPfJPzH9zWkbUuwtQKmk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VyX4cuc6uCSaVBiH/LHdOlixpmZBq1RccXY3d+7dA5DEojuUOfVuxl+M9hkMw8SwGgh1cGa9RnX4RmwBg8JCipebCF/xu6lfcpmncFJ1q276e74Ryq9UridKvTAynBBYTaLZe8xkGr3ik+/D6eORqQNsef+3i4KXrFDZ7vXlwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bF4kFf8s; arc=none smtp.client-ip=95.215.58.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bF4kFf8s"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IMvFsrCwn7qeypROvjh1nqoqPfJPzH9zWkbUuwtQKmk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792419126; v=1; x=1793023926;
 b=bF4kFf8sJyEzCtIJyWZhfAQWXOxR6xOHw5J35ALYc1PHAwr0dzJW+/HFOGRugIuKPDn4pZ5Q
 6ezs8vBgx/nE6XNVrSrSUxr3IduYXNrGjUkWgiZuyiquRDfc0lBN+2exocs6q+EahRBCAzbkDSj
 M6cCh1pWNzu9MjTK2PI+FyFo=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e8b7054e2c39b6d;
	Mon, 19 Oct 2026 14:12:05 +0000
X-Mizu-Trace-ID: 2e8b7054e2c39b6d
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 14:12:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <83989eafc54772384acb9faad1c40ec6e530f4af@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] doc: Update recent SRCU API additions to whatisRCU.rst
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 urezki@gmail.com, boqun@kernel.org, kunwu.chan@gmail.com,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261011001523.GA2491714@joelbox>
References: <20261010102813.25460-1-qiang.zhang@linux.dev>
 <20261011001523.GA2491714@joelbox>

>=20
>=20On Sat, Oct 10, 2026 at 06:28:13PM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> The commit 'dab06d6f9379 ("srcutree: Add an atomic Tree SRCU")'
> >  introduces some new APIs:
> >=20=20
>=20>  srcu_read_lock_atomic
> >  srcu_read_unlock_atomic
> >  synchronize_srcu_atomic
> >  DEFINE_SRCU_ATOMIC
> >  DEFINE_STATIC_SRCU_ATOMIC
> >  init_srcu_struct_atomic
> >=20=20
>=20>  This commit therefore update thems to whatisRCU.rst.
> >=20=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Hi, Joel

I have been update v2 resend.

Thanks

>=20
>=20Applying for 7.5.
>=20
>=20thanks,
>=20
>=20Joel Fernandes
>=20
>=20>=20
>=20> ---
> >  Documentation/RCU/whatisRCU.rst | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/w=
hatisRCU.rst
> >  index e6767baff2d3..75c50f2f6d79 100644
> >  --- a/Documentation/RCU/whatisRCU.rst
> >  +++ b/Documentation/RCU/whatisRCU.rst
> >  @@ -1209,11 +1209,13 @@ SRCU::
> >  srcu_read_lock_nmisafe start_poll_synchronize_srcu
> >  srcu_read_unlock_nmisafe start_poll_synchronize_srcu_expedited
> >  srcu_read_lock_notrace poll_state_synchronize_srcu
> >  - srcu_read_unlock_notrace
> >  + srcu_read_unlock_notrace synchronize_srcu_atomic
> >  srcu_down_read
> >  srcu_up_read
> >  srcu_down_read_fast
> >  srcu_up_read_fast
> >  + srcu_read_lock_atomic
> >  + srcu_read_unlock_atomic
> >  guard(srcu)()
> >  scoped_guard(srcu)
> >  srcu_read_lock_held
> >  @@ -1229,8 +1231,11 @@ SRCU: Initialization/cleanup/ordering::
> >  DEFINE_STATIC_SRCU
> >  DEFINE_SRCU_FAST // for srcu_read_lock_fast() and friends
> >  DEFINE_STATIC_SRCU_FAST // for srcu_read_lock_fast() and friends
> >  + DEFINE_SRCU_ATOMIC
> >  + DEFINE_STATIC_SRCU_ATOMIC
> >  init_srcu_struct
> >  init_srcu_struct_fast
> >  + init_srcu_struct_atomic
> >  cleanup_srcu_struct
> >  smp_mb__after_srcu_read_unlock
> >=20=20
>=20>  --=20
>=20>  2.17.1
> >
>
