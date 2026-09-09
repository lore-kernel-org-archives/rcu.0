Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73921342523
	for <rcu@vger.kernel.org>; Wed,  9 Sep 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922988; cv=none; b=f0y6HWocB623XbEQEzWfrl+30xooU8/3GIuNbFJbHizsTIqLXvnrqIfI9+lrTQCDOln1c3DaeHmgHcmsgGEJnp5rXYa9Z8Edn2/tpUrx7vSPjafUMdKUwYf+MGgLYRTO+tJbn1s/PhsqjFnrNXJVwMbdw4QX19xTIe7qW3eyJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922988; c=relaxed/simple;
	bh=BQPBkN/NqtCyjwb9SYHUTxuMckVrHcmWQ71eKEec9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQexS1w7D/O6qN6gtTFRQTCxPz1SglyxUk/Catlh2sVveibAaGubAo737D4JuKq+YPXhTExqG5wO9JEpOJgwgvDl5ntUKLfMat4iFLlruTDxHI48EAa7NF5aLuTRd4ONGn3b0wFWd8nbCOt1cOqsqeLYFYjz1a1u0sbRHiN38hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpb33DJ/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpb33DJ/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487214ad2bso5353801b3a.1
        for <rcu@vger.kernel.org>; Tue, 08 Sep 2026 20:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922986; x=1789527786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATaIDw9EojrgfvEMDnK/O8s2Q0MxvIMBvw5QrxeuLQc=;
        b=qpb33DJ/u8DSJ2iOpq0pTnq4OM9MceIsUTpEsnA/b/qOSXO0BVL2Ghin3J2AG6Te0C
         MDkD+o4H8P8WEnCE/Ac71QWld+lvArYmujkvVSaf5ttEW9haumrPPXOaatU2T0yNB9cP
         WVSxfzrpfASVb/f+4OPkzcH+BW0SaxiZyWIafOS0A8LphKRW9Vn4SbkQru8g9+V5mrI7
         BpIsEYRsOKBCfWgdmUebqrQq93MDAA101Z0apQUwYJFTZZberK9PXbnkFLak8cmFJxVN
         dYR/nzfWLy1cgYTeu4kMabvAU2hKC5R5GZ87FbCqqW0/XulTi4+Rl4eRKAfbAosSBVN4
         Fqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922986; x=1789527786;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATaIDw9EojrgfvEMDnK/O8s2Q0MxvIMBvw5QrxeuLQc=;
        b=mcn2J0DoHTLT9hE/CP4tphYEnCtokoXxK/jLK4Oxs3hZEQ45fM4tne5v8di2GI1+p3
         GM+wa9h9ujngutKAi+H04dbV722I89bcSPCP/+2mH2/nFsznyOVHs1AWDtEQDXxzEVMa
         CDMJjKg3jA1NpaQD+xcL3+v66huLN425UKlw37YFgkA0/ClwfpvuTlvSCEvr+Qax9UIb
         kObwYT+vItB0FMiEzTyq+Dr2mIUxUUNcHguXMVGXWI3CMEaldLg10aOZrx1a5p3lN78d
         SOIcj3svYsKl3v6/9aBZJlhyAi+aq+AbnqVEdovQHBFK/VAuYXsoAn7R2mco/xy9xUq/
         JIxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwYgjUlqSJ+Nw7yBDv1djEg21H3gE8fWDhnW+AhH9LNvWFrTjISrnJYpWedQniGxDo3Qs=@vger.kernel.org
X-Gm-Message-State: AFuF++k0ou5RqPCXbOnN4+DwKFGDY5ZTQ6tjhSq9Dn6yi37cj7S1qji8
	Xp+D28YKUie6kvkO69OXrNREZ+OclaVF10C4m8Tlo+11l0oS8JiP1tJQ
X-Gm-Gg: AYBFou1erqDHgI8FMmHPjbBoxfWNbJtUL7UbbNWnr5lIC2sargf9mItPMhROuEirA49
	050trnluS6JiouaQbTMST2Dk9dVEESTC/vC7XYP0k2YMjxYsfJs06XxPepKEj1sWkhLlFveI4An
	enC5092ihkGpNdpOFk1sDaS/7VZSbxra5kozDbXobXCICxRDVra+IIrg6fZfXIjyf3GyV11CfJ+
	XsCeHZ7K3OM18FkilT0St3sWHltc69EWp/xF/ElexkYDtlZ00sIM6/GhFItMi5c8lXErhaPNIlO
	WS3Vhti3sUhKxFT1AaeTtl3p0AQ+bQQNYARTPgui8AaSOto1aAGzJqWLiCpHLOQreqPT1Eh//Vm
	Cz1JHYi63cGtQiM4YdQvAnpgGhTCOVQxPZkkn7RMMDYms56kqejGeRgSDDe3LhjcJSFmt08edr5
	MS4Gej/8jPmFm0Qth/pRa5WaLlmt8G2fZCcQ2GOgoHhYPBfh6gWsjQdQ05iGi0ySzsgm/Yg4Rsg
	CU4qiNB
