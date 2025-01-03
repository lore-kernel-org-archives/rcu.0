Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBF11CA0
	for <rcu@vger.kernel.org>; Fri,  3 Jan 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925705; cv=none; b=StqelTZLvZAv4CsfE1HnP7xzf3Gjt90FMHzHXLOZhVE9iGBP8CvO2p9gcq8DHv6hbQqJg0rBX8Tz4ZrDGktspe94AKpomVhBR7bhfnZckSY3wD8m2Ujs6/1zc/khWwmGqE5f1dM1TRIYQSZtxwndB6utrWTlJd/cjDajfVl435k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925705; c=relaxed/simple;
	bh=PBDcmfnZysMfS3NgkQtiLkymPUys1gfQDdtZTwStAIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaJ0vi77meo1FH4W8Szbs+fhNjV9X2clrdHtQemhiUgiXLPBjGvmUvHNgROt3Ekn7E9V9t7LUauxDLdhOTjpghTHmFNrxstXC6ldyqTJppD1SNa4y3jOPymwsqGcw+1DO1P62IVlmIBW0ksgPxms73zj041VgixU7ipyP75PIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Cj/5JzYi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Cj/5JzYi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso85398075e9.3
        for <rcu@vger.kernel.org>; Fri, 03 Jan 2025 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1735925702; x=1736530502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPwpRuSLMbQOP94KV/MIzkS4jrRWUT1ASSsthIdW70U=;
        b=Cj/5JzYibyFuKFNzZPDr5vJk0hJ6F874iVPQVdKoFWgYKSMtNnwzpUynAZnrL5R+Z5
         +nemyRdPmEpY95MnNL76a6rtNQRJ0FCBsBteYR6P4fkGCD64vAn2KY2Ul5aFpUAfdKFv
         GNmO7zBoZAJfHHVFd9wxaA06b60UBxPV1pUeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735925702; x=1736530502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPwpRuSLMbQOP94KV/MIzkS4jrRWUT1ASSsthIdW70U=;
        b=l22yr0oC1Rhcd2H97fLfSvwMU/KMLHlGJZXJWnqnHXCATHhmFpPUyvQ0WGTyWzqzPT
         kKEk/Nwl217p7RG9wv8BhIq/ImPNp1xXA3fvJipQAoIghOVMbWKvvOg2P+MyYM+bTUD4
         YE7BxZwVC1+0DRfCfpyExDivQ2WoYde/aBdAGoUrSFioLWtVFsMYNbAZNCo1rdxAwr+Z
         BGpR/TVVZ6zLZUCi72gIrNNvkQ43MYdqtwb06xP2N52hzc6NBSpydLnGWk4yfsdOMElx
         odDjJXeoNRb0Tf82rYaxBLYwuR6Ns8yb8Kz+3CXDkNC9EJrgngoaCE5VWtH5VIPipo7z
         JuMA==
X-Forwarded-Encrypted: i=1; AJvYcCVpAMi3k79vP7Wigx5nI4wHAoHo6CZYw/a56k2MnBgvy7+t0zhQYziW11sZpPDACf20Spo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAMaxS6Dlk+KwK2qpMljMKpSKLWj0LXMkg+Vhuc1Y9if/y9fp
	GOhjWS/CPRLQTW2TSLYd2ECWxahb1BLsp7zpWQGTcMVUh5A56FIAZqTAQ79yjasVM6qcVA4nNKO
	JD8fbx22U6dzE1iFJMD5RcvLWpNn5GeclkFdjHA==
X-Gm-Gg: ASbGncuE7YUDIJBT47wFdbF5LSecDlzmZNFtmLO1MnVy+UNEOsh/Zb1DiN1dZHV2qy5
	tiVpFj0YniXZ/2JAwpDncoA/8im1u72yh68Dm5g==
X-Google-Smtp-Source: AGHT+IFRrB++ciFx32hmJNbF/XnxFEgSwgCHy1QaFNUvFMLQ/IZhOeogLtat1Y6+xENxG1j0uY9DPShNk1uJ9bY9Zsw=
X-Received: by 2002:a05:6000:1a8f:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a223f5c51mr38232744f8f.38.1735925701934; Fri, 03 Jan 2025
 09:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk> <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
 <CAEXW_YRcGAMgjOM1Qv5=k7sVVWfiDagoHsvYn_6XJrFsZbHAEw@mail.gmail.com> <9b3565b8-7182-4ba5-8dcd-b93fd7eb7ddd@paulmck-laptop>
In-Reply-To: <9b3565b8-7182-4ba5-8dcd-b93fd7eb7ddd@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 3 Jan 2025 12:34:48 -0500
Message-ID: <CAEXW_YQ-yk777w4avC9y1+MxWZMpRx9PpLobsgHAOtOXMihWwA@mail.gmail.com>
Subject: Re: Taking page faults in RCU critical sections
To: paulmck@kernel.org
Cc: Karim Manaouil <kmanaouil.dev@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 12:08=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jan 03, 2025 at 11:50:29AM -0500, Joel Fernandes wrote:
> > On Thu, Jan 2, 2025 at 7:58=E2=80=AFPM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> > [...]
> > > > > Last question, do I need the -rt kernel for preempt RCU?
> > > >
> > > > No, CONFIG_PREEMPT=3Dy suffices.
> > > >
> > > > Note that CONFIG_PREEMPT_RT=3Dy, AKA -rt, also makes spinlocks (but=
 not
> > > > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > > > critical sections to block when acquiring these sleeping "spinlocks=
".
> > > > But this is OK, because all of this is still subject to priority bo=
osting.
> > >
> > > Should PREEMPT_RT kernels not throw warnings though when calling
> > > rcu_note_context_switch() in RCU read-side sections?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/rcu/tree_plugin.h#n331
> > >
> > > I don't run a PREEMPT_RT kernel myself so I can't confirm if these
> > > warnings somehow don't appear, but I figured it would be good to
> > > double check in this discussion.
> >
> > Please ignore my noise, Steven clarified for me in a meeting today
> > that preempt !=3D 0 in that warning, when an a
> > "spinlock-coverted-to-rtmutex for PREEMPT_RT" blocks. So even though
> > the rtmutex blocks in an RCU read-side critical section.
> >
> > In other words, I believe rtmutex is the exception -- It can block in
> > an RCU read-side critical section on any kernel (PREEMPT_RT or
> > otherwise). I could stand corrected though but that's my current
> > understanding.
>
> RCU doesn't know about this distinction, it is just told preempt or not.
> The scheduler passes in @true when the sched_mode is greater than SM_NONE=
,
> which includes SM_RTLOCK_WAIT.  But this latter is used only in -rt
> kernels, so that you cannot use rtmutexes in RCU read-side critical
> sections in non-rt kernels.
>
> So, in practice, portable code only gets to use spinlocks in RCU read-sid=
e
> critical sections.

Ah, true! SM_RTLOCKWAIT only is used in PREEMPT_RT kernels.  This
makes sense, thanks a lot for clarifying.

 - Joel
