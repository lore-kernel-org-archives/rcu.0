Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F812E4A;
	Thu, 19 Sep 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762224; cv=none; b=NaoIrl4G17b/8DMJsFMujDB7TNVPVpmRuFHZH54ILsHVZHxEVvZuHjoazlyY9EZXX2oHuzkcBquw+trPHwF4xDZIks7a/aeYUJhDMsg+z5CgAsyR9WHJ3EI2wP4+skujDaxkv6YOWpmo0Pr6DjdPXMuXSBMqmz4y5BOm+96jWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762224; c=relaxed/simple;
	bh=TeWxYNML4uZ1URMQu31Nx1o53ehLgcKlEXaVaXJx29k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cc1Uc/cdw+sVcn57Tuxzon69f3J/mAUFug3YSRqVQ0r+7l2iLDPVdYThfDNhwVjXO7iCvnIB8ArbGPVSkkQe2hnS7rVYctUUr5pNiaDugiIwOb1fP3naF8yfrQdtgacd5lwjYXTLoU1CElsReFYYP+Kn1ovQ9ZB6JsMWaBj+In8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA/rmoFH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA/rmoFH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2059112f0a7so10886565ad.3;
        Thu, 19 Sep 2024 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726762223; x=1727367023; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY/fGPKseiN5XtuGoO/dNcX3n8cZ54goexwrvXf3OMI=;
        b=BA/rmoFHpjILmFlUvHVStZgcjzhFfUNu6LlNubzaurEj3smtOpvABhqmFmQvvfYfCU
         8+wAVb/6RbHvQp2s1cBz5HgdP/Oh7OgQ6Tw0jcp6ASrHd2PhNcosJTKr0oblEcnIixwz
         J4b+ThfAOcisPTyb17H3caZaEiBM4MlQiea+Ll4+gV7pKsCquSsLTLU763+l7U0SJjxm
         ByTMmTCNpYdyfk+8qqUvWH2M6pOkPIpbbGoAS9qviZeDgpZZ1P5GQTO8PS8I969z4m49
         I7lV72yJ4YgwdtDBwFkSxN20LHwwsNIotdCyx3nruZ8G2NkDnrwczhweRALziL5uWWMg
         GzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726762223; x=1727367023;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY/fGPKseiN5XtuGoO/dNcX3n8cZ54goexwrvXf3OMI=;
        b=d4OMoEWwTXUXcO46i3pK4z1lW/mkfR/stqy7Rv3NIwSY9CoSLs1WTSlkxf8dlFFxqI
         ONvw5oYC35NfqBAGdRJSZAhfCcLDtWY0w9GMuw6rmTi5qf7h2/0Bktze/7xP9Xi0p3kn
         GVGf/bmGBdXOqb6g9sFw7dEaE6dxkQswugvasZNri+uqO99KGIMvIs29KLQP+Xqxqkrp
         5sJOatGjlyyopWabsU6R8J5v29n5OYaKh1Rt6uIoOZM/x5JwKG1WvbE4t+50ZnkosxBi
         iL8UiEM45xYdrYGpJMhSctK+/8QcwOJbgCAJ6a2bmJldWVd5kSMJMim1ARjleVLvmUMu
         K+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMKRY8cOS87ykRpmAVHCIzp7rX6i4zYNzjqYolg9YhDL/RZmdnTISeLRHUtW2gGd7a5ZTiBoMgsXJSz4E=@vger.kernel.org, AJvYcCXJ8gQF+xa+k3SpV7jtN92kNHz3cju7hjQilM4Pmo0daSTqZeAjyXPLpYV1uaOV9TKYtC8f@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWI7hGDppi5VeOoD1qXf8Jc88jJ/J1L5bGLP6rvWCa7DAJx1i
	vMd/HgslJCIgHf7pKhYl8HqJsg+2cOM6+EWSecBehXuL9YLhsznH
X-Google-Smtp-Source: AGHT+IE63MOrtSDNRE1puuTOcxVEkzUx9edmw7szWrDYdYgkMNwLAGdFxq+KU06AHJcAn9dSKTtEfw==
X-Received: by 2002:a17:902:ea09:b0:206:9399:5dd7 with SMTP id d9443c01a7336-20782c16174mr330479015ad.56.1726762222437;
        Thu, 19 Sep 2024 09:10:22 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d17fbsm81702445ad.152.2024.09.19.09.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 09:10:21 -0700 (PDT)
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
Date: Fri, 20 Sep 2024 00:10:03 +0800
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
Message-Id: <28F2EAFF-1DF6-41EC-9DFC-3B437D67D840@gmail.com>
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

Even using the same context, if two slots are used to protect the same =
pointer, let it be ptr1,
then if the second slot is reused for ptr2, ptr1=E2=80=99s callback will =
be invoked even the first slot still has the ptr1.

The original patch also has this problem.

>=20
> Regards,
> Boqun
>=20
>> I'm not so sure...
>>=20
>> Thanks
>> Lai


