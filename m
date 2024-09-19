Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CB19D8BB;
	Thu, 19 Sep 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754258; cv=none; b=sqq/hh9Wg6wCc3lBOg2UHvclom1tcEXMKnxngfgAJxEw/oFna0S5tAGXS6GTvfKmn91RpcBeEAaS5NCprvELon2F755oke/xj9JlNLVcOtGThyhSlNx0KQMQfTx/l7BweFknfayw15zMxvs2CLXtGNSh76PtmZzMuOh0kayjwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754258; c=relaxed/simple;
	bh=rlSCdSdxPLC0z0AuFMduwMBmz9enE8vC/LaQSYEVWiU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YG8fRADcmFL6jmkrQwQIGh36OhbFVcjE3NN7kVH2OqvFoaxW1lri/2HFTgmfLLtUoaKjOMWJU55wM+RyUTZ3WHngEsdbsO1KthIa3LNF8/tD7hh4Pe1F+5ztQ6OqsY3YLLak5L96TJWCsNXPvHQV5zwWDR9QdIXWEfkHElC3t7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpZ1f1b8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpZ1f1b8"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7191fb54147so647686b3a.2;
        Thu, 19 Sep 2024 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754257; x=1727359057; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9KoiB0YsZBX4kdWY2koiL+vhQxEK5DgJarh6ifR10c=;
        b=XpZ1f1b83mH2o/UTfnQRHs/h/eDFlqTyx3qLY5RYd7OMl3WizQRFyEdlXKQPIWoRUH
         2foTJv3YyF4kd8AB42z9ORhzUTStsGtGLKmWLYs9ozgoT9nN3NHasDGD5fbfNsqDpawW
         rUc+gYaKJEMNV8f7r/3F5Yt+4QoCMywFNBuf4I2/HhUEJZ99l57G3erZoAgVSQ2S98dY
         dg7hp88+1heDkXW/IEq9yh/dDp2DZJsSI6V8EZlqxwS9ZHzAZk3Tn3NnNCk7XN2bphv9
         vGgiyyV80WicPMTPIvjt/Aeup3Br1bmBjEnfubTZyPSRhGiZmDlf9U53B84CTCUxdydP
         hzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754257; x=1727359057;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9KoiB0YsZBX4kdWY2koiL+vhQxEK5DgJarh6ifR10c=;
        b=MPo+WKZi4VfjivRGO9MBtnSPGg+cVOeVhoefJuLqQEuEqA7IytmIT5epQluLD61dZc
         nG+wobwFKq/+oUyVNsxMUMwTKrk57dBGasavVcw/BnlFGYW08THBDJd7mZekkGu6wX+1
         1dJQRoHm5Ky7lhZxkPKvcBs3F9i7APhQxDCk8kLHha15nGqPix2gpS7RzvDv3yfUV09z
         49uE3vu920bLoWCn5uDftHEekPaS6KpxaNTVNMPnQy9Ncf8Sx+obPuPD3IZfnii/SQK2
         g0/bGLS01JjRBWL3WocRAQpSHpQyNvCUFsKupvHPuKHsUaaoniv7qMn3xFKycy4nzFAd
         Qzaw==
X-Forwarded-Encrypted: i=1; AJvYcCU3oOMcoyW6aIII9YTdNfw/zcywx5GsN2kA9jwB18Aaz7fpIesFm7AiyDPOjjaLv0IgbsuV@vger.kernel.org, AJvYcCWlCNp3HyODdXD92FAdWzWDAKhoF8iOhIC6J1Bf+1DTDBjX4IkWEfNFvS8usgTsvzrTYN1PibyLrnX2vuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkfcx7oWMsGvf3ou+Cdspj/CjFstmjR8FhMtLU6YUCRU3KG8F
	LkPFrLnbUi1Ld/UIn+YRg3K9dZ5s2GZcV+ZYKJ4hhTd2M6zc9aMQSMXuyKBbin8=
X-Google-Smtp-Source: AGHT+IG3NM9cbEsGODVNJC/nw53fZr59xEmoESCbE/ZFVMlqAxM2UadkXcrIOGgUj+nimzv9M+wsaw==
X-Received: by 2002:aa7:8895:0:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-719261eca18mr41957713b3a.21.1726754256588;
        Thu, 19 Sep 2024 06:57:36 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc543dsm8267246b3a.204.2024.09.19.06.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 06:57:36 -0700 (PDT)
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
Date: Thu, 19 Sep 2024 21:57:12 +0800
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
Message-Id: <D2BDE4C4-48DB-4813-9608-F672896E0121@gmail.com>
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

It seems like that two different hazptr_context can=E2=80=99t be used to =
protect the same pointer?

Otherwise the following can happen?

thread1 					thread2  			=
		 thread3(worker) 	      thread4
hazptr_tryprotect(hzp1, ptr1)   hazptr_tryprotect(hzp2, ptr1)=20
										=
		 add ptr1 to tree
hazptr_clear(hzp1)=20
hazptr_tryprotect(hzp1, ptr2)=20
										=
		 delete ptr1 from tree     unpub ptr1
										=
						       call_hazptr(ptr1)
										=
						       oops: invoke =
ptr1's callback
Or am I missing something?

>=20
> Regards,
> Boqun
>=20
>> I'm not so sure...
>>=20
>> Thanks
>> Lai


