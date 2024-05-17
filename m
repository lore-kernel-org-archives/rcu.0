Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC141C68;
	Fri, 17 May 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963240; cv=none; b=nom5SQvz5Zurvo9W5ZbBmCIjy3597fjoiaZOJ2pBn72wfbCcZSN64QOL1va5uGqvZxvTJZccQB4hKJandsYwbREIY9B4Q+tXiLex8eXEx0jW2YXAWtmI6/ptQgijkbg1jw369yPpBZhU+NpW3AxoEIMgieaU55ULMk1Yj9CLNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963240; c=relaxed/simple;
	bh=dOWyivRVjUsmi9qycvWUG6w2Rgzchn0zj4IqRET+Xtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRmpdWWW+nEm1TdaJrHp1wbg0RjxsyRfQJjfBATbl8hYTYbx9/Fl9932BBWwC5axHJwB0I7Rls3oiKgeabk/MdsOlPi9rpRPSmIrXuSuUTM1X4Oy3r1Er/e8gr9HJiLBV02ToUpSg/ic6vAwGFemwifmmlsYiu8i2CqHr7qqA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em4r12zY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em4r12zY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a934ad50so470393066b.1;
        Fri, 17 May 2024 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963237; x=1716568037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHHFYGGHR8IWFe03susFUhICZjFQcAnsx/YAE07Ghdw=;
        b=Em4r12zY+ON4jf6azOpDvZ+uRkGcSow6FypnUhl4ESWUfVU+A+5qxUp7p0/UMJi2gE
         tRNgUI2Qirblhj8hWPq0zC/u2H/X99XBUUlZKmYcJrnIoUAGeNtDMbcAMhYb6DUvZXel
         KOm1fMx5eU09mmFBBbQfDuXvOLL0wrvxJMdklevaaJl3KibmdgcyL/2seQ0jAtsfzBsZ
         O437aE4f1irMx3ahtbrCT+Wb4Av3LAmQiV2afKNJvH6ISUNARG8hTILWlpLKnGyKRF0e
         cCufX2MyZA6OapRxT1vWjoSCHataWghufZivVFkEjJRBcfb5D3sBhjhtZvSX5tV28+xp
         CYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963237; x=1716568037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHHFYGGHR8IWFe03susFUhICZjFQcAnsx/YAE07Ghdw=;
        b=aa/3PYszHwgDSoHc+bZXjewnWROVWMww6qyAH+e5Jjd2LVVIm1icgk3IR9gjnSqS/q
         IzyImV7TDdDjARdD9OOhckX8/TJuxlD7oWu78e+K0Vb0mNM7J5gUxBScavrLnjYxaOzN
         Rv5ASCnIE2ehlIVKugT1sK9LDa7kv5SFTizdaG6qYFMgC7/OGSxM0PV8mPGFlR+z2gyq
         9B1PipA8ZM0LU5EQ6Ze+Xn946CJf1XLNwWKRBbWUafMRQuEvQ1kHKxbl3GXHtMVTAB1U
         6DMzxaPp55e3oVAGsf/kULNra2i3F2U6PCQLZTrxxKXqwe5+FQwpQIs3q7D4A63UlMGZ
         Plbw==
X-Forwarded-Encrypted: i=1; AJvYcCVH6WlqZOHFjhWWtaCVPn5aMNEMeNuGKMz3g1y5KcpOkvUbQ8HIXAZbE3ELcBDpCd1vpIZTmolVDBVx5c/SH/xODWoudSDIj6ECaXuFwSOzjwieD99Xbx8hOwaUlM9DVQMV
X-Gm-Message-State: AOJu0Yy4VebRx2OvAexSxjNkeLhHhS0Uy9eZ03PVBId2ZKGf3ty4XAMJ
	1lB1WqKEY3/kN/wy7RDN5vGo6sp+3MvXcGGesAU/FI1gC1HbMtHS
X-Google-Smtp-Source: AGHT+IEw7QYQO5Ri7sHi5TIfcVMt9q8Z+NU9UCIb07eEdhh9RIQPDAohAy4uwuRFEeeJh1c26fSABg==
X-Received: by 2002:a17:906:7248:b0:a59:a431:f955 with SMTP id a640c23a62f3a-a5a2d6786e5mr1465349566b.73.1715963237063;
        Fri, 17 May 2024 09:27:17 -0700 (PDT)
