Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F91A01A9;
	Thu, 19 Sep 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756262; cv=none; b=o4MFnIPndUmQFwQYIeTQBZTmNgm5iwoxXcVogm4QfkmiLyyUf/r2o5p4jf67pQ69BQQkpC8/x0gYN40GoJ0aVNnn9I7Rq8sAsC4F2qTJvZH413ef8dB85JOQ0nY1udpy/F6VhY6UCrpy+WceCBxXNAJ2ykqJmS5TQZil0ceqn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756262; c=relaxed/simple;
	bh=zyDZrAsm2q4pAS7d5/oZXpjb1vnYbGyUykOVuGRGg/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLojb9sPzG+40+fV2wU6P283DV9GXdql0kGKaVNbNV4ZTlKtmU/JiURF+V5joGZYNVW+Vlp96+EgCENj/M6OlUjs7CcShhs8sU7S21cqOBvOmDWoAFzvb9LjpAAoaiSlZuVEQoRSjG8RSYEJfpl7sCc8xW9HVagKbKih+G/BgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo3f/eQf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo3f/eQf"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5df9433ac0cso476446eaf.3;
        Thu, 19 Sep 2024 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726756260; x=1727361060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiPyQtok24yVSzumHz7/j5nUGPIHzy2zjNQ4k/nbsBA=;
        b=Lo3f/eQfDIqhX6lbjDjS74KoyxXcUS9IwOQkkRNMJBYWJfaHRHoaGZXKPcl0uvnhH7
         vIEtKv+8alzU1poBW5vKJIwaXxK/Mfb4wQxdWSkFzjzGxFy6STPFLXtf7w4DpoAWFDFp
         Add29pgLgAuo8DnJE/30xEsPtJrN96ygLItMXnxxPC9cBl6OGTd7Ojv9utx5/norHF4c
         P8JBXVsJeADoohbSHC8HArEr4X4hPotYcLLGRLJwy0IcoJnCMGiuYVEaCO4qo3q8Atfg
         Jr0AgNUBdYlVn+QilThioQWq7vG0XGfdQXYhGt9/DggK0WgerX7tmov2lCD5iWRncxAE
         j1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726756260; x=1727361060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiPyQtok24yVSzumHz7/j5nUGPIHzy2zjNQ4k/nbsBA=;
        b=F3YSmqVw0lqDHHVbD4tp8G9cCAjc9XGa7j5gVn+b8HFMLkFKV1QS5emhSjsHc6sKzy
         4ic3b9yZzogwMnbpxKUVZpXvu9tbW2d0Ugi5ZoSyAtKqZwpC/HViIKQ9gaqWrW5n1Kyg
         nWyZt8OeoToxznzEBLMUpUkzNCKoPFkO5c0cxW+kmKf36pJCn/tIrSQSOX6vnoAqkZc8
         1semuTJz3dA5CKtgx1ZHIBJODHkSvk3Vf7f7Ewg2g5G7qISs5VUrVRG8WWR2rLGQJlKJ
         ALkQx11nW8HSLTWndNXA8+mOkYKKN8LqRn2Z4M+thbzbSG/ufZc7xsiS6Dm5Dj+xBwca
         NEXA==
X-Forwarded-Encrypted: i=1; AJvYcCV3aQzGeEURSaXCxxxrukLprninRJnXZHupX7MUeYrxhIrn1g+vFu7FwVca4ptneyhVkEF/9fm7c6j0SKs=@vger.kernel.org, AJvYcCVRoyKERV8DEkZK3LW6upRewifeQV702NR7McgNqxc9+eQIs7Gbeif3pFgCBK4jF/xeC6eN@vger.kernel.org, AJvYcCVs41AOhOgeqZoyaFASETFf8gMy1bLJQGMF1PeyRaIvD7T4XrbZixm67JcPw80BgL9i7nsp8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBkP2nDoolYDI3e8cl2JnbC0mcp5RhbY+FKrFYfnMMRI+Ax8K
	VqDZoYibGKhs8+v93E1ZODq4Ybye81HuPntaqXFJXZCxN7g1CCJQ
