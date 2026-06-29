Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9503FB074
	for <rcu@vger.kernel.org>; Mon, 29 Jun 2026 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751783; cv=none; b=FbmHlO9QozpTirlXBXJIbFRpMXwFIZ3j8i6ceNnBpzEADFcc4C6h7peG4NToH0+P4KDAvbncAwCh4/zv3EkxMBdEx7WuaXHWEEG2BsKavjku9VfKhJDBOiSel+B/C11lJI7Iyx47o4/W+7RvV6GzgzZoA5ClZ3NEJW6hQPcmNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751783; c=relaxed/simple;
	bh=/c/td0l49GrTYIdOiDvTBEx5r+8NUhgWFGP30RpUw5g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pJCaC/daW9XcqaK96+o8XgKGZurEYZNvHQ4Wb+iWg1aN5H6WoEQ9MdIHfDzz1cHpqNKA/4/gOEfe7adl6bKMDAyPRYwCrbPYTFKtJLFzynBBLcADqai2NzGkvzVtQv0zj2YrqADGecL05+8dNa91+EM4yhPzs2sBTt+G6q4JIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FL1NklTV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FL1NklTV"
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782751779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUtYpDl1uQ44PbsZ1biMHpyJk3g/3hXd1zmMGA9K3Q4=;
	b=FL1NklTVO0od/kaqvRwWq3gW0vfYCX7GLsAxVpRk0KP4mXu8YI55xjwEkiaBLQZNyxVQAX
	DZo95wfdB5MgUhtR1u0A4Bq6kstozqeE2jYKmTUDfSeIS8jFxBljMbECABne2wO1pca1J1
	PkaQwae/BJBKvuUaRXL0ojohOrnhf+U=
Date: Mon, 29 Jun 2026 16:49:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <70ecf76276244a204b36164858ba85d78e8a5061@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
To: "Usama Arif" <usama.arif@linux.dev>, lkmm@lists.linux.dev,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 marco.crivellari@suse.com, paulmck@kernel.org,
 rafael.j.wysocki@intel.com, rdunlap@infradead.org, riel@surriel.com,
 sshegde@linux.ibm.com, tglx@kernel.org, ulfh@kernel.org,
 yury.norov@gmail.com, rcu@vger.kernel.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
In-Reply-To: <b0d88052-64d6-40c1-a728-7242bfbcda1b@linux.dev>
References: <20260622163807.4187558-1-usama.arif@linux.dev>
 <1030b968-4184-4818-99dc-aeb0956ef6a3@linux.dev>
 <b0d88052-64d6-40c1-a728-7242bfbcda1b@linux.dev>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B46=E6=9C=8824=E6=97=A5 23:27, "Usama Arif" <usama.arif@linux.=
dev mailto:usama.arif@linux.dev?to=3D%22Usama%20Arif%22%20%3Cusama.arif%4=
0linux.dev%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 24/06/2026 15:15, Kunwu Chan wrote:
>=20
>=20>=20
>=20> On 6/23/26 00:38, Usama Arif wrote:
> >=20
>=20> >=20
>=20> > __csd_lock_record() publishes per-CPU CSD debug state that is rea=
d by
> > >  csd_lock_wait_toolong() on another CPU. The remote side first read=
s
> > >  cur_csd with smp_load_acquire() and, when non-NULL, may then read =
the
> > >  matching cur_csd_func and cur_csd_info fields.
> > >=20
>=20> >  Use smp_store_release() when publishing cur_csd so that the prec=
eding
> > >  cur_csd_func and cur_csd_info stores are ordered before the pointe=
r
> > >  that csd_lock_wait_toolong() acquires. This replaces the open-code=
d
> > >  smp_wmb() plus plain cur_csd store with the release operation that
> > >  matches the smp_load_acquire() in csd_lock_wait_toolong().
> > >=20
>=20> >  For the clear path, use smp_store_release(&cur_csd, NULL) so tha=
t
> > >  clearing the diagnostic state remains ordered after the preceding
> > >  callback/unlock work, without requiring a full barrier before the
> > >  store. On x86 this removes the locked full barrier from the clear
> > >  path; on weaker memory models it uses the release operation needed=
 by
