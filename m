Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10A225A3E
	for <rcu@vger.kernel.org>; Sat, 20 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758363844; cv=none; b=c1/flw4AvpopTiUjIqAv8MvKaOAVW8/hCWLW3RmiSNyp25s5A/93/LVYrCQAAu//WV1Nqqd3YgnHKKV6Zt8FlSVGmSl2iHf9UYQC9AKfOuit+PivvxBV21Dp3014mqSjcvHk5JcfbWJYgMn8VABt4VclMCpryB5B3CeDXQYNnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758363844; c=relaxed/simple;
	bh=8iXqxhSdAkakZE+dXKkGUnoGkkyheEh1y2QTTcyyR7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBsjLozmqBp/DDxGQH03yKi/OMtAKkuPgSuv8rgNLNkDMpOy4KMD6mn7q7JqCbt0VaaPxOkI4Or+GXlHOLqJicvgUZYEDS0k3tmBrerPSVvxu+CRSvDPpre9skFbUq8IlPvY2rc4vZOU3vO9vnk5U+nFg1Q4uUlK0mI2kR97S88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gQBCBgx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gQBCBgx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f169d8153so888908b3a.3
        for <rcu@vger.kernel.org>; Sat, 20 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758363841; x=1758968641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hZhQHzO6iaBCv+wcIWwJCdyKEWcJ4Nfwc3KoJ0ZPEA=;
        b=2gQBCBgxMSwu5AB2o+jkFTBAcijwtXwzg/RdQCHcsKaXBDvcjJBEtjbb59L9NQTMqW
         +4KIoKH6AO8wRCb7goV1WcVnX2N2bcart2Omvg/Kqm5KFBOobRJPJ8NNA6IQL7vL7etK
         BYgjhcThGprquHWXLLxvVznTq7aGbIgT+UYS4wYtPiTtDM9ZW4SvF4keMPfUj/rDgRR6
         G+rtl7LYgu6D0JAiBtafGsEhSvUpGD9b0htdsLGQC9f5yY8ovG7vfPsPq6bUdBfh4tNY
         Y9xn2nze+Ia56cqt94zGvidFt/2kHe0e1AZJfrEWx+hqBpvT41kMu6y121sexUc3sJl0
         JBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758363841; x=1758968641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hZhQHzO6iaBCv+wcIWwJCdyKEWcJ4Nfwc3KoJ0ZPEA=;
        b=ds/3uu1TEh5lnhHceKQdBrdP0PUbroegCQT+hWJJ1mmj2AUIp74YJxes+xbbq5FcBS
         F/XjVw/y9CoS38erVdC1bUaSQa2rbVHB7R8sfLYcTTioi+ZeXvATDDhioX904YVZ7utJ
         17gI9EEKiG773I1onuMX5aBvAaoxJ5X5+FDHb0j3vyOi3tPBDXBpVULiv/c6QTuamQBE
         C4yFxTLTnkVhpaLSMOdRYnDm0fM8xIA44a+DZR5P9DfVqhZgACxqr/gW+7Cv5ee5Ua5L
         u1vunxcF95ZNPZOrWeOH5XTNab5DAv6HRdi2Bh+5r9/IOxX3E9L3tlf1MQVfIPvVhuw4
         4SVg==
X-Forwarded-Encrypted: i=1; AJvYcCX0vdtvLazdVt9oUT3tOaypBWIqqiKPprSAr2y4Mj3ije3gJisLVwUW5T4NzTtHDQsh6os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJFYmv3A6UR4Mgxo58BBZflESCyqmcpUrevSiP2ONx4KC5N+5
	OEERgnGFmR657dL27rRElB8VnQhuzsh4M/uSAR66YgKfMpbOSlNaGsCrnJuizrHI9dHy/zI6sSx
	2mluzHET++4Dp36gCZfP6frIwVoWniBNNEZMRltP8
X-Gm-Gg: ASbGncsE1Ac8XL7Zat0/8AYW05SmMvVeYsRDlTKsbEusQ0C9nYIZtQnftTmZjfn+wdT
	w0HLajsFF8isouP70TZUNJNcDqmHMFkAgqZGEDh4BpTZKUb5E60eO6qcztnGmjUg9b9nsm6I9SJ
	FFp28/Sf9LTIxtsmihYXhSludtHByfMLoiAF9BnFBGobHuo3Cd9vGQkH5MU/MXfMuqyVpqwfRX9
	YcM6z6hKJmuitf/VwOcdFjXiUNdW9FaIMY2Yg==
X-Google-Smtp-Source: AGHT+IF1hPc3B6dX8ioPYAwTkyAHDxIYYc2DoRTSnEgCHR4nACV75/Lf01kjKhlKCzTUMHiS0p59fc36fJvtYjO83jE=
X-Received: by 2002:a05:6a20:914d:b0:27b:dcba:a8f3 with SMTP id
 adf61e73a8af0-2925f76be25mr8434118637.15.1758363841077; Sat, 20 Sep 2025
 03:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <20250918141511.GA30263@lst.de>
 <20250918174555.GA3366400@ax162> <20250919140803.GA23745@lst.de>
In-Reply-To: <20250919140803.GA23745@lst.de>
From: Marco Elver <elver@google.com>
Date: Sat, 20 Sep 2025 12:23:24 +0200
X-Gm-Features: AS18NWAyC50-QQYD_wTUETPBlkphWLV8M7F-miEs8DZ-lOTnj5WEfB5uYr0Ax6s
Message-ID: <CANpmjNO2b_3Q56kFLN3fAwxj0=pQo0K4CjwMJ9_gHj4c3bVVsg@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Christoph Hellwig <hch@lst.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 16:08, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 18, 2025 at 10:45:55AM -0700, Nathan Chancellor wrote:
> > On Thu, Sep 18, 2025 at 04:15:11PM +0200, Christoph Hellwig wrote:
> > > On Thu, Sep 18, 2025 at 03:59:11PM +0200, Marco Elver wrote:
> > > > A Clang version that supports `-Wthread-safety-pointer` and the new
> > > > alias-analysis of capability pointers is required (from this version
> > > > onwards):
> > > >
> > > >   https://github.com/llvm/llvm-project/commit/b4c98fcbe1504841203e610c351a3227f36c92a4 [3]
> > >
> > > There's no chance to make say x86 pre-built binaries for that available?
> >
> > I can use my existing kernel.org LLVM [1] build infrastructure to
> > generate prebuilt x86 binaries. Just give me a bit to build and upload
> > them. You may not be the only developer or maintainer who may want to
> > play with this.
>
> That did work, thanks.
>
> I started to play around with that.  For the nvme code adding the
> annotations was very simply, and I also started adding trivial
> __guarded_by which instantly found issues.
>
> For XFS it was a lot more work and I still see tons of compiler
> warnings, which I'm not entirely sure how to address.  Right now I
> see three major classes:
>
> 1) locks held over loop iterations like:
>
> fs/xfs/xfs_extent_busy.c:573:26: warning: expecting spinlock 'xfs_group_hold(busyp->group)..xg_busy_extents->eb_lock' to be held at start of each loop [-Wthread-safety-analysis]
>   573 |                 struct xfs_group        *xg = xfs_group_hold(busyp->group);
>       |                                               ^
> fs/xfs/xfs_extent_busy.c:577:3: note: spinlock acquired here
>   577 |                 spin_lock(&eb->eb_lock);
>       |                 ^
>
> This is perfectly find code and needs some annotations, but I can't find
> any good example.

This is an interesting one, and might be a bug in the alias analysis I
recently implemented in Clang. I'll try to figure out a fix.
