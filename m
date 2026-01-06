Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7E2FC00D
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720893; cv=none; b=OPm0MWXPlTdSwjLGsw8kNa3v0HG+nQLiGHauf7hZ9xFI/wIzOEFNIu+FX5JLWHNlrdDKM1AzYTchnMkHLWH67TAaaFTcxspEiGrEpyubBG5YkGtsLUYKYzry6/VeB19JyR4Vt99UyC1FosV2p2oakCr96XIQdJcHcRksUgF+Keo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720893; c=relaxed/simple;
	bh=vbg/4Kuy8+wEtCaTdI808rOQJV/eEI0U33FeZ9sxcno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU9gt5+tORRZ4DqjZVukGxVy+0RCLg5ThKF4LUx1YU4R/RbuolD3gCUlLc0zPeNVM6yMjfWXuV5pt5EiJTJGEll2wFmFCYwzeG0u/3W8ZoxLIK1Oezn29ujzaqIJGxV8J0VX8BfPttppodRUOyy6+69Jo9KMSTrNSW8y7Ang8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ljs0vtvS; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ljs0vtvS"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47755de027eso7454225e9.0
        for <rcu@vger.kernel.org>; Tue, 06 Jan 2026 09:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767720888; x=1768325688; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXcHtzljW/LEwcnvhUw7B+CYy+kN5WC/pk6M+qEtNI0=;
        b=Ljs0vtvSNgpYJhknDhx9bELQGkkGVBktvrRTynlExmpLIGaAKcKfy3q+Vzhc0CBdzt
         hBu8YqcaTsruwaGPpR28ZieFzq6vpX9ppPbtMDq1YX7oLCc1WBHU2/khCZGPgcPiCJQo
         /SdqgjVvcX4o8hT7DcaJnMaMrndMqG0BlSQCVNuO18iucidmTBu/KWco362PprZTfFO/
         XbxStM5Ax6eKh7Rzmwb+jd7wTMCelndFhBbeJ2nvVNQfn/FL+xadO2yxh5ZLwyELgTkw
         edYtcRWUeQEl3fZGMU433z7W5zEQdjxichBC/sKkiUvsD8eW0UgBMhLx19RKhPBoMKrS
         pmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720888; x=1768325688;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RXcHtzljW/LEwcnvhUw7B+CYy+kN5WC/pk6M+qEtNI0=;
        b=kk9ewEjacTKECTMfPOP/nj9YneAO/OAv6PiZk9lHb8F+ShD7a6uLnvaQr6jot1TbR6
         7GDaHw4W+QjqEteyzxjlbYzsX0yeHCGetwSa7ixmZISH8uOBT8B2t5hPh/Thu53tK/W8
         K+65B8aB6NRNIPzemSHtvX03ZfFGY0IW7ABh/d3XvK3hMied2B2YiXGBXY/dBfQnHext
         Vl/CXRehAgysA2EVSsSLeQVACaqBumMtqbwPYPI0keL1ipxV+LlEuQnKRr5Spp+i8k5z
         clx2IFpmlaXrWVv91jV88B+yFMoarBXjChadiTWS4x9zf8RjqP8Wo8bjRlPvK/hD70pm
         22Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWKtMJGk4sJeWoNN5rHoJbZUPnsPlVN+MKWcnz+YKNz3J1f+ghVmGwSdlsIQINGftMllsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrsr/1tmU0pvU2QCFGqsFMAYBv5KS7LYG/illXvzTPbzIt/REC
	PF+y+GcpldRTnNPGhBc+Sg08orEXwCFGGd2GQ4ZRhdxipxrODUamZyOMMUP4gOECdw==
X-Gm-Gg: AY/fxX6ZREAUmNzm34GYBL5VsFl+r+1v9NviFXW/GGSYMKGsawvBw7HPjY7ojck2FoW
	Egj3wQNI8ynMjOxfJr8cgfbnDpan6SjrIut5/syiATTkTIloFK2KKMfcZiG24Po63Jhj+Dbu5iB
	K2GrRGGdvf1vGhsLoI4qK9PAgL2pyL+yKXKHu5u9R8BUio0TmcM8KavfIgCirWiHjQlNkMipI28
	9Z4YpdKqRQnXQUGBKd3drRaz+7v72QYvJZqqNWedBxCyghFRsd2uUckWOgSQ66m2vlTFBaHSqHT
	U85sDwWIqsM5BlPK8bMFsSI5pdgN2OzvlH2t8dMX3IhTKN9wlzNqMpzbtPMwq9q+XzJ6S+4mlOT
	ymKQRgXh+igX4w3Sn/OJwkMEBq3Hs7gMfat4dw7nzigoHQNoxHoa9Swi88jKAHDbNbYvUktA+Or
	YMg+HPsSelv1JPfPPJzMvpwzevpWJ+COkg62G61fOmcxT5qn0D
X-Google-Smtp-Source: AGHT+IHmVK6EqE14VH+HPUL16Zk51harYxsBJJheKVL1BeqXTS/M31ba8unH1eaK7+ALdSr4nMxyjw==
X-Received: by 2002:a05:600c:46ca:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-47d7f0980e2mr44046495e9.23.1767720888108;
        Tue, 06 Jan 2026 09:34:48 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:4477:8df2:f516:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7fb4b3c5sm21868415e9.15.2026.01.06.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:34:47 -0800 (PST)
Date: Tue, 6 Jan 2026 18:34:39 +0100
From: Marco Elver <elver@google.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context
 analysis
Message-ID: <aV1HrwZm6xg8PnRU@elver.google.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-7-elver@google.com>
 <993d381a-c24e-41d2-a0be-c1b0b5d8cbe9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d381a-c24e-41d2-a0be-c1b0b5d8cbe9@I-love.SAKURA.ne.jp>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Jan 06, 2026 at 10:21PM +0900, Tetsuo Handa wrote:
> On 2025/12/20 0:39, Marco Elver wrote:
> > Introduce basic compatibility with cleanup.h infrastructure.
> 
> Can Compiler-Based Context- and Locking-Analysis work with conditional guards
> (unlock only if lock succeeded) ?
> 
> I consider that replacing mutex_lock() with mutex_lock_killable() helps reducing
> frequency of hung tasks under heavy load where many processes are preempted waiting
> for the same mutex to become available (e.g.
> https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6 ).
> 
> But e.g. commit f49573f2f53e ("tty: use lock guard()s in tty_io") already replaced
> plain mutex_lock()/mutex_unlock() with plain guard(mutex). If I propose a patch for
> replacing mutex_lock() with mutex_lock_killable(), can I use conditional guards?
> (Would be yes if Compiler-Based Context- and Locking-Analysis can work, would be no
>  if Compiler-Based Context- and Locking-Analysis cannot work) ?

It works for cond guards, so yes. But, only if support for
mutex_lock_killable() is added. At the moment mutex.h only has:

	...
	DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(_T->lock))
	DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
	DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _RET == 0)

	DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex **)_T))
	#define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
	DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __releases(*(struct mutex **)_T))
	#define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _T)
	DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct mutex **)_T))
	#define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr, _T)
	...

And we also have a test in lib/test_context-analysis.c checking it
actually works:

	...
	scoped_cond_guard(mutex_try, return, &d->mtx) {
		d->counter++;
	}
	scoped_cond_guard(mutex_intr, return, &d->mtx) {
		d->counter++;
	}
	...

What's missing is a variant for mutex_lock_killable(), but that should
be similar to the mutex_lock_interruptible() variant.