Received: from andrea ([151.76.51.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01d3dsm1125803166b.186.2024.05.17.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:27:16 -0700 (PDT)
Date: Fri, 17 May 2024 18:27:12 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZkeFYJ1saaMWPUON@andrea>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
 <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkYvemdrEOVFNtVu@lothringen>
 <xhsmha5kphefq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkcHSnvn0TZX6YzV@andrea>
 <ZkdCG28qNha2vUSo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkdCG28qNha2vUSo@localhost.localdomain>

> Z6.0+pooncelock+poonceLock+pombonce.litmus shows an example of
> how full ordering is subtely incomplete without smp_mb__after_spinlock().
> 
> But still, smp_mb__after_unlock_lock() is supposed to be weaker than
> smp_mb__after_spinlock() and yet I'm failing to produce a litmus test
> that is successfull with the latter and fails with the former.

smp_mb__after_unlock_lock() is a nop without a matching unlock-lock;
smp_mb__after_spinlock() not quite...

C after_spinlock__vs__after_unlock_lock

{ }

P0(int *x, int *y, spinlock_t *s)
{
	int r0;

	WRITE_ONCE(*x, 1);
	spin_lock(s);
	smp_mb__after_spinlock();
	r0 = READ_ONCE(*y);
	spin_unlock(s);
}

P1(int *x, int *y)
{
	int r1;

	WRITE_ONCE(*y, 1);
	smp_mb();
	r1 = READ_ONCE(*x);
}

exists (0:r0=0 /\ 1:r1=0)


> For example, and assuming smp_mb__after_unlock_lock() is expected to be
> chained across locking, here is a litmus test inspired by
> Z6.0+pooncelock+poonceLock+pombonce.litmus that never observes the condition
> even though I would expect it should, as opposed to using
> smp_mb__after_spinlock():
> 
> C smp_mb__after_unlock_lock
> 
> {}
> 
> P0(int *w, int *x, spinlock_t *mylock)
> {
> 	spin_lock(mylock);
> 	WRITE_ONCE(*w, 1);
> 	WRITE_ONCE(*x, 1);
> 	spin_unlock(mylock);
> }
> 
> P1(int *x, int *y, spinlock_t *mylock)
> {
> 	int r0;
> 
> 	spin_lock(mylock);
> 	smp_mb__after_unlock_lock();
> 	r0 = READ_ONCE(*x);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(mylock);
> }
> 
> P2(int *y, int *z, spinlock_t *mylock)
> {
> 	int r0;
> 
> 	spin_lock(mylock);
> 	r0 = READ_ONCE(*y);
> 	WRITE_ONCE(*z, 1);
> 	spin_unlock(mylock);
> }
> 
> P3(int *w, int *z)
> {
> 	int r1;
> 
> 	WRITE_ONCE(*z, 2);
> 	smp_mb();
> 	r1 = READ_ONCE(*w);
> }
> 
> exists (1:r0=1 /\ 2:r0=1 /\ z=2 /\ 3:r1=0)

Here's an informal argument to explain this outcome.  It is not the only
according to the LKMM, but the first that came to my mind.  And this is
longer than I wished.  TL; DR:  Full barriers are strong, really strong.

Remark full memory barriers share the following "strong-fence property":

  A ->full-barrier B

implies

  (SFP) A propagates (aka, is visible) to _every CPU before B executes

(cf. tools/memory-model/Documentation/explanation.txt for details about
the concepts of "propagation" and "execution").

For example, in the snippet above,

  P0:WRITE_ONCE(*w, 1) ->full-barrier P1:spin_unlock(mylock)

since

  P0:spin_unlock(mylock) ->reads-from P1:spin_lock(mylock) ->program-order P1:smp_mb__after_unlock_lock()

acts as a full memory barrier.   (1:r0=1 and 2:r0=1 together determine
the so called critical-sections' order (CSO).)

By contradiction,

  1) P0:WRITE_ONCE(*w, 1) propagates to P3 before P1:spin_unlock(mylock) executes   (SFP)

  2) P1:spin_unlock(mylock) executes before P2:spin_lock(mylock) executes   (CSO)

  3) P2:spin_lock(mylock) executes before P2:WRITE_ONCE(*z, 1) executes  (P2:spin_lock() is an ACQUIRE op)

  4) P2:WRITE_ONCE(*z, 1) executes before P2:WRITE_ONCE(*z, 1) propagates P3  (intuitively, a store is visible to the local CPU before being visible to a remote CPU)

  5) P2:WRITE_ONCE(*z, 1) propagates to P3 before P3:WRITE_ONCE(*z, 2) executes   (z=2)

  6) P3:WRITE_ONCE(*z, 2) executes before P3:WRITE_ONCE(*z, 2) propagates to P0    (a store is visible to the local CPU before being visible to a remote CPU)

  7) P3:WRITE_ONCE(*z, 2) propagates to P0 before P3:READ_ONCE(*w) executes   (SFP)

  8) P3:READ_ONCE(*w) executes before P0:WRITE_ONCE(*w, 1) propagates to P3   (3:r1=0)

Put together, (1-8) gives:

  P0:WRITE_ONCE(*w, 1) propagates to P3 before P0:WRITE_ONCE(*w, 1) propagates to P3

an absurd.

  Andrea
