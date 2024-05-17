Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5253171C8;
	Fri, 17 May 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930963; cv=none; b=UozZZIyw5mcC7xpLe8XnJM4EK6GpZ43f00lf88jTdfm4t5V6JBBSgmi8wiDAt6wtiJS+0B8raZt/5ZD7nmhCH+lI3pRUxO4Frbi+PkVV7RURx6O4At06u4oSF+b9hjgzr787yjAjNlHBcJN0Vri/5/1drEdo0izIBPqwagm64Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930963; c=relaxed/simple;
	bh=JcFy9wI2fCmQGEdr1NVxaKAez7/HrMxMQ8LJ4cTv2BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFuVCIw5cN7HAqMvOR1BROSVRXTIwhDqOeN3/j6sR/eN3iHv/YbKQNwbJXRURYvm1JgJP80vwpjIMLR34mWnbCIJHNoVAzdCkLtM7itJWd/GX+l7vx0u1wiv0619XMeLBrfXTDkbQLeZb6glZ/1Z/lKoSt2aW/PKtzO+ZYInDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+10ZFDg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+10ZFDg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so5828195a12.2;
        Fri, 17 May 2024 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715930960; x=1716535760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIDlmTcrkUL1grWAfyafdkzosM3PP7GzQlmm46EHWGw=;
        b=L+10ZFDgPdzZgtfyZbeW4CXYZIMshsK2obOzq97eu6jDb4R0lRqSTRgVOc6XIIRFVD
         hT5EZyRrhxdwzHhefvXiFuJxUvQbJ6xvhlvygMuNIS0RrC3LX4zANU/ZCXCIcBoWlAKO
         24n951o9enrQEjWefq4XH3hJSC6hxwQR8uGRTSOM2I3hNKFaiu1IpG6fQtlGf8rq0ceB
         g/gxJUx5eMNW8RUv++UjY0TyUrIHNVDI34sZpALRpMSuS15GJsGCXplP2iM5oCPJuhFO
         Gfl+kANavgFrAVFNy7+uXy28HUUGjpqXF8lW1iibnPGKpwpHq7f5rAQGGyn3E34SqK3/
         hPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715930960; x=1716535760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIDlmTcrkUL1grWAfyafdkzosM3PP7GzQlmm46EHWGw=;
        b=o8HJqdelj09fmfSPc5q0TlCrkKobHT62SpQ9VuE/EqE4jZLxqjSqpiKUMGaTtNSeUq
         24njCzE4VaBwvpfdQw0+csT+GiYM+kXytcpCz3c6U2rrICTJEhiObJVjcg/wgqNn85Ou
         LYfUaejDQYjv2VtVUhxa/c2OsA4CBXysTEEep+nlDqYrXMzqpXgVubbA7Z+PaU/s39ei
         1Y9KY7pS5FzVs7oFX77zlT4w57l/IafTY/dnrzD2yxZYQsWwAXRxYgzE63kAHEe1r1E2
         AnOqdtLiyZ31LsQZlaIMrt+ppwIh1aXjK/f+6TNPqyWNFH4DSSYS58nFWbNQuXOVWtTb
         M6ow==
X-Forwarded-Encrypted: i=1; AJvYcCU558Qqkad3tXlRmHQXcTU/Lb+x0OvyR3qWkllZiflH6/iXmPqHFTPBIvGp91PBvlXPZTcnW/yoRhcOKjQhDaUr74sWEtOjK3MkeyKiQCAKBXo4nEjawVEBxdTTXIhbjXvU
X-Gm-Message-State: AOJu0YyErHI6DNWMwY0DDbqn9hxUqZL/JBQpA0lBej5GCIYuNimtrr7W
	JbCIVQAls46rB6/AosWRMxbXkLioOTWQPTsLRt0hNQko34DXefFR
X-Google-Smtp-Source: AGHT+IF+xeFL8Y3/eFHMWlAozg3wklgU1U4SEzpA/ZQI+VWwHl0dgegcgMXT0kEdwT8FMdGUkPsitw==
X-Received: by 2002:a50:8714:0:b0:572:a073:a39a with SMTP id 4fb4d7f45d1cf-5734d5c1651mr22064969a12.5.1715930959836;
        Fri, 17 May 2024 00:29:19 -0700 (PDT)
