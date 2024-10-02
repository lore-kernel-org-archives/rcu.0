Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDA1D1E80
	for <rcu@vger.kernel.org>; Wed,  2 Oct 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878481; cv=none; b=j7Q9PQDNu7vJeCLrEkxGJjMmrd6jHdSctqqFEpKpF+lyCZoX/bognDmHfgTu62POYY8hlNIYpo0/TxbtfgSztfbfh15ZUm9XbefgKZpDQFb1TrT+hWuUld6waCQ71Mu6/87t1rg3cFV2Mn9N2DU5q3kST9MxXxnGT9eTuNNevPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878481; c=relaxed/simple;
	bh=WBAUpTaKdB4RW11P9FLvKgOiuB21+jV8Nzn/f9ShX0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5wgGNAFFgD2E6xVC7/+4xJLSIvXPNDiyuHnQHdn/sBHu0XOur3NU5/U6MJDaRYDKXr753LK3UJ39LP0e6wU7R/jlaOSyDxKg3iPtCj2seje49OW4m22zYyPJdw4jms44e/FXXgysi87XyZTYmqwX9wW6mS3n8aT1vNOwjc6EI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LGC8I5lr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LGC8I5lr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9ad8a7c63so675056785a.3
        for <rcu@vger.kernel.org>; Wed, 02 Oct 2024 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727878479; x=1728483279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ/povkWh1vgNmBfuGLgKT44hfzyi9J+3u5A1F7slgc=;
        b=LGC8I5lr0FCdySRPbBwVFLpdqCs2OxD8aC1t2WlAg80DdkEEIvVAyefHslUFgBkxyC
         l9LtpNDaxkXpnJEcGjTEMU379gafQWTWiNNwjKFNP8Le21kDGu5svKqD1/wLRN4sx7E+
         HbeCydYXDbjWjYiHS3gdsrhSwBgm2QtrX4HJ4nmsMQLbtTfHFJPC1+QjgbSO4atadi8S
         p/EEoucvC8M+tByPVLrZXpPzP17hcAnQhwLdmfImg9i4YUmVhCVnFoy99MEgiUAGPIbY
         M1E48tiLaP81aXr5d1m/b8JlgaBpUOHVRzXEv39Uj3c+wgcHbVye4BnqpcL8DszlT9nN
         Qvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878479; x=1728483279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ/povkWh1vgNmBfuGLgKT44hfzyi9J+3u5A1F7slgc=;
        b=Xc82vWj7jipn9Viw/qV5P+Ay80Tpoht8wrmhRBiLOuj8m2c75Dwb2/Y5Yf8Mh1lxV9
         CxK0P6waYpR77f+ZY/W7r4cTzOvEI9atoAVuMUAWDul76gmROMl3JW9yaXPrXPbjgEhy
         CBsLOB88jMfOvSNMl/hdvjdtSvGRA6C1p140EQqPhnCNa0peXWp+12V05NFYe7lep3xL
         TLUQr9V1Mzf5UBZH+hLXE2Or5b2fXDbMnqN9JyI41IL+LcEknqfmSSlNqCthoGbO+TIT
         Jgn5fS/tSR0segxL7plxe8uUfs9Tj+yfeGsWKU94UQFdO/6NlizhE41yvsLySss/LM8T
         KZzg==
X-Forwarded-Encrypted: i=1; AJvYcCVob49MsqMeZWGTFvoUE13s+j1GcsvdxEOFuSLMZmrKmVJFIUrTYBeIZp7ct2oZNqnwFA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDiZ4nxZsx59VYmsZwVaynyt+pxxL2A5K819bke9H2CEu+FCdU
	8pYLrqL7A68N3eKIE0BbsUmlSV2WyrsPpaRGm7oB6cgDVg3myHFChobUxYRFqg==
X-Google-Smtp-Source: AGHT+IG/o8TFevNqXUuDX3vJqZ8KPl51exlwA0PQIaotbs7GdJJp0vmE7UIcGFQNu+8WwPq2nynC8Q==
X-Received: by 2002:a05:620a:bc6:b0:7a9:b4d2:9d70 with SMTP id af79cd13be357-7ae626bdc64mr557972185a.14.1727878478749;
        Wed, 02 Oct 2024 07:14:38 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::1a9d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377f09bcsm616133885a.65.2024.10.02.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:14:38 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:14:33 -0400
From: 'Alan Stern' <stern@rowland.harvard.edu>
To: David Laight <David.Laight@aculab.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"maged.michael@gmail.com" <maged.michael@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lkmm@lists.linux.dev" <lkmm@lists.linux.dev>
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <d192cf63-a274-4721-968e-a2c098db523b@rowland.harvard.edu>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <9539c551-5c91-42db-8ac1-cff1d6d7c293@huaweicloud.com>
 <2cdda043-1ad9-40cf-a157-0c16a0ffb046@rowland.harvard.edu>
 <5d7d8a59-57f5-4125-95bb-fda9c193b9cf@huaweicloud.com>
 <82e97ad5-17ad-418d-8791-22297acc7af4@rowland.harvard.edu>
 <ea02ce2ce8a348efa8d461f84f976478@AcuMS.aculab.com>
 <2b1caba3-48fa-43b9-bd44-cf60b9a141d7@rowland.harvard.edu>
 <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22638e2fe1274eb0834fa3e43b44184e@AcuMS.aculab.com>

