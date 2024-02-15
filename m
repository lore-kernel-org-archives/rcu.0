Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67661130E40
	for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005772; cv=none; b=dnsgJKKC7M6mExsf5e3OPovOHDJjsNsgH1+dsKTUW94M58b5n/KslkAXY3159z9VcwFshCnhOdDtFXBwp6ZBxOcTb7Xm9KVj09RS3hvDL8JM543/Q7VWIEpYFSRdb/cNH+qLQJKRldJLcz5lsZNSple4nl4NbySsJZRXv55Mitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005772; c=relaxed/simple;
	bh=T/NORQPbfde0pbfntS4gQnCcisA7+9s2HYdGTGF6J8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXnIjtJrJ3zQOFlFh9DeaCblkzBkyw85b0K/3sW/6xhbLDbsLr3DzuLVi3ppnShw2dlg8kxUHc5Lh1Xvt4HoyVNVzN77ckAIbiOnsniwJyrnf3aA9OaA3IgQ86qLY/++NoxMLA83wojrxDb6un4OWpGbxrnFYrXmQRikryn0bXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=HnjxlD6z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HnjxlD6z"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so11246031fa.1
        for <rcu@vger.kernel.org>; Thu, 15 Feb 2024 06:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708005769; x=1708610569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wzX7VbU5pQKW9L20pb1L2KrQ3nPSUU9D7ZhcjINoQo=;
        b=HnjxlD6z9/3plw75zMNWGEyNdDyCQdYanK6kCUA3TBsvJ482CJ4MIkWqXRe0hPwHZi
         tRXpnTBh6lhypMApPA1Gjl/D4qFZ29Ow2KeT7bVW6EHNtyfV5R9q9mQCGwCul0cfK3vj
         07L+R9p8Kpo/oX8hG+O/6USCXnTGEysTP3jjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005769; x=1708610569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wzX7VbU5pQKW9L20pb1L2KrQ3nPSUU9D7ZhcjINoQo=;
        b=mLDlDOi+Ingnf4BMydQTDocoBIUYTcADjc3u1XJ6pAMCrr5DSVKfI03OLw+urvxpvF
         Txloz1o5ZWMmF+A9dFxzdfYa4PTmFyfrH6Fu6OiAQs+ZpxPx2aphHQotI+PP+nZwbwDq
         H/oU/5S8jeb7riKS7eTvxGDGO/Ojm9YMbFr+NDNUmXJxLf2S7wVfKr7zVf3ngPiYrEh6
         WU5RaTr+4cvK4zu/QJO13YrMQMW6aYYPGjW0x8hdEsUrj+avyJqVC8VjUTu1UPqpsWSD
         Ns2lZ0KFyjb+njYxZ+wrescH14Hk9j6Tkjb1h60VTGLTnGFvfww3LBE5bHc5FfAmMhcb
         iHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHhuIiondKTi1ZDeLR6a13XFgYtkB6ADpXioS4gUWGcUIMLE5PaZ6M0Wd+foe938qCg9jubedDfLfxiDxe6l0TtZ39
X-Gm-Message-State: AOJu0YwMoLHOe9iK1EdBWo9PNFvEIuZJ0I28zRPk4tp7zgfnEuhqu0gj
	zIOXoDMHZoHb2V7RUk74yaQ+7As0XxreVOnTibBRXZZdbWRC2lxLTNVRNTB7TElTCWLgvwmWcOF
	AU+UoY62ssWq95boIKSMu4Fica/OFcxSQ6qpVxw==
X-Google-Smtp-Source: AGHT+IEH/d/YS0y6fFf74zBWi2xH7uBazxK7vnwiiHQ+kzoQTRZfXdKoJx5DlVs+Ia5b9y7cVZzKh2xV6HmsGXlBdJg=
X-Received: by 2002:a2e:870f:0:b0:2d1:188b:c3fb with SMTP id
 m15-20020a2e870f000000b002d1188bc3fbmr1420796lji.34.1708005769338; Thu, 15
 Feb 2024 06:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org> <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop> <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd> <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd> <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
 <Zc3CmvuD79umJXQv@gpd> <Zc4Ojw8LsYRGzo_y@pc636>
In-Reply-To: <Zc4Ojw8LsYRGzo_y@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 15 Feb 2024 09:02:36 -0500
Message-ID: <CAEXW_YQP4i_-fcypKuo+9=2NruYuKich5CHzLKdpBeENntd_xQ@mail.gmail.com>
Subject: Re: Observation on NOHZ_FULL
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Andrea Righi <andrea.righi@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org, 
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 8:16=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Thu, Feb 15, 2024 at 08:51:54AM +0100, Andrea Righi wrote:
> > On Tue, Feb 06, 2024 at 10:44:33AM -0800, Paul E. McKenney wrote:
> > ...
> > > >
> > > >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> > > >    return, respect to the other cases (is this expected?)
> > >
> > > This last is surprising at first glance, but I could be missing
> > > something.  Joel, Uladzislau, thoughts?
> >
> > On this specific point, I repeated the tests with the latest 6.8
> > kernel and now I don't notice this difference anymore.
> >
> > hrtimer_interrupt() time is always in the range [4K, 16K) ns, both with
> > lazy RCU off and lazy RCU on.
> >
> > I don't really know why I was getting different results, probably some
> > noise triggered by something running in user-space...?
> >
> > In any case I will update my old post with these new results and I
> > wouldn't consider this an issue for now.
> >
> Thank you for your confirmation, so our results are aligned in terms of
> i also do not see the difference and issues with hrtimer_interrupt()
> duration time.
>

Thanks Vlad and Andrea. That's a relief !!! ;-)

 - Joel
