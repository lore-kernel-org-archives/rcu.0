Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E622AEEE;
	Sat, 28 Sep 2024 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727565195; cv=none; b=RRgDmYPgDlTaQ0k0BTNcyVhBzg6rsnENAUgTRBfgkPRlULWdM+fJDmL//Ok3kQ2ZuQYQrZBryIZnChu9ywQLSloiPTCtAcciPsKZIzPcTJ7ypGph6dzk1JoUw1WlajG9CSp8j1ADoQBW6cD0ObAawmMLIoeP1QqdJYDiRWAn1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727565195; c=relaxed/simple;
	bh=xDhJtQezYDQhYGdc7LW28hqcUGAUnvcmud6T657Ut/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nK/oira+4BdWOA/1q9h56Hpm64MIKO7O0K3j+SZTo9d00oOBqMuma17QOfyO7Z3eojIkW9MKMm42ipfta7Lu9e94pPukywEY6dAj7gW2DpxXIloFPcT6eQuLiTTYqtGkf+2vk56jj+nwb8vF82aHOnxrkNLvnQTy1aVywl4dUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg3df5dM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg3df5dM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20551eeba95so31950825ad.2;
        Sat, 28 Sep 2024 16:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727565193; x=1728169993; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlXRms7F/yIYEZIpY96anVWqMAu7/hjyZTvOiryivSE=;
        b=Gg3df5dMW6aHeFQjwsLgchrD4bsND/kPSjl4f2grnCj4A8Uf4XQj7K9+eHTU2WwqC7
         CGxTHJupEHFpT3UjwO0duZuuTYvp3Jii6vrm549lw94bDbnVEzSkjNXo7X6C7jJY8pi4
         eCgZjhJ7P7FGqXsbdxXFeAHePaXd6nl9Nap2L5qff8fipyMy8HQtDWmCDJRJMuiY57o0
         2nw/1JxpJFLl2RWDRISFpruz2svfHPafTCoextnuxaoAM3jZ3ZEFQyycNVae0gHgPB1G
         DML+9fkI7cT6IMhJAvkpsh9Cz/pChSnbDCSbhE263lYm3Vs+AZHOrcdbnS5mTMxt2cU/
         qDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727565193; x=1728169993;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlXRms7F/yIYEZIpY96anVWqMAu7/hjyZTvOiryivSE=;
        b=SIo5HyEAhX/aL3fyMyKYL3v8arZw/a3zpBl4xyGdNOKMYrpC3iK5bjzOq8SaP+abhB
         VPa4XmIkg1c6uxBJ7ZctPy3z3nFgbNbPHzbRx5GCtNY5T7B7vviFusFYMCNlAoEjphbv
         VbSKXvbaol+4YJfASYi7zPFT9jKUMJ9//hwUbfiOmwg9uEdNubOs5YLFKplRTpOV8hzb
         2A02D7ipdqGouyBUuXp8EkkNnSgdN8m5dIolZZGaSBYjVc3qg0ey+AzTNYW8TTqV/Xd0
         yJ8xZUNgT/fWb4jnoRrmVhDp+INZrrV40nZ1PRtbwgpTLh3B215Ul6irov3w4JpU2shm
         AAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULP7s7GQOAGNpBVNYfaVhaPozye+d+PSLU+kMOwevJ8cWsht6WV7RFLFxHiWdP+ZvVlq6/8I+7Ce06zcc=@vger.kernel.org, AJvYcCWwSlooaLLW00nGAo2PDWFH40Of/2zxI97iqRE4oLGiTFOF2oRRtQkKNr70si2fNVNNtd20@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+i0oiyWAMrCqZ9pvmL0bakqSaxqQtqHFN/Bj6u4oIMeOSW93
	RT0OP+82kq5XcPuW7H/fHDLxZguYAO6/+UdYr4ZAPXSzM1oS2NZQ
