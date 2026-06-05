Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F131ED93
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675380; cv=none; b=CyOoPMGcwYMHGzU4yInhKnM2cLHL/vVovHG3CPhdS+pQlOz7k2x0du7qa9OkdYWqjusoN0baPIJDNokaGbhvoF1d53+qu6eDF17fLQcg3tFBw66Ol5Jx9yKGj+/hHD0ajLsRxlATN1gnAOWK0c3qNPPCD3cZ8j3+4e/BYON1IEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675380; c=relaxed/simple;
	bh=GMM8rItwjOBKBZTiVFQDKLbinjfJL7SeunmDuhS3L9o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iRCWlSK2lueRQD71SjecV3wdZj8yMl8V6q2cGMJXLDQHIpOdF8n6Sl5X7kl9kBJ91E1HQMzEYSed8v1UH0o72C3uQ/WoGdWSbIm8Ef/jMnoDOlQRNyuvEg7eEt/KZVcvTJzFX6bKUsEvYJc4vOTF4ZBMOhnwHWUhZY/N56k7oOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phnS7lpi; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phnS7lpi"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96387977596so751495241.1
        for <rcu@vger.kernel.org>; Fri, 05 Jun 2026 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780675378; x=1781280178; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMM8rItwjOBKBZTiVFQDKLbinjfJL7SeunmDuhS3L9o=;
        b=phnS7lpiu0AgZ4noQy/KYuqfmUif+4T8mkMql9h22PnhP7PSenOVFLBpfAb0c6zmy5
         kzBeHOWO7dT3G2kkKqBFdaENtYgiYQe6LlSM/GKVkYYjjGsIsBgX9ZXYwHFq1lIrukBH
         WGtGQkdzGaTDR+8jAUg1u8zKH2OnpP7O6VwtF54MjibpPByFvjwBNjQk7PYP1z0Hyh1b
         bjzJ/HBveB0DxeGSFmi6aR21VcPBldru/kyKFfgQyGXepHsAV0EjrT45SJOVrhgXL+m0
         hoYvlYGVRBTLb4iETPbcuE1M7RQYgjdrwiUUyrVDlHbHcpwqQxJakhtQt79+DzZFG41j
         i/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675378; x=1781280178;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMM8rItwjOBKBZTiVFQDKLbinjfJL7SeunmDuhS3L9o=;
        b=iIrxqM3AY20ChE1swfhNhca5J+HOrDb2cGmAXm9bEMKV0uK34kWMp1BmULJyG3TC09
         IUixHpCmNsSGoxg+XjSIARr1kMnWA4cjlFNOQqi9uC6cm2yug7+Ro+hAzAg7siSxBaaN
         +tJ6AR9WjNKIn5A4mXGtbL7DdjWp9hl/jBWRb+JJr+6KBwXKeMKtJZM9rHYyMcEe7HPI
         sWUj5yo9/fzxbrr78U9WqJjzAEegKXZYxsjvqAqT5KmOlumyzlqxmX2kQCiFxRm2I2qD
         uUh9jrdrIdIQt9zbTrVUkCzvkFREoRu2OX9m4QyKtkBnkJGWP753DNnznG1+Rh2vVAku
         dLzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iDODTTuB/A9MVCHXf5VK2ZnfrOVSQ9nrlisCFr4Sm1GDkoK/jgnAOAvc+WZb370VmCe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfErJUmfIugDC3gDVBumX60nsFLxYpSvbECWEounhMVMhL0qC
	6N17R8OWUB8jpiO2H+J6vNzS8nahIbv5tm+YSZtzdg3tXf7OSa3pxJZW
X-Gm-Gg: Acq92OFsXAm3h1R2ymfba9TAgzZZMnVvPX1spC/bUHiFZwuyyW1D+8YOdjHjWyk2Osl
	zmLA6+7tKufEq+ceW/m/H+pAu9OFQL6iWVfvKxPnXMTDkoANm5zl5JvULhyjcpymJxruwMc+eF1
	XWCWiyAc1ZDiDInHPlHws8ykm6ZvoiV5k2Swgwc8WbFyGOR8rTZiCfj64VPJ3zopqimVYB0Y2Mu
	RnACwJygviu6bwPdZdWp6QCHTKbV2JJymCmARbMpJjOsP/qF0Kc3aIRfZl0M8E+E4sAB4g1vvN2
	d26uG+kMdWw07BUAZDRGzylJLUBC+l50YOcBBXB1oy6j80GH4Gun5R4E5IFDuEMS4o2Fz4ydnqs
	x5E3q4epx+6ImnhdCg0AauD/6sfwKyW9AvzjjKNc73v3Qo7wavC+1jXOTryTPcMthI7Bb0PJyZP
	usBUgkKze0h3WnZFNex81L0Wu43ZJn8XIJ1a0yQ8aHJGoN6oMOcBk/6uw/CP276gRrGKxFBPmg
