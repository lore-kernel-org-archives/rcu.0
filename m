Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352741D1E61
	for <rcu@vger.kernel.org>; Wed, 30 Oct 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319149; cv=none; b=rWWXYEG5wtq4h+sLTvVhjtGrAHg46fZOMPsuh7FOSGo2Qhq1h2T6gLxT/AMD6X/txZPl01qInpca2VyO71cbOLyTyCF9ZkxVLEsbV929I0eS7Iwe5bfJZQAeXWZWOvPPMHeCuKK+fMDfRwgop2ZTzCVI/7dWVTD+kwQtyXyl4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319149; c=relaxed/simple;
	bh=gVrwd6b20qM/KGJRtOBT5km8yh4S7D6l1yUttkg7kVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C10G/c3adUr3QTVMSQFpszhfzEH1IEAF6D3I5RBt5JvGZCsGxxxM7OkDhPZ4SRrC0zGMhh63F/l0DgUXae6lGFXGJNdkO9huVY+1ew8UUrDmaVkG5flO6zftLvYrTPN1qwBvFuFOOnzoPf28iQx5d3r8AgqTs2JFM71KpisGxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNKb4o8k; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNKb4o8k"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so3014021fa.0
        for <rcu@vger.kernel.org>; Wed, 30 Oct 2024 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730319141; x=1730923941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yOu+cIxdXt/0LsD6zEL5lEadq9da0UuXDXVgDuNz3A=;
        b=XNKb4o8kciggKFM2Y5QPMcgNexd1Q52M7q/uJX5deVMJ0zBe61/38GMYV5Hh9AIr7/
         Eb/v0/SmjFsLmR4LXF5HzR7tHScd9HntX+vsdw47Ylc9PNU2R6sWxMoNOWsJGzICwXoF
         4uzTiq+nS943RR+2dUNJXxl5aAqIxwktJtAL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319141; x=1730923941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yOu+cIxdXt/0LsD6zEL5lEadq9da0UuXDXVgDuNz3A=;
        b=aDXc+X1xD5bvnTSDAYM8X77Pq0W10xeC1twgt/AlHcYbWM7j1y07doJ3VDh9SSXRcQ
         Jy8e6AurG9vFnk6CfJJ4d+1bfW2vqNsWQXhXiLes1eilIO8p0InFo8EpSlDg1qv/YNF/
         3QJ+V4ThW0XZ6bJYtovZlfV2VcIwyWwXb0wpM9Z2xIxkP+JrkL7mJpIrLBYR+kL2usUH
         QAGrZGokFg1WRLjOgEVwtCaJu2HP9rQ9LY7Shy8OJWxzwH1oegW4N1Y9GarvWnJyhasx
         Z8/8+wZQyrciB8S9Tl2OHcl5vME04jf2MlBvVupNQDnBul1Ue9128t0D+xp6umuQ0Jk0
         c8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG9YgU+5GOi8H92xKFIB34fSAmkj/KMsM6m4rFVIL9DeCDLlnbp38G/F0MuIVZ55f/7Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQZ9yOFVOSeFwdQlJCybn0NXxyiqCJoa9EGRgBy3cBxpjEbMc
	/Zd96oQSKQ/9vOY2npHh1C8figd9l+WRLmUxJHuOoKVQapgQjLDPe/QukYTJJ/hvbUXN9YScxpH
	coQ==
X-Google-Smtp-Source: AGHT+IEmMyGSLaJAJYVLQ8S+s2YGu9NZ6TOFpmNUVySdmoeZSiTBc2ngoA3v5myYKxwDVusbdF/afw==
X-Received: by 2002:a05:651c:b0d:b0:2fa:d604:e519 with SMTP id 38308e7fff4ca-2fcbdf7db48mr138343201fa.11.1730319140926;
        Wed, 30 Oct 2024 13:12:20 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fd5366b163sm3615751fa.123.2024.10.30.13.12.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 13:12:20 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f58c68c5so412400e87.3
        for <rcu@vger.kernel.org>; Wed, 30 Oct 2024 13:12:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNHQ09efNevdkV+iV6oSnqkRiNie4yNEy90IePDXbxGTnhFDalOmlRgZhNioccF20zZuI=@vger.kernel.org
