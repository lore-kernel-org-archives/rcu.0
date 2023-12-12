Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hwOgqxW9"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712CCE
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 14:29:08 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so72356201fa.2
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 14:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702420146; x=1703024946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM2oFcmkLjW3FikUP/eoYjixPLts4910dHArXjSnpH0=;
        b=hwOgqxW9vZ+myVo84TiqTdCzEiAS/TFVTXeBFmUqEx9Mq3jALyvqYmTjObbsNyfNDd
         cvvyPqLSsnLXmYxIYE4/vtTJe1BUO+u1jr5VaB4I89vrIz44hx/U2K0D7KJn5XSuoufx
         cifrBt8PAQV77B29hvJppXGZErLbz4qkXBj6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702420146; x=1703024946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM2oFcmkLjW3FikUP/eoYjixPLts4910dHArXjSnpH0=;
        b=rjuboBSEXodNIGnRs+FextlSehlIysWBIe7hfLEb9+neBdYYTGC/XdOuYrcAm1J06m
         +RzsG99g1w/BcjJYsc80qDx8Yq4iMMBHdYbzmord97QXboLIfv8fovHhOgoy8FQFpTl/
         a49rxwaRjLkgKCVP3p6Y90RvPhcSNR/SIpyhhUaeFmPojHxkljzOVQtNuuRY9wrU5E15
         AIVfgUPFLwvwEr9ENi6Nd68XZe94SoiYcAGciJMoTTMTWqbHvXMN10llA22ku0xtjorf
         KRzem7x3WPRyL/za06nVl8I+QaoTARnk1UCEo4Wb0BY9jVZu6AHyg3Rnt9qJW/SvVSDH
         aYxQ==
X-Gm-Message-State: AOJu0YzSU38bh5ONafPqDack0PxK192DvYkSsqtYZua55K7dtZexuI1b
	ouhYRRPko+tE1Sd8kxePLQmh0bwZw121f118awHDMQ==
X-Google-Smtp-Source: AGHT+IG0nOu5RZCJaImlmjRGaCwDl1KWJlq/EVJZho+0/F5snnqjyS9NAgSm0IzFYNC3Eu2NCh6QdsNpBHAimtqJTxk=
X-Received: by 2002:a2e:8051:0:b0:2ca:f17:dd60 with SMTP id
 p17-20020a2e8051000000b002ca0f17dd60mr3387464ljg.62.1702420145762; Tue, 12
 Dec 2023 14:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231203011252.233748-1-qyousef@layalina.io> <ZXhTjrTqZvMTXKtK@pc636>
In-Reply-To: <ZXhTjrTqZvMTXKtK@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 12 Dec 2023 17:28:54 -0500
Message-ID: <CAEXW_YSMwmG_joipkK5W1Bdwzdjm_a3f86BijkAkAJTHOWkE0Q@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Andrea Righi <andrea.righi@canonical.com>, John Stultz <jstultz@google.com>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 7:35=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Sun, Dec 03, 2023 at 01:12:52AM +0000, Qais Yousef wrote:
> > To allow more flexible arrangements while still provide a single kernel
> > for distros, provide a boot time parameter to enable/disable lazy RCU.
> >
> > Specify:
> >
> >       rcutree.enable_rcu_lazy=3D[y|1|n|0]
> >
> > Which also requires
> >
> >       rcu_nocbs=3Dall
> >
> > at boot time to enable/disable lazy RCU.
> >
> > To disable it by default at build time when CONFIG_RCU_LAZY=3Dy, the ne=
w
> > CONFIG_RCU_LAZY_DEFAULT_OFF can be used.
> >
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >
> > Changes since v1:
> >
> >       * Use module_param() instead of module_param_cb()
> >       * Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
> >       * Remove unnecessary READ_ONCE()
> >
> > Tested on qemu only this time with various config/boot configuration to=
 ensure
> > expected values are in sysfs.
> >
> > Did a bunch of build tests against various configs/archs.
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> >  kernel/rcu/Kconfig                              | 13 +++++++++++++
> >  kernel/rcu/tree.c                               |  7 ++++++-
> >  3 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..2f0386a12aa7 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5021,6 +5021,11 @@
> >                       this kernel boot parameter, forcibly setting it
> >                       to zero.
> >
> > +     rcutree.enable_rcu_lazy=3D [KNL]
> > +                     To save power, batch RCU callbacks and flush afte=
r
> > +                     delay, memory pressure or callback list growing t=
oo
> > +                     big.
> > +
> >       rcuscale.gp_async=3D [KNL]
> >                       Measure performance of asynchronous
> >                       grace-period primitives such as call_rcu().
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index bdd7eadb33d8..e7d2dd267593 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -314,6 +314,19 @@ config RCU_LAZY
> >         To save power, batch RCU callbacks and flush after delay, memor=
y
> >         pressure, or callback list growing too big.
> >
> > +       Requires rcu_nocbs=3Dall to be set.
> > +
> > +       Use rcutree.enable_rcu_lazy=3D0 to turn it off at boot time.
> > +
> > +config RCU_LAZY_DEFAULT_OFF
> > +     bool "Turn RCU lazy invocation off by default"
> > +     depends on RCU_LAZY
> > +     default n
> > +     help
> > +       Allows building the kernel with CONFIG_RCU_LAZY=3Dy yet keep it=
 default
> > +       off. Boot time param rcutree.enable_rcu_lazy=3D1 can be used to=
 switch
> > +       it back on.
> > +
> >  config RCU_DOUBLE_CHECK_CB_TIME
> >       bool "RCU callback-batch backup time check"
> >       depends on RCU_EXPERT
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3ac3c846105f..8b7675624815 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_call=
back_t func, bool lazy_in)
> >  }
> >
> >  #ifdef CONFIG_RCU_LAZY
> > +static bool enable_rcu_lazy __read_mostly =3D !IS_ENABLED(CONFIG_RCU_L=
AZY_DEFAULT_OFF);
> > +module_param(enable_rcu_lazy, bool, 0444);
> > +
> >  /**
> >   * call_rcu_hurry() - Queue RCU callback for invocation after grace pe=
riod, and
> >   * flush all lazy callbacks (including the new one) to the main ->cbli=
st while
> > @@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_ca=
llback_t func)
> >       __call_rcu_common(head, func, false);
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu_hurry);
> > +#else
> > +#define enable_rcu_lazy              false
> >  #endif
> >
> >  /**
> > @@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -     __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> > +     __call_rcu_common(head, func, enable_rcu_lazy);
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >
> I think, it makes sense. Especially for devices/systems where it is hard
> to recompile the kernel and deploy it. For example, Google and GKI approa=
ch.

My concerns had nothing to do with recompiling the kernel. Passing a
boot parameter (without a kernel compile) can just as well
default-disable the feature.

I think what Qais is saying is that passing a boot parameter is itself
a hassle in Android (something I did not know about) because of GKI
etc.

thanks,

 - Joel
