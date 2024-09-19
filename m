Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804421E4B0;
	Thu, 19 Sep 2024 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749228; cv=none; b=mz0ue1AeVUNeHzqnEl4Tr11TkCd1ikdyH4xUrOQgYa4hhTiW6AaHudRZfL1fgmWzEVgxSKni80gkUn0MqB860tz2MqX0gwPQVLHlPFdAw0YKyk77qXd5v1BATZOo7TnjsM+owvhNYDv5n6hKUhnal1lNF3MqBcm0YsH8w5bR92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749228; c=relaxed/simple;
	bh=V/jzswor5s1CzAW0ZUtaQ2xScydnXC/HzCHeyQzuX6s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Azi+UkWXDyilCFgSodJ744eLihr4UVP8xO8WMnYtOQ5bHQYsJVTcvSt2pAc3ErXAlsZos1VHT9oRmMb3tl7A/KxIIpHe65lhz/5wywDYzj//hRG+pwqhD48H2ynAr+cZc7j6lgr6DkxFls8JiiwOMstlyIVpzeq0wMLgXtuBwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NICXe5eX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NICXe5eX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2db89fb53f9so571616a91.3;
        Thu, 19 Sep 2024 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726749227; x=1727354027; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmKwDE+vQbJFZKx1pG1WdGf3eu6TWhTPyNHtYBECpZw=;
        b=NICXe5eXb4Md/OOxiDtmXZ09t1qa7naKQ9UD7vFL/O/4ENBF1gdUjCkA6e/ZxKbp5e
         dBuinMNuj9yEtaRirMWNIwcW0frXQQaiPGD1F+xnJxOKE8PkbOHMtgdcVM0V4F1rQsvk
         jujrgPeUiFuEPX0fHJb9z+uPqX/NqQYQphVAhucl8np8ncYxrjrLhHR+qpfAGXXe4NMZ
         obj1wiMmFlfvkHjitOXfk+fRtcY/sXZmDD6Yb0T5H1n4z6Y48brc/+TFlswN8AMbgy1l
         d+I5cIkbGVyc8RhNT0lcnN+ML1TOdbQRMDZTI4iZzP0ie368v+lvcl3xLyMEEkkdy/fR
         WPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726749227; x=1727354027;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmKwDE+vQbJFZKx1pG1WdGf3eu6TWhTPyNHtYBECpZw=;
        b=kTREs4VAMJB4PMMBDOhlKzZdFNcnz0v3g15xDlYZxqgPIKhmp3YhnF3T8OGaYm4NLL
         Rihn4od4S6wEpKNviN9mlXZMgjkeEl+j6M7vWEjH4O+Vd2Aip7K+Y9/sJu1jZ13xhYnR
         m9PpFDYF1LJ6BMoZdwo8+KK7n0EpDC7MmxaJDwwfPBsQmPa0zr2FEL0ar+i/VySoiy9p
         R1Hj4oXoChYpPwcHy2euLUvSxTlYHD5YevDHbO2YA8GJdoV3arGyQ92rCCqrOldRvLbK
         aYk4W7LSdE7lTVbHnI2X0x+v8WGdFOiFIvQxv7qpGm6QY8uy8TfiHHdmnXOd0Ic/05E4
         tqVg==
X-Forwarded-Encrypted: i=1; AJvYcCVqhBm3GJNBGxj+CEvZEmjJrolqDkxLs0ABkwe/IU7H0A+/Z4y5a6FPRtDf5zcmgcntoB72b/mjGCVfYcg=@vger.kernel.org, AJvYcCX8u8ti5efRLYm7AZyG8tjbGkapKegvZE8XKQigsrhDcRm32YAJT0lSAD5bSEf6VYqSL/r3@vger.kernel.org
X-Gm-Message-State: AOJu0YyTA2MBdDQ2GQeRys2CpAvAxba7IRqeaBcoWH9OMTAAE/d7gY7z
	KylpQZD5AKB9kvDTc6W3fmSZqL3f6ERcBs7BSvORbiGHnGE5OAOB
