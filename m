Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC62820C6
	for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751786; cv=none; b=Yn9A34rTGtGZyQ/BPJUZSneH+dzIgs8yqjRc2Hp68kF4NBcyDNC0hwQX8O10gFqUWSlT3Z2CYbbLIQdOXcF/AlL2ao2yQFVh2Apj5IX/bZNyj/zUIVBCM07l3Karx5qRLeZrxfbrfW2lwMmLERhEj1MDwPhsmL2NoXc5R5p3bdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751786; c=relaxed/simple;
	bh=QusW0ml7vSuC4kKjHruonlX1yQ9lnvyX93t9phM72F4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XnEWdLTA3jkbIE2cHu0gZ6KJomBxGOauvcMq2eFPzVirMZFg0pu3Z2EPOG6HsbijBd1IrvRMwVChYBIE73R3GnddBzzr1NS2RBwnM+j3lIZQ5b61RuNzeltZBPDia1/1oVSFgss8f8frWZXydN1LGrHeYl9N4azqNgE4JZoPaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ciV7mwcr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ciV7mwcr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f0f875bc5so37467345ad.3
        for <rcu@vger.kernel.org>; Sun, 14 Dec 2025 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1765751784; x=1766356584; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rwcA3OD60j9yivV/7Y+Z7nX3FEmjGmM7wx6uzFbGqU=;
        b=ciV7mwcrPd02lelGPWxwj7A3ftnAPB9tC4OePpoUWuqEv+LTER0ahS35U2IRydq8aX
         gZZ/Tj6SwumOuKPKIoKaSIfvc7ifukoGJTScMKuKDCgH8oOGgV2zWX7VxsOPab1uZ3xf
         rWmpEgMqD/p9+9zZg/DMzbtoPzjEVu0NBHFIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765751784; x=1766356584;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rwcA3OD60j9yivV/7Y+Z7nX3FEmjGmM7wx6uzFbGqU=;
        b=B6sFKWQpdOzFHWjM5fsYk16Tpab0ebB55zu9J+lPPTv++EfcF1s0AMzLXWXLXMC5SZ
         CV9gvjN31R2pQuFRAbWTND2HCo3oUnOxvVREzFjkWANSOA4XRoHEG8Nj458WCciMa8g1
         WzARJYjKsBmoQCi2UGdYHTSvLlzZgWf8lZ6m7VjoXXv8dy3tj6ugtoNfTo8LwDj1ALd9
         wlj/+dDEoJlH4dNWbnMlJT6wiU+Y/q+Zm6LClOlD+G2yH9FHwMojtIRTJqubzdiOBsyC
         66S6+dI1yoqSiPAbdArUWpJlPt8jf87sBQhcdoOJt/w+nEjX6lqQjSiD63Q2GQTLvlnL
         y4tw==
X-Forwarded-Encrypted: i=1; AJvYcCX0ni9s+6zGRrsGau+NJwAwoHtTepFjB2h/cMDYWijxjEynwYSZRSEV+qHw8yDzQwIhpm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5xkgD4rf1lBOdDW8t6ihUjYxwMT1WuYdw8orjo75zcutAl6P
	EaTMVCmkUO8u+Vjcy0yOpHhgKPfyvWXyAtp5vzJ6e2uz9OshYNlcop764qQhpf5+ZE0=
X-Gm-Gg: AY/fxX5RJaf/w6pr7ml7TcsIYWwg8dmBx2E54nFb7YFq4vUkt7pg4Y2+GJCQ2JjnNxt
	TNGmel8yEuDLNTajn75q11VzN2UwBdLsUp8RBQN7X3ezI95axTDZcRs0MFg2gQevVju9SwbgCky
	tIWy8yhg/HYvbWZLnEP+CTKGa6X/oJ5Wzmomtq+WzOIgP693OON66ajQCn3WSJ5iEkefWhlMdxh
	IYq71MdZssBtrmiBK1pNOs/P/yCxgAkAjOeJX9OGAXeEBYeZYGxogj41dDD6eoGkqzWUIBWZ6CQ
	GwjB8QDYrP+emkxXARGAcuk2kquftihiVt/r240D2I8N7G1eZHdTTaIeufImLOPjb6DCbLAWUXe
	mAmZLklsP/MqHmbvHigaKwFrBuboAZgR5aVmSX05TFOt4hQmmwszLjIIQO1h342kaNaY6X7Nwj5
	oixyoIen7/RtBaVtV1AoJqowPXxF4piVpB8V+zUxtRidOPFS8=