Received: from andrea ([151.76.51.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509a90101sm2011004a12.79.2024.05.17.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:29:19 -0700 (PDT)
Date: Fri, 17 May 2024 09:29:14 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZkcHSnvn0TZX6YzV@andrea>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
 <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkYvemdrEOVFNtVu@lothringen>
 <xhsmha5kphefq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmha5kphefq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

> >> > @@ -773,7 +773,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
> >> >   */
> >> >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> >> >  {
> >> > -	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
> >>
> >> So for PPC, which gets the smp_mb() at the lock acquisition, this is an
> >> "obvious" redundant smp_mb().
> >>
> >> For the other archs, per the definition of smp_mb__after_unlock_lock() it
> >> seems implied that UNLOCK+LOCK is a full memory barrier, but I wanted to
> >> see it explicitly stated somewhere. From a bit of spelunking below I still
> >> think it's the case, but is there a "better" source of truth?
> >>
> >>   01352fb81658 ("locking: Add an smp_mb__after_unlock_lock() for UNLOCK+BLOCK barrier")
> >>   """
> >>   The Linux kernel has traditionally required that an UNLOCK+LOCK pair act as a
> >>   full memory barrier when either (1) that UNLOCK+LOCK pair was executed by the
> >>   same CPU or task, or (2) the same lock variable was used for the UNLOCK and
> >>   LOCK.
> >>   """
> >>
> >> and
> >>
> >>   https://lore.kernel.org/all/1436789704-10086-1-git-send-email-will.deacon@arm.com/
> >>   """
> >>   This ordering guarantee is already provided without the barrier on
> >>   all architectures apart from PowerPC
> >>   """
> >
> > You seem to have found the accurate informations! But I must admit
> > they are hard to find and it would be welcome to document that properly, for example
> > in Documentation/memory-barriers.txt
> >
> > I think the reason is that it's not supposed to be used outside RCU, perhaps
> > because its semantics are too fragile to use for general purpose? Even that
> > could be stated along in Documentation/memory-barriers.txt
> >
> 
> That's also what I suspected when I stumbled on
> 
>   12d560f4ea87 ("rcu,locking: Privatize smp_mb__after_unlock_lock()")
> 
> which removed the references to it from Documentation/memory-barriers.txt
> 
> > Another thing is that its semantics are similar to smp_mb__after_spinlock()
> > (itself badly documented), although slightly different. I'm not even completely
> > sure how. I assume that smp_mb__after_spinlock() can be just used once to
> > produce the required ordering and subsequent lock on that spinlock don't need
> > to repeat the barrier to propagate the ordering against what is before the
> > smp_mb__after_spinlock. However IUUC smp_mb__after_unlock_lock() has to be
> > chained/repeated on all subsequent locking of the spinlock...
> 
> IIUC (big if) the chaining is a requirement of RCU itself, per:
> 
>   2a67e741bbbc ("rcu: Create transitive rnp->lock acquisition functions")
> 
>    * Because the rcu_nodes form a tree, the tree traversal locking will observe
>    * different lock values, this in turn means that an UNLOCK of one level
>    * followed by a LOCK of another level does not imply a full memory barrier;
>    * and most importantly transitivity is lost.
>    *
>    * In order to restore full ordering between tree levels, augment the regular
>    * lock acquire functions with smp_mb__after_unlock_lock().
> 

I know my remark may seem a little biased,  ;-) but the semantics of
smp_mb__after_unlock_lock() and smp_mb__after_spinlock() have been
somehowr/formally documented in the LKMM.  This means, in particular,
that one can write "litmus tests" with the barriers at stake and then
"run"/check such tests against the _current model.

For example,  (based on inline comments in include/linux/spinlock.h)

$ cat after_spinlock.litmus
C after_spinlock

{ }

P0(int *x, spinlock_t *s)
{
	spin_lock(s);
	WRITE_ONCE(*x, 1);
	spin_unlock(s);
}

P1(int *x, int *y, spinlock_t *s)
{
	int r0;

	spin_lock(s);
	smp_mb__after_spinlock();
	r0 = READ_ONCE(*x);
	WRITE_ONCE(*y, 1);
	spin_unlock(s);
}

P2(int *x, int *y)
{
	int r1;
	int r2;

	r1 = READ_ONCE(*y);
	smp_rmb();
	r2 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 2:r1=1 /\ 2:r2=0)

$ herd7 -conf linux-kernel.cfg after_spinlock.litmus
Test after_spinlock Allowed
States 7
1:r0=0; 2:r1=0; 2:r2=0;
1:r0=0; 2:r1=0; 2:r2=1;
1:r0=0; 2:r1=1; 2:r2=0;
1:r0=0; 2:r1=1; 2:r2=1;
1:r0=1; 2:r1=0; 2:r2=0;
1:r0=1; 2:r1=0; 2:r2=1;
1:r0=1; 2:r1=1; 2:r2=1;
No
Witnesses
Positive: 0 Negative: 7
Condition exists (1:r0=1 /\ 2:r1=1 /\ 2:r2=0)
Observation after_spinlock Never 0 7
Time after_spinlock 0.01
Hash=b377bde8fe3565fcdd0eb2bdfaf3351e

Notice that, according to the current model at least, the state in
the above "exists" clause remains forbidden _after removal of the
smp_mb__after_spinlock() barrier.  In this sense, if you want, the
inline comment (I contributed to) is misleading/incomplete.  :-/

  Andrea
