Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0F22839A
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718929; cv=none; b=EZfCd3tFubplviQ6s7kb6YEv5ME26LWKr2u7hnch/Jca6qBX4TUYuEwJbzDmJz0q7jUfNpzQQVE4s9XP30Pf9oZrBVfBZEF13YNs21cmXh83iOA9qZPyj8xVFIPc4IEwfR+b2dzDd9mrvpyHAMYnZ9Ri8THikb4u8qEKsOGHt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718929; c=relaxed/simple;
	bh=CH7XHWayXlMm6X+ldAU5cm1aFpjYOaEmlR1VogaAYjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT/R9GhFi/D2QdJ/LVS15d1KtQ3pNLP5xDihX9vfNlQV3FWRoPousIyxmWLoWpXp1dH7PFIc27j+mDKrltdXZZay73Fvc/92+UjWdGhG3jGlQGqKj9Qb/lQfShdz4LH0FonSLVzFuxqFGFClnoz10hEah9Zrgts0yHS5aSNbW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=aPsMAkiD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aPsMAkiD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so61954405e9.1
        for <rcu@vger.kernel.org>; Tue, 04 Feb 2025 17:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738718926; x=1739323726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skstW0gZrBCHPVrwtSMOsDrBsYFzTxe36lXFm/o/T+I=;
        b=aPsMAkiD1fo7id/uikouW8Zk2PWd6y3M0RWksKF7qhvMWv62765u0GL46ZDytRe49N
         1o1wLQb9venavCRoi/Jdk1VYiTlO0OAYc3UlMHq+W8jOScBqLXa/RYjyP68rzyj7jUmd
         L1MqrOg9rgtk8wVmIsKoOOHiz/fwjUhaQkxg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718926; x=1739323726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skstW0gZrBCHPVrwtSMOsDrBsYFzTxe36lXFm/o/T+I=;
        b=YJFgfxeKGHfAkmaPvCOvZSv+/r1JiBffTb/zXHISzsnSct7HhAHidW/1peprIQNt/A
         PtXy6I2ZRbGqRhPdOrvmcwTg4miB9XzESRlFxViYlV4oMfX+5LWe/HdDBLCvEcGfjryM
         MPUGTB3D044d5XPkjj9YN7aitoO5XLkUsLpVCO5g1tePuHmVvcaYk37V+t01BECDRhAw
         YCX6nB3XcOeDw6mH4NZz16PrfB6IgNaA1hI3/JnPKIo4qXntzaZOBrHjeO/WNlNOcwTq
         DOOTzPfxNvoYczTx2fkbuhkg2SaPQh6PESu8BFhsatNemygF0hOgcl+wBlp7PwGoiIEM
         zHVA==
X-Forwarded-Encrypted: i=1; AJvYcCWosRQ96PQSrkvzmPm704YdLCh+kpYh7uWfTRhyOmH0xoxlmKPizUYeC6BdwKt0nKcxi9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSowwpHZoOahNsOp2QN+642X3/W1asZgj1vU4Qjb174/XgRcZ
	yvfQrGk0X6ozI+qtIS02B1sSyVCqc9Cy5owY7Bj6aRE8mmnd+EXAbQtMBNAGgfyEuFw+R02xaMT
	JJ5bIUNdaVA6cLlxz/+sj4DjSQpmk/n9VEXWBpA==
X-Gm-Gg: ASbGnctI44gXPvtKJBH1tndJ9VWtEUqO0bKsNiPrBHwSCs8PwjPNm0PdAXL7CB0QMLv
	sEl9P4rCzHmk5BqxcwhNqx9ziMGZKr6N+tKhoyuVxGSuqvYi25Y7pJm+SysrwkLy2PUSky7orOA
	==
X-Google-Smtp-Source: AGHT+IGMXUeWyZIUGTb7fVTbXwtmB43laY/dhAFV0Yf4yccthMqcqrSF6+Uos1iQ0bgcXWln9IWa4wmI7AK8EG21pdg=
X-Received: by 2002:a05:6000:1543:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-38db4929c07mr609460f8f.35.1738718925148; Tue, 04 Feb 2025
 17:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org> <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
 <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
 <ec293223-2a33-4d2f-b3ca-c011c3d987f3@paulmck-laptop> <CAEXW_YQXgZANSjo835VfHMqY=z8gaSWQ2bgaWtVd4-3KX0hX8w@mail.gmail.com>
 <999751de-b891-424d-a7b5-80bfa98793ff@paulmck-laptop>
