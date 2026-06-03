Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF9386557
	for <rcu@vger.kernel.org>; Wed,  3 Jun 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497570; cv=pass; b=q1mLgv2MAUX+pyydoziSgSEp3ibpTwDOOjDZGbfGJo9LdKf3KvoxPiU8APka3oHtKNqBgmVp84bEUrv/LZ0vfFtkGX6Wt54HEi9tCM9BcUbmvUB6+ZgA1Wrc3NuugZv78/ZOUh7YREf/kC2zu6Etz0EvaQAX+cFDh7N06gUsIKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497570; c=relaxed/simple;
	bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmkmuR5dM4ymt8+N2NgLWzIX8QexLISG1OI9hiZdqwlYhHMkTXIsKezL7KrchJHqm1fLQpLzl3bqIXPeK71fMR4Xoz5VntHqin+nHWK62hVdhXIF+pNm+cCIRHLIyd3GKtFqoL7zPdZI7C4B7Lt1Q6FuDLfUEgFHyFLlwqDTsqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBXv+/2r; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBXv+/2r"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so10268513a12.2
        for <rcu@vger.kernel.org>; Wed, 03 Jun 2026 07:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780497567; cv=none;
        d=google.com; s=arc-20240605;
        b=gnenJA/x8JHJdIwlLnGP2L77nna9potyaosWRhy6R+jnBH/65BsfEW24k1cXh+v4pf
         eWvvTFA9PGCvLizTpWzfCazZR2VOG6oJRYFg3WnL5s16YyJTkb0VQylIgGx3EfW4nDaS
         iU5Nuwnp0Dv0wIujPpx/Sb8l19uZQNXsHtmpNzP+jDObxDYg5+tn/1NJVGVL7TU8weLh
         vJuLlWkWBVJOslf87GfUebuCvj0W0qSiPdCgL3YDX6LajXvN1S5Bc515asUrlj7GVj3t
         SsBePoRUwvtMqVOX4PPJWaTFUNm33k3iS4Ci+0q0/tnFYX7eM5Kjdji+rT1g+3UkPR9f
         iJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        fh=Yuftqc3rf+Lddb6GC2x6/AsbkhhWurRuKIpLDW3ADOA=;
        b=SHy/wvvndCulwofv8pzZ9iVFOdWwpX1/4Ji1lyjSbxWcrkRaa4Y1T1v46SFLVhYHug
         cpugucyDj5sNK/oF+rZOC4Il8pCIhuJz7ia7TZB2lJEQyw2ZSv81Qmgb8cEBck4i9own
         dolyv6qTa2i7eseZu0seuPPFK9y9Rkuyr0qMoWqL9ad8m5+4Cwk54qqcjdPZDIOzs7nY
         MN0OsJgjobM9lcURii19SLwHugfHUdOKiWM/u6YxaT8jbjEsJhII9Yf7j8+J6IZ7Oxuf
         IbGERUBcFixGvWKUQUFGKuCDrYFtksUeKIensEsy/Mam3AGfQp7pJ8/gMvS1ouqbgumo
         hs9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780497567; x=1781102367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        b=mBXv+/2rrQJ/8E65tGladFfucL3ST48yuRmvBJifMeXU/Wenwq19Wee+/Cck8vgDsL
         1F9Spi439MxhlsO6OTw/VvqIRg7Vz+WDN+smIN8d4ZT2H4A7V46ZmBRvpSmNNvdfGZPA
         gN13FGFtn2eUZ5elpyXZMjiallTYQ8035c1tKHJwwGM1KHRENkIFKop3uQdRp2f1P4q8
         6Y9+jVmPMdpMGbdJuckX/f+HHbksBBBGU8CfEN5soyuinEo6qzUSYZXLGLohT9XKOPz1
         FwZo42XOmctNaM4n0nO+Zq0aDeVdVV71RM0ybl1rwZlt85HrNEXHHwjNMeiYYcUZmT9e
         6bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497567; x=1781102367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        b=T6sXwvOOJFGx+nsBaEiss7bktvAeFuNlvScOFnhdVfbTI3BBz4Fiw/olITiB0xeKIg
         mdQR6W1WQCJKMPIEqS3V0iWMOCYsWgQpTivVCLhC9uJMGglGvExVQ/7iK07LjtPyRjv3
         jkkMy/D+4kd/W/Ulq/pQdjSwLL5ckRafYpiSqoOdhzPdjmKiKjC4IN85aKHr2EJU82SH
         MAz2bucrV2qXdkwUuRhNnOJKxjavfC+4MeYNI0otrb9I36jsmptgfK9c188oix7SWWAD
         mC4P40ZHz1rv700mHce5yZFVGedKWLmekpIUK90nYwjiDgMMN864pCVQ/Z38qfoKi3Zq
         MoOg==