On Wed, Oct 02, 2024 at 08:13:15AM +0000, David Laight wrote:
> From: 'Alan Stern'
> > Sent: 01 October 2024 23:57
> > 
> > On Tue, Oct 01, 2024 at 05:11:05PM +0000, David Laight wrote:
> > > From: Alan Stern
> > > > Sent: 30 September 2024 19:53
> > > >
> > > > On Mon, Sep 30, 2024 at 07:05:06PM +0200, Jonas Oberhauser wrote:
> > > > >
> > > > >
> > > > > Am 9/30/2024 um 6:43 PM schrieb Alan Stern:
> > > > > > On Mon, Sep 30, 2024 at 01:26:53PM +0200, Jonas Oberhauser wrote:
> > > > > > >
> > > > > > >
> > > > > > > Am 9/28/2024 um 4:49 PM schrieb Alan Stern:
> > > > > > >
> > > > > > > I should also point out that it is not enough to prevent the compiler from
> > > > > > > using @a instead of @b.
> > > > > > >
> > > > > > > It must also be prevented from assigning @b=@a, which it is often allowed to
> > > > > > > do after finding @a==@b.
> > > > > >
> > > > > > Wouldn't that be a bug?
> > > > >
> > > > > That's why I said that it is often allowed to do it. In your case it
> > > > > wouldn't, but it is often possible when a and b are non-atomic &
> > > > > non-volatile (and haven't escaped, and I believe sometimes even then).
> > > > >
> > > > > It happens for example here with GCC 14.1.0 -O3:
> > > > >
> > > > > int fct_hide(void)
> > > > > {
> > > > >     int *a, *b;
> > > > >
> > > > >     do {
> > > > >         a = READ_ONCE(p);
> > > > >         asm volatile ("" : : : "memory");
> > > > >         b = READ_ONCE(p);
> > > > >     } while (a != b);
> > > > >     OPTIMIZER_HIDE_VAR(b);
> > > > >     return *b;
> > > > > }
> > > > >
> > > > >
> > > > >
> > > > >         ldr     r1, [r2]
> > > > >         ldr     r3, [r2]
> > > > >         cmp     r1, r3
> > > > >         bne     .L6
> > > > >         mov     r3, r1   // nay...
> > > >
> > > > A totally unnecessary instruction, which accomplishes nothing other than
> > > > to waste time, space, and energy.  But nonetheless, allowed -- I agree.
> > > >
> > > > The people in charge of GCC's optimizer might like to hear about this,
> > > > if they're not already aware of it...
> > > >
> > > > >         ldr     r0, [r3] // yay!
> > > > >         bx      lr
> > > >
> > > > One could argue that in this example the compiler _has_ used *a instead
> > > > of *b.  However, such an argument would have more force if we had
> > > > described what we are talking about more precisely.
> > >
> > > The 'mov r3, r1' has nothing to do with 'a'.
> > 
> > What do you mean by that?  At this point in the program, a is the
> > variable whose value is stored in r1 and b is the variable whose value
> > is stored in r3.  "mov r3, r1" copies the value from r1 into r3 and is
> > therefore equivalent to executing "b = a".  (That is why I said one
> > could argue that the "return *b" statement uses the value of *a.)  Thus
> > it very much does have something to do with "a".
> 
> After the cmp and bne r1 and r3 have the same value.
> The compiler tracks that and will use either register later.
> That can never matter.

The whole point of this thread is that sometimes it _does_ matter.  Not 
on x86, but on weakly ordered architectures where using the wrong 
register will bypass a dependency and allow the CPU to speculatively 
load values earlier than the programmer wants it to.

> Remember the compiler tracks values (in pseudo/internal registers)
> not variables.
> 
> > > It is a more general problem that OPTIMISER_HIDE_VAR() pretty much
> > > always ends up allocating a different internal 'register' for the
> > > output and then allocating a separate physical rehgister.
> > 
> > What output are you referring to?  Does OPTIMISER_HIDE_VAR() have an
> > output?  If it does, the source program above ignores it, discarding any
> > returned value.
> 
> Look up OPTIMISER_HIDE_VAR(x) it basically x = f(x) where f() is
> the identity operation:
> 	asm ("" : "+r"(x))
> I'll bet that gcc allocates a separate internal/pseudo register
> for the result so wants to do y = f(x).
> Probably generating y = x; y = f(y);
> (The 'mov' might be after the asm, but I think that would get
> optimised away - the listing file might help.)
> 
> So here the compiler has just decided to reuse the register that
> held the other of a/b for the extra temporary.

I think you've got this backward.  As mentioned above, a is originally 
in r1 and b is in r3.  The source says OPTIMIZER_HIDE_VAR(b), so you're 
saying that gcc should be copying r3 into a separate internal/pseudo 
register.  But instead it's copying r1.

Alan