X-Received: by 2002:a05:6122:3d45:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5ac4f952082mr2315135e0c.7.1780675378285;
        Fri, 05 Jun 2026 09:02:58 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f1:c241:abe4:8c1d:3d1b:d7cb:e7e9])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413f9afe7sm6908115241.6.2026.06.05.09.02.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:02:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
From: Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <FEFE0522-FD7A-40DE-8B2A-09FE2F33F327@gmail.com>
Date: Fri, 5 Jun 2026 13:02:36 -0300
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>,
 manos@pitsidianak.is,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 rcu@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48CE71C8-7A67-4D09-84C2-A0B83C32B169@gmail.com>
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <4F8E8E04-5AB5-4E6B-9194-5FC467E2313F@collabora.com>
 <20260603191405.4c75badb@fedora-2.home>
 <09096455-BA79-4E61-AD88-44DA57C5BEA8@gmail.com>
 <20260604101552.4232733b@fedora-2.home>
 <8ff2de94a50ed077a4cfe520a081f2b8b438a375.camel@mailbox.org>
 <FEFE0522-FD7A-40DE-8B2A-09FE2F33F327@gmail.com>
To: phasta@kernel.org
X-Mailer: Apple Mail (2.3826.700.81)


>>=20
>>>=20
>>> So, by passing self by value to the ::callback(), you're basically
>>> telling users "hey, BTW, don't forget to defer the drop to some
>>> workqueue if you think it's not atomic-safe". And how can users know
>>> that the thing they're about to drop can be dropped in atomic =
context?
>>> They basically have to audit the ::drop() of all the resources they
>>> embed in their type implementing FenceCb. Not only that, but they =
also
>>> have to design the thing so the deferral of this ::drop() doesn't
>>> allocate, because, obviously, allocating in atomic context is
>>> tricky/fallible. AFAIK, none of this can be spot at compile-time (I
>>> remember Gary/Danilo mentioning that we could teach the klint about
>>> some of these rules). This would leave us with runtime checks like
>>> might_sleep(), but most of the C putters (xxx_put(object)) don't =
have
>>> might_sleep() in the path where the decref doesn't lead to a =
refcnt=3D0
>>> situation.
>>>=20
>>> TLDR; Call this PTSD if you want, but this is the sort of bugs I
>>> struggled with on the C side, and I can predict that the exact same
>>> will happen in rust drivers if we expose the FenceCb as it is =
designed
>>> here and we don't have a way to check the soundness of the FenceCb
>>> implementations at compile time.
>>=20
>> My guess would be that the existence of unsafe-traits is the =
admission
>> of Rust that this just cannot be guaranteed by design.
>>=20
>> If a driver cannot know whether this or that is safe to drop, then it
>> would have to defer it's dropping. Or would there be cases where this
>> also doesn't work?
>=20
>=20
> Although I totally understand where Boris is coming from here, and I =
agree with
> him, the reality is that the current &mut self design doesn=E2=80=99t =
solve this. An
> unsafe trait could work as a pinky-promise by drivers, which is =
half-way there.
>=20
> What we ideally would like to have is a bound though, something like:
>=20
> T: !Drop
>=20
> If I recall correctly there were people working to get support for =
that on
> Rust? I think there are two things here: !Trait, which is not =
supported except
> for !Sized IIRC, and having an auto trait that represents types that =
implement
> Drop, similar to Send and Sync.
>=20


In fact, ping the pin-init people here, i.e.: Benno, Gary, etc.=20

What is the magic behind =E2=80=9CMustNotImplDrop=E2=80=9D? Perhaps we =
could apply that here?

=E2=80=94 Daniel=