X-Google-Smtp-Source: AGHT+IEKcYyY/zm6iugCWvxjF3MOFgymdtvH3iPKUmAj2D96UypUjJg+u177GvSa5/XZiS+16k+MEA==
X-Received: by 2002:a17:902:db12:b0:293:e12:1bec with SMTP id d9443c01a7336-29f23e6236amr80729375ad.20.1765751783795;
        Sun, 14 Dec 2025 14:36:23 -0800 (PST)
Received: from smtpclient.apple ([39.110.237.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0867ebe9dsm57909225ad.40.2025.12.14.14.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:36:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Handling large numbers of hazard pointers
Date: Mon, 15 Dec 2025 07:36:11 +0900
Message-Id: <31331836-E9F9-46DF-A8EA-010379A56677@joelfernandes.org>
References: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
 rcu@vger.kernel.org, boqun.feng@gmail.com, mark.rutland@arm.com,
 roman.gushchin@linux.dev
In-Reply-To: <1ee9bfee-d754-48db-b72d-763193cb92ca@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (23B85)



> On Dec 14, 2025, at 10:43=E2=80=AFPM, Mathieu Desnoyers <mathieu.desnoyers=
@efficios.com> wrote:
>=20
> =EF=BB=BFOn 2025-12-14 02:14, Joel Fernandes wrote:
> [...]
>>> We have had similar issues with kfree_rcu() and running out of prealloca=
ted memory there meant we just triggered a slow path (synchronize) but for h=
azard ptr I am not sure what such a slow path would be since, since this pro=
blem appears to be on the reader side.
>>>=20
>>> Perhaps we can also pre allocate overflow nodes in the api itself, and t=
ap into that in case of overflow? The user need not provide their own storag=
e then for overflow purposes, I think. And perhaps this pre allocated pool o=
f overflow nodes can also be common to all hazptr users. Ideally it would be=
 good to not all the api user deal with overflow at all and it transparently=
 works behind the scenes.
>=20
> With the preallocation approach, how can we guarantee that we
> preallocate enough, and if we cannot provide that guarantee,
> how should readers behave when they reach that limit ?

Sure, see below.

>>>=20
>>> I think we need not worry too much about cases of preallocated overflow n=
odes itself running out because that is no different than reserved memory ne=
eded in atomic context which need a minimum off anyway right? And we have a b=
ounded number of CPU and bounded number of context, so the number of *active=
* nodes required at any given time should also be bounded?
>=20
> So the "simple" implementation presented by Boqun at LPC2025 was limited
> to preemption disabled context, but in general there is really no need
> to require hazptr users to disable preemption for the entire duration of
> their hazptr protected critical section. This means that tasks holding a
> hazptr can be preempted or blocked, which increases significantly the
> number of concurrently active hazptr we need to preallocate.
>=20
> So I'd rather remove the preempt disable constraint across the entire
> hazptr crtitical section if it's not too much trouble. And it appears
> that backup slots preallocation is the only fundamental reason that
> would motivate this constraint so far.

We can remove the preempt disable constraint and still not require stack all=
ocation by simply embedding overflow nodes and any other context, in task_st=
ruct right? This is similiar to how preemptible-rcu tracks readers.

>> ... By the way I wanted to emphasize my PoV, that requiring storage provi=
ded by the user seems to negate one of the big benefits of hazard pointers I=
 think. Unless there is a solid use case for it, we should probably not requ=
ire the user to provide separate storage IMHO (or make allocation internal t=
o the api as I mentioned).
> I think the solution I have in mind takes care of the negative aspects
> of preallocation requirement. Here is how it would be used (see
> [1] for the current prototype). The "backup slot" is within the
> struct hazptr_ctx, so from a user perspective, it's under the hood.
>=20
> The user just has to provide a context variable on its stack.
>=20
> (untested example below)
>=20
> void *ptr;
>=20
> void fct(void)
> {
>    struct hazptr_ctx ctx;
>    void *addr;
>=20
>    addr =3D hazptr_load_try_protect(&ctx, &ptr);
>    if (!addr)
>        return;
>    [critical section]
>    hazptr_release(&ctx, addr);

Correct me if I am wrong but I am not seeing why stack ctx is required if ct=
x and any space required can be placed in the task struct (and hidden from t=
he user). For interrupts, we can just use per cpu storage split by context l=
ike qspinlock does, I think (unless we are going with the wild card proposal=
s).

Thoughts?

Thanks.