X-Received: by 2002:a05:6a21:6f10:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3da39d18e07mr49039314637.4.1788922984939;
        Tue, 08 Sep 2026 20:03:04 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152045f8bsm6475253b3a.15.2026.09.08.20.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 20:03:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] litmus: Add SRCU fastpath anchor-before-scan test
Date: Wed,  9 Sep 2026 11:02:51 +0800
Message-ID: <20260909030253.2430897-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <35d6d803-41d9-48d6-a8d0-b8d0f6f67efd@paulmck-laptop>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 8 Sep 2026 16:58:31 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Sep 07, 2026 at 03:58:17PM +0800, Kunwu Chan wrote:
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> > 
> > synchronize_srcu_atomic() may end its grace period immediately when
> > its scan of the per-CPU lock counters finds no readers.  Correctness
> > requires the grace-period anchor written by srcu_gp_start() to precede
> > the smp_mb() ordering the lock scan.  This ordering ensures that any
> > reader whose lock increment is missed by the scan cannot have
> > incremented its lock counter before the grace-period anchor, and
> > therefore cannot be a pre-existing reader of this grace period.
> > 
> > This litmus test models the key ordering between the grace-period
> > anchor and the lock counter scan, where "seq" models the
> > grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > smp_mb() and the lock scan.  P1 models the reader-side counter
> > increment, with the smp_mb() of __srcu_read_lock() following the
> > increment.  P2 models an observer that sees the reader's increment
> > before seeing the anchor.
> > 
> > The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > which permits this outcome.
> > 
> > Tested with herd7 7.58 using linux-kernel.cfg.
> > 
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Litmus tests!  Very nice!!!  
> 
> Could you please put both of these in Documentation/litmus-tests, in a
> new "srcu" subdirectory?
> 
> One thing for your consideration is use of the "filter" clause for the
> first term of your "exists" clause.  Not a big deal at all for this small
> of a litmus test, but the idea is that this litmus test only cares about
> the 0:r2=0 case:  If that condition does not hold, then P0() and P1()
> aren't the beginning and end of a valid SRCU read-side critical section.
> 
> Use of the "filter" allows herd7 to abandon a given execution early,
> so it is a big deal for larger litmus tests.
> 
> Again, what you have is fine (or will be when moved to the other
> directory), just pointing out the additional feature.
> 
> If you would like to see a use case, please see:
> 
> Documentation/litmus-tests/locking/RM-fixed.litmus

Thanks, Paul.
I’ll move both tests to Documentation/litmus-tests/srcu/ and use a "filter" 
clause for the first test as suggested.

I’ll send the two litmus tests as a separate follow-up series, so this won’t 
hold up the current atomic SRCU series.
I’d also like to continue maintaining the SRCU litmus tests as they evolve. 
If you think a MAINTAINERS entry for the SRCU litmus tests would be appropriate, 
I’d be happy to prepare that as well.

Thanks,
KunWu

> 
> 							Thanx, Paul
> 
> > ---
> >  .../SRCU-fastpath-anchor-before-scan.litmus   | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > new file mode 100644
> > index 000000000000..8200a75e15ef
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/SRCU-fastpath-anchor-before-scan.litmus
> > @@ -0,0 +1,56 @@
> > +C SRCU-fastpath-anchor-before-scan
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * The synchronize_srcu_atomic() fastpath may end its grace period
> > + * immediately when its scan of the per-CPU lock counters finds no
> > + * readers.  Correctness requires the grace-period anchor written by
> > + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> > + * This ordering ensures that any reader whose lock increment is missed
> > + * by the scan cannot have incremented its lock counter before the
> > + * grace-period anchor, and therefore cannot be a pre-existing reader
> > + * of this grace period.
> > + *
> > + * This litmus test models the key ordering between the grace-period
> > + * anchor and the lock counter scan, where "seq" models the
> > + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > + * smp_mb() and the lock scan.  P1 models the reader-side counter
> > + * increment, with the smp_mb() of __srcu_read_lock() following the
> > + * increment.  P2 models an observer that sees the reader's increment
> > + * before seeing the anchor.
> > + *
> > + * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > + * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > + * which permits this outcome.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *seq, int *ctr)
> > +{
> > +	int r2;
> > +
> > +	WRITE_ONCE(*seq, 1);
> > +	smp_mb();
> > +	r2 = READ_ONCE(*ctr);
> > +}
> > +
> > +P1(int *ctr)
> > +{
> > +	WRITE_ONCE(*ctr, 1);
> > +	smp_mb();
> > +}
> > +
> > +P2(int *seq, int *ctr)
> > +{
> > +	int r3;
> > +	int r4;
> > +
> > +	r3 = READ_ONCE(*ctr);
> > +	smp_mb();
> > +	r4 = READ_ONCE(*seq);
> > +}
> > +
> > +exists (0:r2 = 0 /\ 2:r3 = 1 /\ 2:r4 = 0)
> > -- 
> > 2.43.0
> > 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