X-Google-Smtp-Source: AGHT+IE2sBYP1tAvZqMQRpXmx8wMXmRsA3LnUmxXborZPEfW+jZDkloOvwEfncz/nFiCQJfXofJTmQ==
X-Received: by 2002:a17:902:d4c3:b0:20b:7731:e3f8 with SMTP id d9443c01a7336-20b7731e676mr1645985ad.26.1727565192698;
        Sat, 28 Sep 2024 16:13:12 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0fa94sm31491515ad.135.2024.09.28.16.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2024 16:13:12 -0700 (PDT)
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
In-Reply-To: <5F741990-7A14-4528-9AF8-817007689B0A@gmail.com>
Date: Sun, 29 Sep 2024 07:12:53 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Neeraj upadhyay <neeraj.upadhyay@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C78F7BBA-860A-412D-B2B7-5028C5540695@gmail.com>
References: <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>
 <ZvY2zBiluLkqRSkc@boqun-archlinux>
 <62508c1f-66ca-450d-abb6-236ca3b9096d@huaweicloud.com>
 <d86536d9-9c5a-48ab-abf3-3483e2e5e980@efficios.com>
 <4ed833df-54e6-454a-ab1a-73967cc51054@huaweicloud.com>
 <5F741990-7A14-4528-9AF8-817007689B0A@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8829=E6=97=A5 06:10=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> wrote=EF=BC=9A
>=20
> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 06:18=EF=BC=8CJonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> wrote=EF=BC=9A
>>=20
>>=20
>>=20
>> Am 9/27/2024 um 10:10 PM schrieb Mathieu Desnoyers:
>>> On 2024-09-27 21:23, Jonas Oberhauser wrote:
>>> [...]
>>>> That idea seems to be confirmed by this (atrocious, not to be =
copied!) example:
>>>>=20
>>>> int fct_escape_address_of_b(void)
>>>> {
>>>>     int *a, *b;
>>>>=20
>>>>     do {
>>>>         a =3D READ_ONCE(p);
>>>>         asm volatile ("" : : : "memory");
>>>>         b =3D READ_ONCE(p);
>>>>     } while (a !=3D b);
>>>>=20
>>>>     // really really hide b
>>>>     int **p =3D &b;
>>>>     OPTIMIZER_HIDE_VAR(p);
>>>>=20
>>>>     asm volatile ("" : : : "memory");
>>>>     return *b;
>>>> }
>>>>=20
>>>> This also does not generate any additional instructions, unlike =
just using OPTIMIZER_HIDE_VAR(b).
>>>>=20
>>>> What is the advantage of defining OPTIMIZE_HIDE_VAR the way it =
currently works instead of like above?
>>> Did you try it on godbolt.org ? Does it have the intended effect ?
>>=20
>> I certainly did try and certainly read it as having the intended =
effect, otherwise I wouldn't have written that it seems confirmed.
>>=20
>> However, just because my eyes read it doesn't mean that's what =
happened, and even if it happened doesn't mean that it is guaranteed to =
happen.
>>=20
>>> By the looks of it, you're just creating another version of @b =
called
>>> "p", which is then never used and would be discarded by further
>>> optimization. >
>>> I'm unsure what you are trying to achieve here.
>>=20
>> Simply put I'm trying to let the compiler think that I leaked the =
address of b. After that, the memory barrier should let it think that =
the b after the memory barrier might not be the same as the one before =
it (which was equal to a), forcing it to read from b.
>>=20
>> However, I suppose on second thought that that might not be enough, =
because the compiler could still simply do b =3D a right after exiting =
the while loop.
>>=20
>> And that is true no matter what we put behind the while loop or =
before the condition, as long as the condition compares a and b, right =
after it the compiler can do b =3D a. Just took me a while to see :))
>>=20
>> I'm not sure why gcc does the b=3Da with the normal =
OPTIMIZER_HIDE_VAR but (as far as I read the code) doesn't do it with =
the above. Maybe just a weird corner case...
>=20
> Let the p to be a static variable out of the function will make a =
difference.
>=20
> Or the following:
>=20
> int **p =3D &b;
> barrier_data(p);

Or the following:

	int **t =3D &b;
	WRITE_ONCE(t, &b);
	barrier();
 	return *b;

also works.

>=20
> also works.
>=20
> BTW, barrier_data(&b) generates more instructions than godbolt when =
build the kernel.
>=20
>>=20
>> Have fun,
>> jonas