X-Google-Smtp-Source: AGHT+IHFCCX3zwh0AEuYYEJIlgTq/4aYBTceJd7qLehHaLQIROmZ4+w37oqZqU3UN2mwapakGnh1aA==
X-Received: by 2002:a05:6358:2492:b0:1b8:6074:b5a with SMTP id e5c5f4694b2df-1bb14dca507mr765456255d.1.1726756260257;
        Thu, 19 Sep 2024 07:31:00 -0700 (PDT)
Received: from f (cst-prg-94-182.cust.vodafone.cz. [46.135.94.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e46f29asm7947046d6.36.2024.09.19.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:30:59 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:30:42 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-mm@kvack.org, lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
Message-ID: <j3scdl5iymjlxavomgc6u5ndg3svhab6ga23dr36o4f5mt333w@7xslvq6b6hmv>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
 <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <050d17f6-7db4-4a05-b4a5-6d5ab4f361cf@amd.com>

On Thu, Sep 19, 2024 at 04:14:05AM +0530, Neeraj Upadhyay wrote:
> On 9/18/2024 12:48 PM, Linus Torvalds wrote:
> > On Tue, 17 Sept 2024 at 16:34, Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> This series introduces hazard pointers [1] to kernel space. A TL;DR
> >> description of hazard pointers is "a scalable refcounting mechanim
> >> with RCU-like API". More information can be found at [2].
> > 
> > Please give actual "this is useful for X, and here is an actual real
> > load with numbers showing why it matters".
> > 
> 
> One of the use case where we had seen improvement is - Nginx
> web server throughput scalability with AppArmor enabled. For this use
> case we see refcount scalability problem when kref operations
> are done for AppArmor label object in Nginx worker's context. More
> details about this are captured @ [1] [2].
> 
> When we switch from kref to hazard pointer in apparmor_file_open(),
> we see ~7% improvement in Nginx throughput for this use case.
> 
> While we were working on this problem, this refcount scalability issue got
> resolved  recently with conditional ref acquisition [3] (however, there are new
> developments in apparmor code which might bring back the refcount problem [4]).
> 

The open/close thing is still serializing across different processes,
the slowdown just got lower. As in apparmor *as is* continues to be a
problem at big enough scale.

Per my messages in the area in the past, I'm confident this is fixable
with changing the refcount model to cache ref changes per-thread. I
employed this very scheme $elsewhere.

Since equivalent mechanism is applicable to creds this may want to be
implemented as something under lib/. I even started to work on it for
Linux, but real life got in the way and then I could not be arsed to
finish. 

It is a little reminiscenet of per-cpu refs. Here is the outline again:

kref usage gets replaced with a touple of { kref users; s64 refs; }

task_struct grows a pointer to the cached label and refs counter on it

when a new thread is created it bumps users and stores the pointer. on
destruction it decrements users and rolls up the local changes.
Similarly, if it turns out the label has to change during thread's
lifetime, the same thing happens.

In pseudo-code for apparmor_file_open():
	if (unlikely(current->aa_cached_label != check_label())) {
		/* do a replacement here */
	}
	/* just bump the local counter, no synchronisation with other
	 * cpus in the common case */
	current->aa_cached_label_refs++;

In apparmor_file_close():
	/* common case fast path */
	if (file->aa_label == current->aa_cached_label) {
		current->aa_cached_label_refs--;
		return;
	}
	/* we get here if apparmor got reconfigured or this is a file we
	 * inherited from another proc which had a different label and
	 * this is the last fput */
	kref_put(file->aa_label);

Conceptually there is almost nothing to see here.

As outlined above stale labels would clear themselves out as threads
open files. However, a thread which stubborly refuses to call allocate a
new file obj may hold on to a stale label indefinitely.

One way to sort it out:
I presume there is a spot somewhere in user<->kernel transition handling
which updates the credentials pointer, should it have changed.

$elsewhere I patched it up with a "cow" generation counter. If not
matching with the real task struct you know you need to take the fast
path and check creds, apparmor and whatever else. No extra branches in
the fast path, but a new int does have to be read. Given that
task_struct is a little bit of a cluster fuck I don't think it's a
problem.

That would be a rough sketch, anyone interested can fill in the details.
This still performs serializing atomics in *certain* cases, but avoids
them in almost all cases and there is nothing complicated about this
that I see, just some effort to implement.

So I don't believe patching up RCU with hazard pointers is warranted if
apparmor is the only justification.

Anyway no ETA from my end, anyone interested is free to take the idea or
do better.
