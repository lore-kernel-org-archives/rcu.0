Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89842BE4F
	for <rcu@vger.kernel.org>; Fri,  3 Jan 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923044; cv=none; b=HfypFS6k5i4ljnJ/nyHYb2Fvw6IdQz0nnxzSy78YhTzegbuyAxa7ly2JU6cHHnfclNndZiuPOxXmlT5fHrYfV3Zg98Su6rWAq5wAQKhyUfJaS9xUkE6XSesltjC/IM8xkPPMt94m94qE5rWbOKihchEW+cD1ZGpkCZv6iwq+aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923044; c=relaxed/simple;
	bh=jfIIwHq0qtf1edauL8jcdVssF7q6aCivQveGRx9/cRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n715c8wfbOIlBUIsIhXrweq00FaIT7SVW0B/bWce762asVNXABuXFTBk/TjEpMRs6AJHHOeWolg1er7lgj/ONnNAOQnZD/j6cTCZeW/Htmzli/eFqb6MkBBX3jr2eq5DReQlAerw6YnpOvdqRjhtF9eRXSuBCRBAN+ge+g02hFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QmvtkpwX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QmvtkpwX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a34e8410bso4013248f8f.2
        for <rcu@vger.kernel.org>; Fri, 03 Jan 2025 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1735923041; x=1736527841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfIIwHq0qtf1edauL8jcdVssF7q6aCivQveGRx9/cRA=;
        b=QmvtkpwXPJYJNMH0aLGrJeXrGueHkptJvC4e8RnhxotlhQ9DJmbVIlnLTMWDyZLvii
         twdJ9w4O/XoG1HpDeEakNYz4HvJy2nYNFdLPuT2k6CbYocNbQtak4WMNLDmWe8SQ/23u
         fe8mlAg+28udwzPh3CV15068eml85Y7g5pn1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735923041; x=1736527841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfIIwHq0qtf1edauL8jcdVssF7q6aCivQveGRx9/cRA=;
        b=pEa17/yoq8+dXqDSUCwJtf6lPiM0BFxsMaK/p40Foz/EB4d0zGUWOB1Rgvw7YtAsti
         OfNRS0/nLw5IJg6JBpIyOpcchtkt1Ji9KQcFeDy5ZF3fr++pSNxzJELIzYtmHGgcNUGf
         GSpTj8+3aCbfiFnR+RZhN98AqDaLR8GgFZh3DoIzJPyOM1Ri6HrZLEqDyVFSuDVPwev/
         t/5VJ+5g0267x9bRNc/bXzBirBd6HKrQfI6MOJ+o8xSK9eDJG9mLut2x2yiXEmktvbv7
         HVrDqBZrbckJW0Mt3FowORMg59U0z1VmsI3UbTGPH8i5HZ8gxrFrEbRBv3VSThQvjScF
         cN7g==
X-Forwarded-Encrypted: i=1; AJvYcCXFjJ/RokMWXghI/x+x59LeoHpN8u/Zxqw5V3SpPvCdw2cAEapFV8d8PWw+Md9F1/NSrhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYl5zZZT7WqTRc1f61I17DlnRU8dUHYL5YkWhraxRiBNsjjuVe
	Ea2HrIhWj6aOkqceGLokniZoOhmSv7X2weSPkKLZJQgpF8Llm9jDQrOdtl49hWGSVKp+PBS3s5I
	bvvBB8oNxHG/WYXh0tFzC5bLdXbtOipT3Sh0gzw==
X-Gm-Gg: ASbGncv5xPH1VQ9mGHTgPgyOwQvtRL5t4EIRECoDPJfYripJns+jCwy9PUNjEqLl3bZ
	TLzr4J7sKTfVR+xqa884GKIfzJZ9UT0JsXk1UQt0=
X-Google-Smtp-Source: AGHT+IGqUviYMEjw6Iz6WFD6HaXyu/+XxDyKHNcYGIiI6FUqnH5wGi8tnDuP53Wq3h/kEYw+yp0lanmBXk3uhh2jxy4=
X-Received: by 2002:a05:6000:4a03:b0:385:fcfb:8d4f with SMTP id
 ffacd0b85a97d-38a221fae8amr43305026f8f.21.1735923040739; Fri, 03 Jan 2025
 08:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102182343.vlgzo6wjf5abqxol@ed.ac.uk> <afa3b043-0591-463e-8b61-21db547a25ad@paulmck-laptop>
 <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
In-Reply-To: <CAEXW_YT5W2R4ebof1Eo5hix1JasHm0Kz_nDOxM9Fv-k7iNGsmQ@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 3 Jan 2025 11:50:29 -0500
Message-ID: <CAEXW_YRcGAMgjOM1Qv5=k7sVVWfiDagoHsvYn_6XJrFsZbHAEw@mail.gmail.com>
Subject: Re: Taking page faults in RCU critical sections
To: paulmck@kernel.org
Cc: Karim Manaouil <kmanaouil.dev@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 7:58=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
[...]
> > > Last question, do I need the -rt kernel for preempt RCU?
> >
> > No, CONFIG_PREEMPT=3Dy suffices.
> >
> > Note that CONFIG_PREEMPT_RT=3Dy, AKA -rt, also makes spinlocks (but not
> > raw spinlocks) be limited sleeplocks, and thus allows RCU read-side
> > critical sections to block when acquiring these sleeping "spinlocks".
> > But this is OK, because all of this is still subject to priority boosti=
ng.
>
> Should PREEMPT_RT kernels not throw warnings though when calling
> rcu_note_context_switch() in RCU read-side sections?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/rcu/tree_plugin.h#n331
>
> I don't run a PREEMPT_RT kernel myself so I can't confirm if these
> warnings somehow don't appear, but I figured it would be good to
> double check in this discussion.

Please ignore my noise, Steven clarified for me in a meeting today
that preempt !=3D 0 in that warning, when an a
"spinlock-coverted-to-rtmutex for PREEMPT_RT" blocks. So even though
the rtmutex blocks in an RCU read-side critical section.

In other words, I believe rtmutex is the exception -- It can block in
an RCU read-side critical section on any kernel (PREEMPT_RT or
otherwise). I could stand corrected though but that's my current
understanding.

thanks,

 - Joel
