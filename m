Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306613E95BD
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788023; cv=pass; b=D51pihoOI0qbaFVYXaRPRs1Q+OrwUfZU2VHbkoaPUI9GhNAekEFiozJ068uIymvilE9jX+hZS9YR2nEJb3fQ2+IqTLUc+CHPufanFtibwBQWfn5Tg0hHOYxMtnEbvXcKQmGuhgYe06LUwelGYuiIMOW3cO5lVg6mykLeto2d8Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788023; c=relaxed/simple;
	bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJ7FYHpHHcnv5gRcMkI56YLt4fiZEzmcTQaSW4/cs7G/Jh6A/nJGlxZrHXjt03nCcBCZQHFJkskv4Hc3dNOZ0ojm+RS1YSQOCI+ZkEeUC8oGQq7FUOcaBC0jz7cU2WwygROsaWyO3yD4vUPsErG/oWGTioXraeNl1yaS1tKy4kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjzQHTWa; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjzQHTWa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-491609cdd8fso5203165e9.2
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788020; cv=none;
        d=google.com; s=arc-20240605;
        b=KqeFmRTHE+BzD2dE+zveOC2IndihNIzTrxx7mHieJzdWg5b2SoqEBe3iaCh4NLUMe0
         nqpbUeU7jT/+1wF5gONvgoI3poCCteL0pJBKVcrgsW7dkVc+bquzq6Ge1147jaWhv/3K
         nUdn/uWopPgTsboosvM3bflhfOkxo31o1/yLq7py7dzW9+pv9aJ96JzpUFxaCSznJZ1M
         m9pY0Zpoh61RUUa/QvynJ8yeJR85evf6ZbLiB2Bw9KPRxFFVqjwO/D3so2yyLzvKzsFc
         7oXC/Tk6uyKy4R/vsHqoqaa0ME92Nqs/eDxUwTMZJ37tsOi/xVcvObSq3n8CFOrEAys3
         E39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        fh=N1/pMCuNMexQn646z84fYsGhYQe2HDIjEhEaNHkiwJ4=;
        b=KXqp7VBtgvLd4fLrHFrTC1rCrowIqr1fmTw2Qp5MdHO8lJthgcJcsaFA7diJpwMYen
         EHj7wDNAvd7SR78J1mUWQNfs8utDuR1dGMP++KAkK2O6z1BrN8TEv9yXp8sTkLCNciby
         V5kjRdcoP01qefhprbtCtPJ2Bxj0gSbt9hzEifaxkKEGMXKA4+suIXngE/L47whIWUfX
         Lxk/eaMdB/atJ8mu6VHW7NcecZPrweH3J+wukkZEl4pW0W0/8j3MgB3cVYEwn46Z6y6y
         C8fTGJ7fCLE7/0Ern/Q+9IngDQrxwRhfV37lpi1Iu1K689LHHTx5dRvY//ELbUtJ3lvm
         OAtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781788020; x=1782392820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        b=BjzQHTWaGrlElZhTphqsaonDcnsCRrcbgD/mIhHASznoB7+YzFpV/ak6WLmTdbr1H9
         jWt8eWYEerrspbdLy7Fr5QqvJZO2m/6WLGRmc6fsRAXf5vZavpUSFUHlSwGIGkahtKA0
         ryVYRtspqcOar8q0qjAUWlo5XSoEpdtcRKm+JhGyohKi3sogAKrnL2CtXS29pot/dy+b
         R0xWab/uz8Yd6AyPE5kbtsmwfs9NZUvQw5GvaPxcweUgav9iBKuoLQ87usWPd30QN5Pm
         I1GQSHxItMA42nhmBIuH+QIGyl2M8MC+9M8+IYm+BBxp6cznHaNO6odR9P2Z4aa0AE2K
         1jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788020; x=1782392820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        b=nvdgbkZrJ0gNRwBEKE9v0ps4YNU/1Kan9FUxJuiWrgN6p3L7GXc6HfrhwYqY32g7nN
         Z9guHGjFLkCxxAR6pbRMCwft1f4aiwpa1P0JQoIPAVB+vjgB6S4/Kyxg/4C5qdsoyOk4
         ueIUvpmvIfgkn7035h3kvkaJRV85Bo0j+zNWc7/YfiE9kda0e+WilxDpGd9lIgvkJY/J
         WbFkWfVqqKhw0Gvc6ljUCcZfvdgtosL9sBYPeSiFTwlMGEpv2lF18XZHBbOY4Ug6Tm6M
         /ntID1of0QRdDx2rC+NSlW2QENL5BKgidI3/4wfC1jiMxPKAla/msGRC7loIYwjs8vjm
         hhgA==