In-Reply-To: <999751de-b891-424d-a7b5-80bfa98793ff@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 4 Feb 2025 20:28:29 -0500
X-Gm-Features: AWEUYZnoxuLEMClrezb3XSmPtsauGGEzfqmICCe3WJEDRQTvqHqDSouxEV2lAWg
Message-ID: <CAEXW_YT6bD=sAD77yg+BXC+Q0NW0RHCg6fEYZ_jsBeXkAd_1tg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, Feb 04, 2025 at 10:44:45AM -0500, Joel Fernandes wrote:
> > On Thu, Jan 30, 2025 at 12:56=E2=80=AFAM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > > By "where we were initially", one might reasonably guess that you mea=
nt
> > > that the initial value and the target are one and the same.  But I su=
spect
> > > that you are thinking of a third value, the value of the underlying
> > > grace-period sequence number at the time of the call to rcu_seq_snap(=
).
> > > But you might be thinking of something else entirely.
> > >
> > > > Now we move rcu_seq_done_exact. It has the exact same behavior exce=
pt
> > > > that instead of ULONG_MAX/2, the above situations are shrunk to abo=
ut
> > > > 10 counts from the target. So if target is 28, then the initial
> > > > sequence should have been at least 18 to avoid false-positive, but
> > > > again it is possible and I certain see in the code that it cannot b=
e
> > > > used this way.. (at least so far).. So all we are left with is the
> > > > false-negative band of ~2.5 GPs..
> > >
> > > Here, I have the same questions.  As you no doubt guessed.
> > >
> > > > About "what are the consequences of failing to get this right".  I
> > > > believe false-positive is unacceptable unless it is maybe debug cod=
e -
> > > > that can break functionality in code, too short GPs and all that.
> > > > However false-negative is OK as long as the usecase can retry later
> > > > and can afford to wait. Did I get that much correct?
> > >
> > > Maybe?
> > >
> > > Please look at this on a per-use-case basis.
> >
> > Sure. FWIW, I started a world-editable document here. I am planning to
> > work on this a bit more before our meeting this week. If others
> > knowledgeable like Frederic and others could make edits/comments,
> > that'd be welcomed. But I basically summarized this whole thread here:
> > https://docs.google.com/document/d/1sFNuGH4U6DFCE8sunbdWMjFhJhb1aG4goOJ=
AnS6c6gQ/edit?usp=3Dsharing
> >
> > My thought is (AFAICS), this patch is still valid and
> > rcu_seq_done_exact is a potentially better replacement to
> > rcu_seq_done. But famous last words...
>
> Let's start with the use case where the sequence number is being used
> by rcu_barrier().  What happens?

The rcu_state.barrier_sequence is used to keep track of barrier in
progress, as there can be concurrent rcu_barrier() calls happening so
we optimize by batching multiples of these calls.

It also handles the case where the entrain IPI came through but no
rcu_barrier() is currently in-flight (which would be weird but maybe
it happens somehow).

It is also used to make sure we don't need to entrain on a CPU again
if we already did an entraining for a certain rcu_barrier() invocation
already. This is tracked by rdp->barrier_seq_snap which copies the
value of rcu_state.barrier_sequence after the entraining. Al though I
am currently unable to envision why the IPI handler would be called
unnecessarily (hardware bug?) since we hold the rcu_barrier mutex
throughout the rcu_barrier() function, including while waiting on
CPUs.

Going back to my first point, for the rcu_seq_done() in rcu_barrier(),
we are checking if someone else did our work:
    mutex_lock(&rcu_state.barrier_mutex);
    /* Did someone else do our work for us? */
    if (rcu_seq_done(&rcu_state.barrier_sequence, s))

Here I think rcu_seq_done_exact() is better, because if too many
rcu_barrier() calls concurrently made at the same time, the mutex may
be contended. If enough time passes and we have a wrap around, we
might end up in false-negative land which is much larger with
rcu_seq_done() than ..done_exact(). However, that does seem to be a
bug to begin with if the mutex contended for that long. OTOH, doing an
rcu_barrier() again when we didn't need to doesn't seem like the end
of the world especially if we contended on the mutex for that long.
But at least it shows that rcu_seq_done_exact() cannot seem to hurt
here.

Hmmm,

 - Joel
