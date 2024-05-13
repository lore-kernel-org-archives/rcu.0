Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA6153817
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609656; cv=none; b=mjd0DCE+KXTGEmsNAK7nvvF1A/t74Pu9LrxwNu6YjobpsOMrZ8sYybeoF905fmRrrV1UImkZMDFX5FMKuIJeowzhSZ50zhTzgfq/hdN28PktV5YsA/QkDq6Ee77y/SazoMQreqyw4f5+GyPJcnIJx7Ewt58MibKG04TIJOIpeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609656; c=relaxed/simple;
	bh=FB9V+vs5E1VQUhmCPHB+F4habDJck32zqBLt199+I3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgi2T1egJaFFVSQe+iX6VlcIKD0SdBKrtrmnPAVObVGc0tx4PaB+QDFXuHZgtBFIdKgu+5BS9bn2ORpAEeDOU7YlFp5+4T+5beC0tvIP0aZYli5Qm5DAfMnQS5Dbce+xvbrjee3y9e/G/OtPbqIkbulwg9GwW1gUkGpsyQgMoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z93enhUc; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z93enhUc"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c99aec9598so1617108b6e.0
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715609654; x=1716214454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2UOBn2IF+668KdrcZrqcrK14CUBpiCxB9sfNMBwRB7s=;
        b=Z93enhUcs5q6v/kvwubU26jUlpt9p2dwds+1vZR8gA59/gBdWMBuMZD1ISXJcuiHJ5
         N/2vjfRVI/uaaYEke6olAvOUmSVBbVBYSjDxOWKrJMNgHd3bQnB3O84ya2k9QQoBPCG9
         5S7F24TctYrnjnomPyjVCwoAc41E8K9NZMybTtLDNHy6a8qe4NfLs5W5xMzmPcjo7zG6
         nDysdj8izHJkmJ2e+KwFPQ9loPrL58c/NbBWflJjk3nV4BGYiP9zCzkc5I7dCmxBFUVr
         qosV31JLKtd70CQgQm3SNvRl3MnjgO+nOhOSsKh9PY2KrxEZx1CpeTYXueKJzv6Ynkjp
         d2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715609654; x=1716214454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UOBn2IF+668KdrcZrqcrK14CUBpiCxB9sfNMBwRB7s=;
        b=Q/H2TLhQpTwLGwZAs85YOtcxaN1XwiEbKIQc0dZdl4lnAVjV2qKKeDZlrp/qwwrAWD
         pMlc7xCnKE7DXYPgFhlFlMddxWMZ8rQf029PsTTJauUBFHIyb+cuXvA1dc6NHwQt8WMQ
         WwF2dDZ8qtgjh+FOAzDm7gnrkv60PVdYmq2lvtGAdtcMEUoBODaYLxMO7K91m3x7Jtjn
         3CcPwzzxaLCEFiJWp3Az1zkORW1NO6WaUu5kgYs0olNlHSgqED6ZGCSkRuaBiN9G+GOl
         t6ZRsbsookiynsFF4f+e5efhiu+ERFBBBv8PRGS6t0cUEHKZv7A/OUnkE8gPSxZrXSQB
         A6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPFA71ux+YDieSMNA+a6/kvnlBLPuqqiiqqVBx7zZFYdVLqCC9hRtIa5MCXf4NBSEV2fXDbu3nSiyBnj1K7ydA/NG
X-Gm-Message-State: AOJu0Ywl69ENhh+eYYd4T6s89K8Y+MwFKd5C92JdCDq1Y33+IL23XsWy
	hsZ4wPKWdDLFBa1KYx04SY5xVzJf/JY7VD83GyoYvWnDKNoc4HWtF8QIFPE19Rp9Tnwv8Qpc/X+
	X3bYLu04LWX0auI3y+Zm14GQyT1n888Bvq+b6
X-Google-Smtp-Source: AGHT+IGu6SKrlKrLBVpI5R4Fi+Tdpwzzi1hi7Ih528iP/NR27zuc68FroGIgKA8luFoPZtoMcHDGZD3nlymLqxVlv+E=
X-Received: by 2002:a05:6808:358:b0:3c9:66dc:1a7a with SMTP id
 5614622812f47-3c99707247emr10272851b6e.32.1715609654266; Mon, 13 May 2024
 07:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507093530.3043-1-urezki@gmail.com> <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com> <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com> <20240510135057.GC24764@redhat.com> <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
In-Reply-To: <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 13 May 2024 16:13:35 +0200
Message-ID: <CANpmjNMUJ6UMwWAEHfm-7WZ=jKD56PH67Zp8dB6B=fEysiK=Hw@mail.gmail.com>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
To: paulmck@kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 16:11, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > Does this mean that KCSAN/etc treats the files in kernel/rcu/
> > > differently than the "Rest of Kernel"? Or what?
> > >
> > > And how is it enforced?
> >
> > I can only find the strnstr(buf, "rcu") checks in skip_report(),
> > but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...
>
> Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
> which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
> prevent skip_report() from even being invoked.

The strnstr hack goes back to the first version of KCSAN released in
v5.8 [1]. It was added in response to Paul wanting the "stricter"
treatment for RCU even while KCSAN was still in development, and back
then syzbot was the first test system using KCSAN. Shortly after Paul
added a KCSAN config for rcutorture with a laundry list of options to
make KCSAN "strict" (before we eventually added CONFIG_KCSAN_STRICT
which greatly simplified that).

While the strnstr(.., "rcu") rules are redundant when using the
stricter rules (at least CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n is
set), we're keeping the "rcu" special case around because there are
test robots and fuzzers that use the default KCSAN config (unlike
rcutorture). And because we know that RCU likes the stricter rules,
the "value change only" filter is ignored in all KCSAN configs for
rcu-related functions.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcsan/report.c?id=v5.8

Back then syzbot occasionally reported RCU data races, but these days
rcutorture probably finds all of them before syzbot ever gets its
hands on new code.

Thanks,
-- Marco