> > >  the smp_load_acquire() in csd_lock_wait_toolong().
> > >=20
>=20> >  The old code also had smp_mb() calls around cur_csd updates. Tho=
se would
> > >  only be needed if cur_csd were treated as an exact live-state mark=
er whose
> > >  publication had to be observed before callback execution or CSD un=
lock.
> > >=20
>=20>  =C2=A0The original comments around those updates seem to suggest a=
 stronger
> >  relationship:
> >  =C2=A0 /* Update cur_csd before function call. */
> >  =C2=A0 /* NULL cur_csd after unlock. */
> >=20=20
>=20>  The changelog characterizes cur_csd as best-effort diagnostic cont=
ext.=C2=A0
> >=20=20
>=20>  Is there prior consensus that cur_csd carries no ordering relation=
ship=C2=A0
> >  to callback execution / unlock state,=C2=A0
> >=20=20
>=20>  or is this patch effectively relaxing that historical assumption?
> >=20=20
>=20>=20=20
>=20>  Thanks,=C2=A0 Kunwu
> >=20
>=20Thanks for the review Kunwu!
>=20
>=20The patch preserves the ordering that reader actually needs:=20
>=20csd_lock_wait_toolong() observes non-NULL cur_csd, the matching func/=
info have
> been published. If it observes NULL, the prior callback/unlock work is =
ordered
> before the clear.
>=20
>=20So yes, this relaxes the historical implementation ordering around th=
e
> diagnostic marker, but not the CSD execution/reuse ordering.
>=20


Thanks=20for the v3 update. The explanation of reader-side tolerance for=
=20
snapshot-vs-completion=20races addresses my concern.


> >=20
>=20> >=20
>=20> > CSD stall warnings do not currently have RCU-style stall-ended ch=
ecks, so
> > >  they already allow the stall to end while diagnostics are being as=
sembled.
> > >  The cur_csd record is therefore best-effort diagnostic context, no=
t a
> > >  precise completion/stall boundary.
> > >=20
>=20> >  Signed-off-by: Usama Arif <usama.arif@linux.dev>
> > >  ---
> > >  v1 -> v2: https://lore.kernel.org/all/01437928-ff79-4d8e-823b-7f20=
146946f6@linux.dev/
> > >  - Document where the smp_store_release() synchronizes with (Alan S=
tern,
> > >  Randy Dunlap and Paul McKenney).
> > >  ---
> > >  kernel/smp.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > >=20
>=20> >  diff --git a/kernel/smp.c b/kernel/smp.c
> > >  index a0bb56bd8dda..685829875a3e 100644
> > >  --- a/kernel/smp.c
> > >  +++ b/kernel/smp.c
> > >  @@ -182,16 +182,22 @@ static atomic_t csd_bug_count =3D ATOMIC_INI=
T(0);
> > >  static void __csd_lock_record(call_single_data_t *csd)
> > >  {
> > >  if (!csd) {
> > >  - smp_mb(); /* NULL cur_csd after unlock. */
> > >  - __this_cpu_write(cur_csd, NULL);
> > >  + /*
> > >  + * Pairs with smp_load_acquire() of cur_csd in
> > >  + * csd_lock_wait_toolong(): orders any preceding CSD
> > >  + * callback/unlock before a remote reader observes NULL.
> > >  + */
> > >  + smp_store_release(this_cpu_ptr(&cur_csd), NULL);
> > >  return;
> > >  }
> > >  __this_cpu_write(cur_csd_func, csd->func);
> > >  __this_cpu_write(cur_csd_info, csd->info);
> > >  - smp_wmb(); /* func and info before csd. */
> > >  - __this_cpu_write(cur_csd, csd);
> > >  - smp_mb(); /* Update cur_csd before function call. */
> > >  - /* Or before unlock, as the case may be. */
> > >  + /*
> > >  + * Pairs with smp_load_acquire() of cur_csd in
> > >  + * csd_lock_wait_toolong(): publishes cur_csd_func and
> > >  + * cur_csd_info before the non-NULL pointer becomes visible.
> > >  + */
> > >  + smp_store_release(this_cpu_ptr(&cur_csd), csd);
> > >  }
> > >=20=20
>=20> >  static __always_inline void csd_lock_record(call_single_data_t *=
csd)
> > >
> >
>