X-Google-Smtp-Source: AGHT+IEjFLx9rHSbMjqqXE9JnSVpBQ8FdB0R34tyP1bgjc3xd0VMFuHdGq+CTtZA/pDsiECQAkLVBA==
X-Received: by 2002:a17:90a:6888:b0:2c4:e333:35e5 with SMTP id 98e67ed59e1d1-2dba00826f1mr31425087a91.36.1726749226750;
        Thu, 19 Sep 2024 05:33:46 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee898b6sm1673500a91.6.2024.09.19.05.33.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:33:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <ZuvOWM5c8tZotHFL@boqun-archlinux>
Date: Thu, 19 Sep 2024 20:33:27 +0800
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B551C0A-3E09-45E2-9A00-03DEDB1EFEA7@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>
 <ZuvOWM5c8tZotHFL@boqun-archlinux>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8819=E6=97=A5 15:10=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
> On Thu, Sep 19, 2024 at 02:39:13PM +0800, Lai Jiangshan wrote:
>> On Tue, Sep 17, 2024 at 10:34=E2=80=AFPM Boqun Feng =
<boqun.feng@gmail.com> wrote:
>>=20
>>> +static void hazptr_context_snap_readers_locked(struct =
hazptr_reader_tree *tree,
>>> +                                              struct hazptr_context =
*hzcp)
>>> +{
>>> +       lockdep_assert_held(hzcp->lock);
>>> +
>>> +       for (int i =3D 0; i < HAZPTR_SLOT_PER_CTX; i++) {
>>> +               /*
>>> +                * Pairs with smp_store_release() in =
hazptr_{clear,free}().
>>> +                *
>>> +                * Ensure
>>> +                *
>>> +                * <reader>             <updater>
>>> +                *
>>> +                * [access protected pointers]
>>> +                * hazptr_clear();
>>> +                *   smp_store_release()
>>> +                *                      // in reader scan.
>>> +                *                      smp_load_acquire(); // is =
null or unused.
>>> +                *                      [run callbacks] // all =
accesses from
>>> +                *                                      // reader =
must be
>>> +                *                                      // observed.
>>> +                */
>>> +               hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
>>> +
>>> +               if (!is_null_or_unused(val)) {
>>> +                       struct hazptr_slot_snap *snap =3D =
&hzcp->snaps[i];
>>> +
>>> +                       // Already in the tree, need to remove =
first.
>>> +                       if (!is_null_or_unused(snap->slot)) {
>>> +                               reader_del(tree, snap);
>>> +                       }
>>> +                       snap->slot =3D val;
>>> +                       reader_add(tree, snap);
>>> +               }
>>> +       }
>>> +}
>>=20
>> Hello
>>=20
>> I'm curious about whether there are any possible memory leaks here.
>>=20
>> It seems that call_hazptr() never frees the memory until the slot is
>> set to another valid value.
>>=20
>> In the code here, the snap is not deleted when hzcp->snaps[i] is =
null/unused
>> and snap->slot is not which I think it should be.
>>=20
>> And it can cause unneeded deletion and addition of the snap if the =
slot
>> value is unchanged.
>>=20
>=20
> I think you're right. (Although the node will be eventually deleted at
> cleanup_hazptr_context(), however there could be a long-live
> hazptr_context). It should be:
>=20
> hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
> struct hazptr_slot_snap *snap =3D &hzcp->snaps[i];
>=20
> if (val !=3D snap->slot) { // val changed, need to update the tree =
node.
> // Already in the tree, need to remove first.
> if (!is_null_or_unused(snap->slot)) {
> reader_del(tree, snap);
> }
>=20
> // use the latest snapshot.
> snap->slot =3D val;
>=20
> // Add it into tree if there is a reader
> if (!is_null_or_unused(val))
> reader_add(tree, snap);
> }

With this changed, and force users call hazptr_clear() like =
rcu_read_unlock(), we could remove
the reader_del() in cleanup_hazptr_context(), then remove the =
tree->lock?

>=20
> Regards,
> Boqun
>=20
>> I'm not so sure...
>>=20
>> Thanks
>> Lai


