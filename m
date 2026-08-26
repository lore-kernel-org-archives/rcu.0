Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC6265606
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753014; cv=none; b=PFsYnzYhBygNHpfODTDHqw38a8o+SHTqtzH43PlXjcLLFFDhcMXaeLOVphX5ZwXu6aPBR6zuR43nYIl8q/VBaV4UnmXQqH5GZj1AbAms1DJhy7bDIlWrezm1X6THmlkerg57adyaR0u4N1IInG3Km1U3XqBLI0G4iPqxwYVH858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753014; c=relaxed/simple;
	bh=eOWDtM993LvzR4PXJYtYIUI/SaXxP+ZtJGv2sQMHhaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoLJGNNdoWP7mEGVo1zPrkzr9te9g2ZoL+qrB9nK4utJIMvryYtMLwAJsy/lBc67m7DRdrf77mlSWo1Gr88AWjZNFhgETRChmd9KfU9oMeYFNaoX7ZMEfLkZYqCB9rdE/oE+u12eXWlfBigqgHhPzsKZNuGQBTjaUWb8jc0ckuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZFGemJAB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZFGemJAB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486ac3f347so2458745b3a.1
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787753013; x=1788357813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YQ1O3a7BEQ576b846tLfxlLaWsfr16E0PmQle8XoP8=;
        b=ZFGemJABX69X2LkTcRFdSRMUR4I6szt8NObvVPhU4GkcVDWF2zq/dQLiW+RZ2SP12w
         3N8h/u2w0xk3Xnr+I3J0spg3zEThqkp6YxmekRwjj5jZg/rmWab00a2KlndRBRuVt5fM
         eBFivm6Wq3IbP/kPbW04777r/meJzmMvkP1PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787753013; x=1788357813;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3YQ1O3a7BEQ576b846tLfxlLaWsfr16E0PmQle8XoP8=;
        b=T2PaqJolv6vPojzayEHPmTsP680vJ8Cnj/YixcR7hswc3OmHiFuVf1C+4qscEBcHoN
         4olRLOpb9HA5JE36vuxqVg174goGwtOvhnkZmQ9A27PbuEtU2pBRwffIM8TWXsI3s4dc
         fg3pyX3MKGfpMPBWp5CCwaS9B9MwqQ4N3IiUDQLp6UUT8RX2aZxucvfl69wavoVAx1lz
         Wszri7o8KdGtC7BUdunS9zkPJATtpLQ8PydaCckroI8c0o5cSifoZk6zh8xuqdufp+NR
         Cm1vPe/B7TwycKEDO7OqEoF5mzyxU8z+K3T/UipG6LFV0FJoItNrL7kLt1w9Tz2v9DZL
         d7fg==
X-Forwarded-Encrypted: i=1; AHgh+Rq37vKRiquJw8s2yG/W4pmnAqDEXasYf7KSLGc9gumt2KzRJghBhnv1LHxgzEz4DKg21/E=@vger.kernel.org
X-Gm-Message-State: AFuF++libfgVju+p1Z6L261Y75BQnV96oUYSe4mRKbxSVsSdIYlatnv0
	q5LbRGl2jTvf0rJBhNc6JjvPytCR1c1GB72MtSCv/1Fx+nqnBOBfF6AOzQPuKJ4omqf0vyvD9CQ
	44jQXqTta
X-Gm-Gg: AR+sD10awsHoTZBbnxbgb+d9c//WwfCkloOuPKbiOqIVjpBREMG2tMz8YUhalhDlpvQ
	Jr7k+ZXeCsoM9/E7X3qS9f5Z2NR8XZGBW9nAmlSD2znPT9Pp5jSRoqDRqxPVL37KP7lYUj4r1dI
	lHq8fbvgHn+/roNT95xngTL7s7PnOwEmY3N/rUe9m4m79hcot+C2bkjRFL0kI2gcipRQJxOrsUy
	wolrXshBLfcswDYoqxI/Wi17ushbnAnRbsc5wB2ylEFBGOkUtTIwzf7eG1zeGPwMEuY3kQ4kuJo
	qQtclVE1ukTV6cQ6FncAdRxO/qJEx0qEvxg7Oaw/sJfLnFGP34XWs5KgiXNTSzGDro+lLPWJJA2
	6Wm3m/TmrCaN9dajPiwfmayJgp75HQ75exINwtV7Z5eicjlt0YEUZc2OKfmhc5EvkwD3GcSxnsQ
	2jNDlGni7Rr1koSZw62Qhep27xl6R9I9BFGJ+LV7y6YhLlEuDwJ0Rf3AkWBSDfTGJRTXAj8LkFi
	3k8dPelG8c3adRESwUStHBpZVrnRzy9jMMaIM5E
