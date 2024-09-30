Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDC18858E;
	Mon, 30 Sep 2024 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691177; cv=none; b=qHPWsZKUj9fBd9A/crxE6Br+hJPfFtIHAqMOoTwosyPl+xM86C+VQ6/JXJC42GnGPVIi+tRxNeBEb4IpYOPEN9KaJ1GzSm4OsAhV67oaBCFnDbqNaiiFFE6BYWusxFR1FidULgZTvQUu5Fm9kagAmIxtemQR7sDUtcjjHGezQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691177; c=relaxed/simple;
	bh=Iz6FpqvkzvFBZrnexnvWzVFW8uhmotoxGGp3oXUlCk4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BExAmMZVY9k4QKJSum261H9uUABeipr33j2G4wPIx9QwJgTpUDbtNkgF0t/QRgFLy/9YMHFmdd3NGbmS3tcD/a3dbIxhtml7tRcMSWCMN57UaDhLCxoZX0wLLke7KjJFox63U+QdH/3/95VEbJBOYjSvQ4Xt0VDiilQQWXB2ctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaCgK4TO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaCgK4TO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71c63a43146so1662985b3a.3;
        Mon, 30 Sep 2024 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691174; x=1728295974; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg9QbxXqBJRz1Y4pX/no4eFBUpG3N+9Vg2SGSZ259dc=;
        b=LaCgK4TOzqMdH0Mug0or0PIiQhpwg/4PWDEQjerWou0xiaINlphJpiI0hVSNUouNti
         2ZXyKTlQu6bnVJuOj1jTjP4vw9oAIQbumkH2WoA3jD2Rj1PO+EwwXVOPEgpL2WIK5mEt
         wDx1IJ0gBHu4ebWOZCVA0LhYwbwawyPw6Fm9Neyl7YiHXndgecggxS5BUFTSkBSPrp2b
         hB3ixFyPKJN7OQ9qnDCU+e9B7f48/P/GVYK4cIzdKTIOjyXsdZkpuc/Ua2Vey9Gl1OSW
         e8TEs5J324WZBAYyFA0EnVky8UsbmYT2BXBzwuxGdwWkfEXzu3cVYviIl2frNg4RKHuD
         vAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691174; x=1728295974;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg9QbxXqBJRz1Y4pX/no4eFBUpG3N+9Vg2SGSZ259dc=;
        b=gDT4qTNs7WKDpjwYHMDAokIEEaOfNDOrHRT30uX2Ke7SFia35R7pyRnBjOs228kj/M
         KDpi8KeLUiApBiVLnF6WN8qi3n90Oq7uWXtlswZFGWp5+j8d4VqmKudvL66yKb3ozQMN
         trQuQYsR/vi6h2Bj8HMiy9pOa+swwnKHPMp3yOabAfDhWrNHot4ocWKtfI3G7Q9ekN3e
         gDlVAWMsx1tmwI6NMp0SGfOVlVO5cMEGPH4WXPmAZ5getIEDCx+Q5mPayQusfacxnBdR
         71BhrUpiB7C2doT315X0gaPjbNZTx90GydeArnQN/BVfi6bICuBFn6wJKSOrc0qcd6Ln
         qwpA==
X-Forwarded-Encrypted: i=1; AJvYcCUtRMsAbuP6XV03Xr3BLZTY/z1RV7SPZeAyOjoVw3ibcUGoG+A2TyvvdVDNOgZzkRFQGHt6378z2/b/kA8=@vger.kernel.org, AJvYcCX7I8YOaSBI48jOD9FVdrkObJSd5+3RbjgVBuLpq+HhiTKigGgPFPBHNaN1zTYXvPlGmqwO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+23ObKLkMf7q8ambSwRLhQDFLUI/LnodwXWsy51NT8Jm1IvR
	8qCgpvEQ02KnROmhwD6I24lSihoF72OvY4Rw7koNyjSfnpiVdD0R
X-Google-Smtp-Source: AGHT+IHd9c7eDxtsDCp4q9aECEurM4CPotCQiS+DrDI11euKt8CbXa3cbC6GEHE9tpc+7Py5J44F5Q==
X-Received: by 2002:a05:6a00:1304:b0:70d:2e24:af75 with SMTP id d2e1a72fcca58-71b26072fc3mr18591297b3a.24.1727691174483;
        Mon, 30 Sep 2024 03:12:54 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265181f9sm5877779b3a.133.2024.09.30.03.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:12:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <c2e5b1ee-eeee-4614-9b42-d6bbf7a67162@huaweicloud.com>
Date: Mon, 30 Sep 2024 18:12:31 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF8BEE57-2F7A-4BD5-B062-F4C268E8494B@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
 <8d20cf79-9fa5-4ced-aa91-232ccd545b59@huaweicloud.com>
 <EEAE4623-DCD7-4BBE-8E06-7F6FF6E3070B@gmail.com>
 <E2551572-494D-46A0-A1D5-DF91DDB8B9F9@gmail.com>
 <c2e5b1ee-eeee-4614-9b42-d6bbf7a67162@huaweicloud.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
X-Mailer: Apple Mail (2.3776.700.51)

On Sep 30, 2024, at 17:33, Jonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> wrote:
>=20
>=20
>=20
> Am 9/30/2024 um 11:27 AM schrieb Alan Huang:
>> 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 17:15=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 16:57=EF=BC=8CJonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>>=20
>>>>=20
>>>> Am 9/29/2024 um 12:26 AM schrieb Alan Huang:
>>>>> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote=EF=BC=9A
>>>>>>=20
>>>>>> The motivation for introducing ptr_eq() is indeed because the
>>>>>> compiler barrier is not sufficient to prevent the compiler from
>>>>>> using one pointer instead of the other.
>>>>> barrier_data(&b) prevents that.
>>>>=20
>>>> I don't think one barrier_data can garantuee preventing this, =
because right after doing the comparison, the compiler still could do =
b=3Da.
>>>>=20
>>>> In that case you would be guaranteed to use the value in b, but =
that value is not the value loaded into b originally but rather the =
value loaded into a, and hence your address dependency goes to the wrong =
load still.
>>>=20
>>> After barrier_data(&b), *b will be loaded from memory, you mean even =
if *b is loaded from memory, the address dependency goes to the wrong =
load still?
>> Sorry, *b should b.
>=20
> That's exactly what I meant to say. In my understanding, it can happen =
like this:
>=20
> a =3D READ_ONCE(*p);
> ...
> b =3D READ_ONCE(*p);
> if (a =3D=3D b) {
>   b =3D a; // inserted by compiler
>=20
>   barrier_data(&b);
>=20
>   foo(*b); // compiler definitely use the current value in b
> }
>=20
>=20
>=20
> In the end, the address dependency is from the first load, and the CPU =
can speculatively (with register renaming, forwarding etc) execute
>=20
> a =3D READ_ONCE(*p);
> b2 =3D a; // speculatively
> tmp =3D load *b2 // speculatively
> b1 =3D READ_ONCE(*p);
> if (a =3D=3D b1) { // confirmed
>   foo(tmp);
> }

I get it now, thanks for the explanation.

>=20
>=20
> best wishes,
>  jonas
>=20

