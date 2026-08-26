Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30E380FC3
	for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750530; cv=none; b=hdwRJjWwBiiJVKKxu8dGHk8vnfuZjS5T27mL+4hdTCSJLT1HotY30aGu3saoLdLbBzEy0CmSC7hz5e5Ymu6tpZTe07065rAV9pJP5EdrBmdt7hYK8aoY1vwDi8VHkzhskWnOE09v93oD1SA7CcFVsnew4Yac/jairh0Fd2siaXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750530; c=relaxed/simple;
	bh=jM/haCiOpfA9FknTZ1fDNwWJnszfe2QUJZzOmWp2QEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfRXJ0JjffUjaAgPDEC3A/Y9U8U45Z4lyAJXhXlJYwm6CB9v5NwZCWfzM8J7uva9R6CQ0YBXmdLofTxSIkSItNGCAWjozwHkYZO5wMYj7GVesh8uAubK4iU8zEhTS4bnWSnXuFfkRMJcu35GeAgJ7k6ot/dCpe3hk8u4/Kh+nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuOTTuJ7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuOTTuJ7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499a4d1d7f1so5580855e9.3
        for <rcu@vger.kernel.org>; Wed, 26 Aug 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787750527; x=1788355327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCybwoH2BHkmxPF2zNCOC0wwFEJW00Hw7Im1uIu4w4Q=;
        b=TuOTTuJ73ZUX6EF1di5nFZjMO07ZUeNnYf2Ll1xUI7r+nP8OSFWRY3Rc5eyBRSZLAj
         f9BdGtrRL5lzjTUHNGNlk3J1tWrlsGZtUrgH6Z/Kk65oU1C1jEBShyJy+y3DbPV4I5in
         hXHz5lhD65bJ0Fj6BqYCbf0kS5XqeRjl2JaVObFQeQK4pTHR6eyT/h1RrgDB8DXNrke7
         j6S4cHP4rrMceE13ZzOLa+FKxSClXwRFuvHsljAp/BUkHni3yD+aupIzcaoxp3cS+84J
         Izu4qMaiEyhfyzUxI4bMB31xAhdOY+HlqORpTIr7GvqeVAZ6Vm1If+EC3Ci1cZ1L4o8y
         DqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750527; x=1788355327;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCybwoH2BHkmxPF2zNCOC0wwFEJW00Hw7Im1uIu4w4Q=;
        b=HYlLJ6Cth/wkwirCeLnXmFC3WRiEeXugwGoKY2JJbLIERt5pcEVlpLAwxLPC2G2gdM
         TemTtBvjS7Xe1uJuWY4Fynhk+m8+xqgRs/WD2v2PZgBWsCKoKiqMEMfIE3yXTl/hrZ30
         Jv87JxAEHzpU6DIJ8M3b9Qu030ibCPi4G1RAg4wup49u3EAXNk+07tDBB/Y0ykd5+1fN
         O8JSvXsq4lfUHgXO0g/gSS8v0mj7NXu2i+hq7WK5LSsOc61QaTb9zStw0o4yypEWcUZv
         0tua01+3KcrTLRZHhYf7V2V4kaVvGERXsbJTWhFLxtwOyK1/TCgmGkPnxsR5R5TlqeEF
         Gikw==
X-Forwarded-Encrypted: i=1; AHgh+RobItMwC7RNYZQ+93Zfm1TSuvRjVTmObLu2KH3DaWsJS34OOMuIGWcGlU2jPKCGVSYVeKA=@vger.kernel.org
X-Gm-Message-State: AFuF++lQkgA2K929RR85kd6HmU48XNKWflnBYaeKOqITH8izAUpyZITa
	QMhGxsJDjITHdP5YHkfIoUwzBeL6afHnN/QwyWXzM08RbyTD0aGo7RAG
X-Gm-Gg: AR+sD12kt9Ve5bpBp29MvpkjdOhrFYfmB7hT8axnPiITb9VIZlBqe8Svj6UyJrCe2sC
	Bmigqhb1yne8iegYS1Jc5w0hdWfOY1KUYjnV6uFBqMil6CrgzwpUTSpx9EvmIjlmWbxfTkdwSuU
	oWiC8m28DgEuIo4sSqygGcK2ZU9jA7BqLkSPUfTX1OLrQNjNf9nsACzm77fUR5f5ywOCnqURRbl
	ygCom7LiIqGVSusH75nNOoGMZv+BqmhbF67XQN0bWapg0ZFiTo5Xj6LWmV51D3OmSd5iGpbvJn6
	U+KHmYmmyUK/qGVEiGZxHk2YHugBUVWmXZMTJt5ihMsTdPP7IJVTpy1CLY2IIGb3p9RZedTGGH+
	JjhicI7c88Eh0/xdNqMGWJzxlxwxudyM7f9z1Ix2Hvbo9K+Wn8WSu9KJIwYwX/YtkNPQ3VAGkKl
	RfJPymZoSfVasECUCpOhunrOle0gfn1djEhIh3L4PHliA8dNvRfVzisOm/M1MpYDvzuY7e1hsZ4
	i+Tf33a4bKCoOkyDN7LjFZhug==
X-Received: by 2002:a05:600c:4585:b0:498:952:e276 with SMTP id 5b1f17b1804b1-499dc6f7ec9mr54471045e9.8.1787750527096;
        Wed, 26 Aug 2026 06:22:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dca9fc48sm25667895e9.8.2026.08.26.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:22:06 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:22:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
Message-ID: <20260826142204.7269edf7@pumpkin>
In-Reply-To: <CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com>
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
	<20260825-unqual-v1-1-7024fb81b4f9@chromium.org>
	<20260826105527.7ebbb4b1@pumpkin>
	<CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 13:28:42 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi David
> 
> On Wed, 26 Aug 2026 at 11:55, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 25 Aug 2026 20:02:10 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:  
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 44c07a66edff..80276cedda80 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
> > >  context_unsafe(                                                              \
> > >       typeof(*p) *local = (typeof(*p) *__force)(p);                   \
> > >       rcu_check_sparse(p, __rcu);                                     \
> > > -     ((typeof(*p) __force __kernel *)(local))                        \
> > > +     ((TYPEOF_UNQUAL(*p) __force __kernel *)(local))                 \  
> >
> > Ugg... TYPEOF_UNQUAL() is absolutely horrid...
> > When __CHECKER__ is undefined the whole thing is just (p).  
> 
> About using __CHECKER__: Are you suggesting using #ifdef __CHECKER__
> to use TYPEOF_UNQUAL or the current code?
> 
> I am open to doing that, but I would like to hear from Paul if he
> favors adding the (also horrid) #ifdef to save some CPU cycles on
> older compilers.
> 
> >
> > I suspect reducing all the definitions would measurably improve
> > kernel compile time (even before these changes).  
> 
> When I checked earlier in the other patch in this patchset, with my
> compiler I can hardly see any difference in compilation times [1].
> This is probably because GCC15 direclty maps TYPEOF_UNQUAL to the
> built-in __typeof_unqual__.

I was thinking of the _Generic() version.

But here you only want to remove the (I think) __user marker.
I don't think you want to get rid of 'const'.
So you don't really want gcc to remove any qualifiers.

There is an similar(ish) issue when an __force cast is used to
remove one of the extra qualifiers.
You really want the compiler to ignore the cast - so it checks
the actual types match.

David

> 
> 
> Thanks!
> 
> 
> [1] https://lore.kernel.org/all/CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com/
> 
> >
> > David  