X-Gm-Message-State: AOJu0Yzd2ZbNHVnRtnboWD9K9kv3xDdKDa+rjOmX6gKLjwP2QVjb3Xie
	kh8abBgINCREeUaGgywRHvaCZXAnl5FS5TQGhIykDaBhTil9PUiMiKdjo22KGFuWu0HD5sC34WU
	F1eUv2hfYyxXsC4dJMCF6tWkjIGn7C3Y=
X-Gm-Gg: Acq92OGSjeScOQT6nQ//s4qZcAoZNhyOywdcs4d/WPcqe8qdFFUGRL9/8j56LIZDdG1
	XTURvfc3sDA06c2qMdZDSWneDfKeavUeBOCRFKPUdCigoEPzZUqY1REwp49p5NB0IoZY1ZXvyeN
	b1wiU8CsKenydYpKgIKQFgxHX/t/FW8wA1k8poOrDFjbC52yL5jpm6ffnHibA0J2Nm0Ye/MjurW
	KadhSb7LCaWsFXLJTC7M1pVtDTs4Czxyp87b9LFP3cNxaplWqzfMfi9gOT5r0IzzZnkgFBSRcZZ
	YT6QiRdONKoGCD2t4q+RtJ2C0tyuimPVhZRn0hZ7Dtjy
X-Received: by 2002:a05:6402:28ce:b0:68d:92cf:52f4 with SMTP id
 4fb4d7f45d1cf-68e6f7935a1mr1958834a12.5.1780497567206; Wed, 03 Jun 2026
 07:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417231203.785172-1-puranjay@kernel.org> <ahgxkIbBLkTJyUVt@localhost.localdomain>
In-Reply-To: <ahgxkIbBLkTJyUVt@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 3 Jun 2026 15:39:13 +0100
X-Gm-Features: AVHnY4I2ofbFOw3-botyHDbqPzrG7jRG5CNyqRLx4va3_j8bkKgXxI12wfISC8Y
Message-ID: <CANk7y0htB0VZUhXQavAjZJ4+BSZyup8uVnLaFTHbg_ixEge1-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] RCU: Enable callbacks to benefit from expedited
 grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

Thanks a lot for the detailed feedback on all patches, I will send the
next version soon with requested changes.


On Thu, May 28, 2026 at 1:14=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Hi,
>
> Le Fri, Apr 17, 2026 at 04:11:48PM -0700, Puranjay Mohan a =C3=A9crit :
> > RCU callbacks only track normal grace period sequence numbers. This
> > means callbacks must wait for normal GPs even when expedited GPs have
> > already elapsed.
> >
> > This series tracks both normal and expedited GP sequences in the
> > callback infrastructure using struct rcu_gp_oldstate, so callbacks
> > advance when either GP type completes.
>
> What is the motivation behind this? When most callbacks don't have much l=
atency
> requirements between queue and invocation?

Right now there's an asymmetry: synchronize_rcu_expedited() callers
get fast object freeing, but call_rcu() callers never benefit from
those same grace periods even though they prove the exact same thing.
This series closes that gap, the callback infrastructure treats a
grace period as a grace period regardless of how it was driven. The
practical effect is faster memory reclaim: objects that could already
be safely freed stop sitting around waiting for the next normal GP.
I'll make this motivation clearer in the next version.

Thanks,
Puranjay