X-Received: by 2002:a05:6512:6605:b0:53c:74a7:43de with SMTP id
 2adb3069b0e04-53c74a744afmr2455669e87.29.1730319138384; Wed, 30 Oct 2024
 13:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org> <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop> <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
In-Reply-To: <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Oct 2024 13:12:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
Message-ID: <CAD=FV=WBcOCGbD0haRYLGgAFpDhfoqMW8mvj9DEA0CSPHG3Owg@mail.gmail.com>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()
To: paulmck@kernel.org
Cc: =?UTF-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>, 
	"sumit.garg@linaro.org" <sumit.garg@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"frederic@kernel.org" <frederic@kernel.org>, wsd_upstream <wsd_upstream@mediatek.com>, 
	=?UTF-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= <bobule.chang@mediatek.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel-team@meta.com" <kernel-team@meta.com>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 6:54=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> > > We do assume that nmi_trigger_cpumask_backtrace() uses true NMIs, so,
> > > yes, nmi_trigger_cpumask_backtrace() should use true NMIs, just like
> > > the name says.  ;-)
> >
> > In the comments of following patch, the arm64 maintainers have
> > differing views on the use of nmi_trigger_cpumask_backtrace(). I'm a
> > bit confused and unsure which perspective is more reasonable.
> >
> > https://lore.kernel.org/all/20230906090246.v13.4.Ie6c132b96ebbbcddbf695=
4b9469ed40a6960343c@changeid/
>
> I clearly need to have a chat with the arm64 maintainers, and thank
> you for checking.
>
> > > /*
> > >  * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the
> > name,
> > >  * nothing about it truly needs to be implemented using an NMI, it's
> > >  * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> > >  * returned false our backtrace attempt will just use a regular IPI.
> > >  */
> >
> > > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtra=
ce()
> > > with normal interrupts (for example, on SoCs not implementing true NM=
Is),
> > > but have a short timeout (maybe a few jiffies?) after which its retur=
ns
> > > false (and presumably also cancels the backtrace request so that when
> > > the non-NMI interrupt eventually does happen, its handler simply retu=
rns
> > > without backtracing).  This should be implemented using atomics to av=
oid
> > > deadlock issues.  This alternative approach would provide accurate ar=
m64
> > > backtraces in the common case where interrupts are enabled, but allow
> > > a graceful fallback to remote tracing otherwise.
> > >
> > > Would you be interested in working this issue, whatever solution the
> > > arm64 maintainers end up preferring?
> >
> > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> > It is shared code and not architecture-specific. Currently, I haven't
> > thought of a feasible solution. I have also CC'd the authors of the
> > aforementioned patch to see if they have any other ideas.
>
> It should be possible for arm64 to have an architecture-specific hook
> that enables them to use a much shorter timeout.  Or, to eventually
> switch to real NMIs.

Note that:

* Switching to real NMIs is impossible on many existing arm64 CPUs.
The hardware support simply isn't there. Pseudo-NMIs should work fine
and are (in nearly all cases) just as good as NMIs but they have a
small performance impact. There are also compatibility issues with
some pre-existing bootloaders. ...so code can't assume even Pseudo-NMI
will work and needs to be able to fall back. Prior to my recent
changes arm64 CPUs wouldn't even do stacktraces in some scenarios. Now
at least they fall back to regular IPIs.

* Even if we decided that we absolutely had to disable stacktrades on
arm64 CPUs without some type of NMI, that won't fix arm32. arm32 has
been using regular IPIs for backtraces like this for many, many years.
Maybe folks don't care as much about arm32 anymore but it feels bad if
we totally break it.

IMO waiting 10 seconds for a backtrace is pretty crazy to begin with.
What about just changing that globally to 1 second? If not, it doesn't
feel like it would be impossibly hard to make an arch-specific
callback to choose the time and that callback could even take into
account whether we managed to get an NMI. I'd be happy to review such
a patch.

-Doug