X-Forwarded-Encrypted: i=1; AFNElJ8KHgTWRLlmgpEZcCiK2UnMEEEnG5h+F8pvv83SDZNvcP61EdmS2hPS8WQyKYmAXja1PhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1paudDa6bGFPxshF2TvDFSARryiVHyf5VrwWwPG7HiiPIzRv
	GLXLeiMyN78OfWOkuFkJC8UonINvl1jsY8UcqHKWzmv2q1xpDH/wq2WNoaKNGddhHLLFebaxvmG
	mSp23hJUD5XhHxt7mlIPjsf1QQlyLolflBBP0ibGW
X-Gm-Gg: AfdE7clmFf6VvkV1G4KK0QGyEmesXhZ5unxfFdihX6895VJ25DuX0FSxFIbWy1bBmn1
	6f7Ut9ujN3tdnKz9dpHsAzdm8KoIGYqaP5zpoUDbkFAmLDZC5/TWCFQAS27TZgx32+e33ka3hhr
	tGBxbeuvJsEof2RCHdO0k3xc+OvP5r6Jc9eY9Sic6IUkTKGbOgJggiPdWFfsBbSIIN4DyuQqiFD
	MZUsJ9icvgtuI+HApPMGgxliFcWPYY5Bs4p2aaY5O4yyDBR+vi0EhPtnZ6m/hKTBDMBhYWtQN0q
	zoAc2QSs1Rh6g2J1rUlOebIo0KfDwNTqZJRBRdwbp/Feib/fsbWRWfgcUkWrWOsMQNtkIA==
X-Received: by 2002:a05:600c:4c09:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-492333ca42bmr96135075e9.23.1781788019918; Thu, 18 Jun 2026
 06:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-2-phasta@kernel.org>
 <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
 <ajPa4_U_gcxr8SKO@google.com> <81c530248789f79da265da772a6f248a0d524eed.camel@mailbox.org>
In-Reply-To: <81c530248789f79da265da772a6f248a0d524eed.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Jun 2026 15:06:47 +0200
X-Gm-Features: AVVi8CeK2MScB-t7m9DsXQaFm4-l0PDopN55uoi7q9D_cmJhkYOY8sxrgmKJWI0
Message-ID: <CAH5fLghB3Q-Mc4YzVMX3nGVSTzfh=jqFzsLMcXqXLTiVcgxhKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> On Thu, 2026-06-18 at 11:47 +0000, Alice Ryhl wrote:
> > On Thu, Jun 18, 2026 at 01:40:05PM +0200, Philipp Stanner wrote:
> > > Moreover, this would be an opportunity to change the naming conventio=
n
> > > to rcu::synchronize()
> > >
> > > But since Boqun & Alice are pushing for rcu::RcuKBox for the reason
> > > that it seems desirable to explicitly highlight that that's a special
> > > Box, I guess we should be consistent with that and also have "rcu" in
> > > the name here.
> >
> > I prefer the naming of synchronize_rcu() here.
>
> We might be tempted to at least call it rcu_synchronize(), though. It's
> also RcuKBox, not KBoxRcu.
>
> But I don't have hard emotions on that topic.

I don't think we should change the C name without quite good reasons.

Alice
