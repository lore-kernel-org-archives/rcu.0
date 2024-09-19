Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD397524B4;
	Thu, 19 Sep 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775649; cv=none; b=ehHt3eFKfouaP005ZX7/tPsormxnwe+xXyhsA+gVH9q3HOIK/DyjpRzCroq5hUPN2+rM6HxnlHwvNWEj4mgO7GQqk7S8CMCJjp/uihdBikQT57ei2F3QEgk3gUZgxws9X0mr2M+vIB5vhHMHYm9diGSzr9GqyFRAxXToMlINoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775649; c=relaxed/simple;
	bh=1i45zGSiRkJTX0/fszbZu3HyTUxbdJZTSv+ySSH3i+g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iFTDldElTlkAsSBJOS4uRsbI5wWar14DH2i3/9hHP1pGPcrJ2tgefZ6JksMpEzoyqAKH8GmS9fKgQG118Vn3aL1d0l2vC8IF5dvoC+brPTFqczB0LiqfcDyPyKAw1nH3ou5Ab9wGWz/P4olaxsGBptgHpd7MKVBMwglyRsLEd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejxpJpk+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejxpJpk+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068acc8b98so12933215ad.3;
        Thu, 19 Sep 2024 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726775647; x=1727380447; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjXf6goRQFZ6Ws5IfZ8O0DYwX0AY16FeqqeJVmOvTGU=;
        b=ejxpJpk+IIGOdXVT+PQGs41+g4wsJofj4UeDBZ481X/oPtGpm2+OmfQcEj1Tg8YJrN
         SLBGbA+uuJBoxsxvoORm4yg0lt6OZOX0cR+Gqc5T1z+g9B7KqLh3S432mzICCVe/pcKL
         TRi3ISkYKK/hbR6mkSR1uKTCUfe2MXR1uvYo+/GUDFsGKzrXffFavJqhDVVqWATHApJq
         ziMbo7rFgb04Jm5QUE+NYz+BphCY0jLg2iN8PWXyFViC1fMKXuF2upTiir2XkZSQMeMn
         LbQbSZEh6E+b0Cbc/qfWPZphn11hx8JWQ3tziZH1kfhOVARA6Ow/pCAB1t1l5KlgQeHe
         J1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775647; x=1727380447;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjXf6goRQFZ6Ws5IfZ8O0DYwX0AY16FeqqeJVmOvTGU=;
        b=AvMap3dWROI3T949dsfSyOZvq9LXP2+o6YoRmAIyeV2evSdaDyHIRvguHF/+3a7mi+
         wFpEhxoP0tIlpFJ/hkUGio1jhAhhs0nmsUjI+I7gNuXCk+h3t9v3dkacOamsiTrof2yN
         87yP4Fzt+pErUbPibjuBVjJ5wLhrHGqnXNLQnOTJpH4zswk7XZsIbLalHjd6NhyGLSwi
         +86YhRu+CX0JKUAuVdseLm+ya+xRmdZJzvXl77xVdw6k4AIjhXKTJFRmEhcyvzjJXopk
         4kn2Cnxcdab6ciLoBR2eVr0BY74h61RNgnqut6w0jdy7oVHCVcHj17Wr0is5pgIAXUHA
         JujA==
X-Forwarded-Encrypted: i=1; AJvYcCUY1ZgY6V/RG+JfVQ3zvRwFy0Oj2EofzoR3/GaheMY2EnqjdFCPmROUPJ1RuAjrDbSRgBOY@vger.kernel.org, AJvYcCVU0g5bjPPPhQrZskpn6GI7y0KGzPXv3Yy64yx0NwOwtgZxjbLk4VLerCK1yUGekdgT1wXEHbaK9FjqcvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaJQtjfzLDBG+tHvo2KlPQ/9zIgySy1h1lB1MTujjjrupgJeP
	HWzJea4dHMfcMDK2vaw3RwCAk51ZBoM1ezGlzu6l83rmdL72nmYr
X-Google-Smtp-Source: AGHT+IH5dS4oXN8alWlSTmhjhkU0PXFpBaA5QFKN5xumUpTYUgMD5V/GZ5nWIJx9cLBmoKfPt4ah3w==
X-Received: by 2002:a17:902:ce85:b0:206:cfb3:92e0 with SMTP id d9443c01a7336-208d8397c0emr6902295ad.17.1726775646983;
        Thu, 19 Sep 2024 12:54:06 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19aasm83542725ad.127.2024.09.19.12.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 12:54:06 -0700 (PDT)
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
In-Reply-To: <Zux0Vyh38FK8OeJ4@boqun-archlinux>
Date: Fri, 20 Sep 2024 03:53:47 +0800
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
Message-Id: <09AD613C-97F2-4C60-8267-18E27909779F@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <CAJhGHyD8MzUssfuKSGnu1arnayNOyBnUA03vYB0WWwbE3WzoZg@mail.gmail.com>
 <ZuvOWM5c8tZotHFL@boqun-archlinux>
 <D2BDE4C4-48DB-4813-9608-F672896E0121@gmail.com>
 <Zux0Vyh38FK8OeJ4@boqun-archlinux>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8820=E6=97=A5 02:58=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
> On Thu, Sep 19, 2024 at 09:57:12PM +0800, Alan Huang wrote:
> [...]
>>>=20
>>> I think you're right. (Although the node will be eventually deleted =
at
>>> cleanup_hazptr_context(), however there could be a long-live
>>> hazptr_context). It should be:
>>>=20
>>> hazptr_t val =3D smp_load_acquire(&hzcp->slots[i]);
>>> struct hazptr_slot_snap *snap =3D &hzcp->snaps[i];
>>>=20
>>> if (val !=3D snap->slot) { // val changed, need to update the tree =
node.
>>> // Already in the tree, need to remove first.
>>> if (!is_null_or_unused(snap->slot)) {
>>> reader_del(tree, snap);
>>> }
>>>=20
>>> // use the latest snapshot.
>>> snap->slot =3D val;
>>>=20
>>> // Add it into tree if there is a reader
>>> if (!is_null_or_unused(val))
>>> reader_add(tree, snap);
>>> }
>>=20
>> It seems like that two different hazptr_context can=E2=80=99t be used =
to protect the same pointer?
>>=20
>> Otherwise the following can happen?
>>=20
>> thread1  thread2    thread3(worker)        thread4
>> hazptr_tryprotect(hzp1, ptr1)   hazptr_tryprotect(hzp2, ptr1)=20
>>  add ptr1 to tree
>=20
> Note that we have snapshot rb_node for each hazard pointer slot, so =
here
> thread3 actually would add two rb_nodes with ->slot =3D=3D ptr1 here.

Ok, good to know the rbtree can have multiple nodes with the same key.

Thanks for the explanation!

>=20
>> hazptr_clear(hzp1)=20
>> hazptr_tryprotect(hzp1, ptr2)=20
>>  delete ptr1 from tree     unpub ptr1
>=20
> Therefore, there is still one rb_node with ->slot =3D=3D ptr1 in the =
tree
> after the deletion, so updaters won't invoke ptr1's callback.
>=20
> Regards,
> Boqun
>=20
>>        call_hazptr(ptr1)
>>        oops: invoke ptr1's callback
>> Or am I missing something?
>>=20
>>>=20
>>> Regards,
>>> Boqun
>>>=20
>>>> I'm not so sure...
>>>>=20
>>>> Thanks
>>>> Lai