X-Received: by 2002:a05:6a21:101:b0:3c3:d298:81b2 with SMTP id adf61e73a8af0-3ceed3820dbmr11090041637.1.1787753011108;
        Wed, 26 Aug 2026 07:03:31 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beb0f15dsm1031661a12.9.2026.08.26.07.03.28
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 07:03:30 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca80d708489so775223a12.1
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 07:03:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqfteI70g+xl+0BoM/c3g43ddY0ilKjeKm5JjjjV8JHLUHyHE1ZkryKqu0WxdWZJtVf2ME=@vger.kernel.org
X-Received: by 2002:a17:90b:2f06:b0:369:7491:7b24 with SMTP id
 98e67ed59e1d1-3964595a73dmr22431303a91.6.1787753007440; Wed, 26 Aug 2026
 07:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
 <20260825-unqual-v1-1-7024fb81b4f9@chromium.org> <20260826105527.7ebbb4b1@pumpkin>
 <CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com> <20260826142204.7269edf7@pumpkin>
In-Reply-To: <20260826142204.7269edf7@pumpkin>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Aug 2026 16:03:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCuAWhEZerLE2Ki-agDgZ-WEZLr216siKRq+Zj2PnaRWMw@mail.gmail.com>
X-Gm-Features: AcwNN1UPC157xfljKv_JsxBT_y0zjaKHIht79TsT5My1H0BwGd5Ga-7oJMwjg3I
Message-ID: <CANiDSCuAWhEZerLE2Ki-agDgZ-WEZLr216siKRq+Zj2PnaRWMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
To: David Laight <david.laight.linux@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David, Dan and Paul

On Wed, 26 Aug 2026 at 15:22, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Wed, 26 Aug 2026 13:28:42 +0200
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > Hi David
> >
> > On Wed, 26 Aug 2026 at 11:55, David Laight <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 25 Aug 2026 20:02:10 +0000
> > > Ricardo Ribalda <ribalda@chromium.org> wrote:
> > > >
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 44c07a66edff..80276cedda80 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
> > > >  context_unsafe(                                                              \
> > > >       typeof(*p) *local = (typeof(*p) *__force)(p);                   \
> > > >       rcu_check_sparse(p, __rcu);                                     \
> > > > -     ((typeof(*p) __force __kernel *)(local))                        \
> > > > +     ((TYPEOF_UNQUAL(*p) __force __kernel *)(local))                 \
> > >
> > > Ugg... TYPEOF_UNQUAL() is absolutely horrid...
> > > When __CHECKER__ is undefined the whole thing is just (p).
> >
> > About using __CHECKER__: Are you suggesting using #ifdef __CHECKER__
> > to use TYPEOF_UNQUAL or the current code?
> >
> > I am open to doing that, but I would like to hear from Paul if he
> > favors adding the (also horrid) #ifdef to save some CPU cycles on
> > older compilers.
> >
> > >
> > > I suspect reducing all the definitions would measurably improve
> > > kernel compile time (even before these changes).
> >
> > When I checked earlier in the other patch in this patchset, with my
> > compiler I can hardly see any difference in compilation times [1].
> > This is probably because GCC15 direclty maps TYPEOF_UNQUAL to the
> > built-in __typeof_unqual__.
>
> I was thinking of the _Generic() version.
>
> But here you only want to remove the (I think) __user marker.
> I don't think you want to get rid of 'const'.
> So you don't really want gcc to remove any qualifiers.

Yeah, I see your point, removing `const` might hide other issues.

Dan, what would be the best "sparse-approved" way of removing the
address space qualifiers (__user __rcu)  but keeping the other ones
(const) ?

Paul, would you accept an #ifdef __CHECKER__  block to keep Sparse
happy without affecting GCC type checking?

Thanks!

>
> There is an similar(ish) issue when an __force cast is used to
> remove one of the extra qualifiers.
> You really want the compiler to ignore the cast - so it checks
> the actual types match.
>
> David
>
> >
> >
> > Thanks!
> >
> >
> > [1] https://lore.kernel.org/all/CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com/
> >
> > >
> > > David
>


-- 
Ricardo Ribalda
