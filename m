Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D554F8C
	for <rcu@vger.kernel.org>; Wed, 29 Jan 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738113774; cv=none; b=BibbLxZVQapbFpxjsT7GHrkYoWD2YIV+Dqc2kWyi8iQd9Px5wK67VHTOQf7tDOfw4aPqdZOPQiSu10xGfANAVRTnbh0bqLqMfOUNvHo66Qg9o7McL0obVcF56yHP2+aNVr08s/svolbnbevKZMoNdz0rSGNP0mEzNocolxpYv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738113774; c=relaxed/simple;
	bh=RFiXlHg9TdroTux1pmPbCO2VdYEj7tYaixM6R7ukqOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qViEQcvGiBjsJK5oQm10nQEV+gentHgrROI2YM9J1x0lVnBZh9fDAsTkJKWE41UDwEKaPC2ETd4rCl8a8goQSNZGThVl/T0+qcD3PEbXd5XuLng1K4MJZbDhkLUsmVgxHGe4vx9qNbKda5SNwEMasTnOyfKNuEpy7rVYTvlGHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=jVyQx+UH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jVyQx+UH"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467725245a2so61219101cf.3
        for <rcu@vger.kernel.org>; Tue, 28 Jan 2025 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738113771; x=1738718571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NbnlNZzDyhCA/GeWsSkfmRY9QJ9GI+IeHzK0RWLJSdI=;
        b=jVyQx+UH8xkQoCT58XDu/ze2PjmjTEGXkdIx3cM9zbTCtJiySFrIkA5nq3hB4GiuZt
         HtGnqTCuxKSzvnCN/fiMw3GBfNtZXEh9wi1GYfra2r57t7StOeIiDMTvCUrUR8cJWOpr
         Zr50fn4zbFCfc45P5B1ss6EVzABIidzNKhkYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738113771; x=1738718571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbnlNZzDyhCA/GeWsSkfmRY9QJ9GI+IeHzK0RWLJSdI=;
        b=EkPRFoE31HKqDxPERJKFHKt/aoHLXZWAKQwz4cWTg+rHSl5mFUtpAT2Z21h+Y3rXzf
         3XzKe+Qf5YVx5SBwaCUEa7Z2gfZnI7SvJ+2HWFlWDvPgGDaVQyHL0w0hPMAYfd67UGw0
         Ql5fbXb+RTpSJVvqGPdyPvOTK3+3k6nA7wDH7OnDFa2MW2nlCAkAq2CnKZTTDXMIFIP2
         3lZL/y453MmsVF2Mdtka0kkx3RMpPQy4DE1JaoOPOWyWFRNpXKthfSFOuAcI/bDZN51t
         3AkmmNgj+IiM8wtJeDQItVZAAN7wk3Wk7J/+XgUvH3kWNsVZN9x+UXLaBQU6Z+TxNY/F
         fD3A==
X-Gm-Message-State: AOJu0YzcIAFrfPlO8IdU2+Y/hC1nWSxhc2feFA75eFYIGTeh6Drjlrml
	H8l9gr3okp7YM898N9gQ39E0wqzWiu3PrtzzkHf3c92Q5MkDcl3hzjIrUNR4gO4=
X-Gm-Gg: ASbGnctxtyRt5yMF6nolYTQYalh52S6bT0YPqrIxChJlKpwWJEwvVXXLPAzJi+SQOld
	82e5zornyqBuFcMlUgzyV3MTPP+UVLqG88UhD8z8fhiKRUKmtU00R3GpFuqyH1dzbSWGBn8jo0S
	WMyb87n1lqZcY/a07JPa2DToLwpbuOAKIK2cWdIzj24r/w4khXjwick839LsKukNvdTtSRJZd35
	HSAvhFoDTAJhDRrklMl/f4XbjL48yoWQYTqIbAYPmX1hIFKH6Ht4al9Lq6CeYfHOrEWK1Uw9OIM
	R6mQPej67M6Tamhm55JO4cgj2lMF2z3D2fvnTe00x68pQNm2RwOMiHp7
X-Google-Smtp-Source: AGHT+IEBrcDXE1UVyu0W06dI0PpXXnamG4AuyiIPU9heNW0rLWcGO+8lwFyOZup0RSt1Xri9ad1HAQ==
X-Received: by 2002:ac8:588a:0:b0:467:4fc5:9d71 with SMTP id d75a77b69052e-46fd0a8aec7mr28612131cf.28.1738113771134;
        Tue, 28 Jan 2025 17:22:51 -0800 (PST)
Received: from localhost (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6689d8a9sm57376511cf.33.2025.01.28.17.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 17:22:49 -0800 (PST)
Date: Tue, 28 Jan 2025 20:22:48 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Message-ID: <20250129012248.GA3853708@joelbox2>
References: <20250128000737.1264218-1-joel@joelfernandes.org>
 <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>

On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> On Mon, Jan 27, 2025 at 7:07 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > The rcu_seq_done() API has a large "false-negative" windows of size
> > ULONG_MAX/2, where after wrap around, it is possible that it will think
> > that a GP has not completed if a wrap around happens and the delta is
> > large.
> >
> > rcu_seq_done_exact() is more accurate avoiding this wrap around issue,
> > by making the window of false-negativity by only 3 GPs. Use this logic
> > for rcu_seq_done() which is a nice negative code delta and could
> > potentially avoid issues in the future where rcu_seq_done() was
> > reporting false-negatives for too long.
> >
> > rcutorture runs of all scenarios for 15 minutes passed. Code inspection
> > was done of all users to convince the change would work.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I am leaving a 60 minute overnight run of all scenarios on my personal
> server for further testing.

The run passed, details below:

 --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
Results directory:
tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60
RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total-gps=57880] n_max_cbs: 0
SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=79242] n_max_cbs: 150000
SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gps=460117] n_max_cbs: 150000
SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=80299] n_max_cbs: 150000
SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gps=1035602] n_max_cbs: 50000
SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-gps=988459] n_max_cbs: 50000
SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-gps=1092927] n_max_cbs: 1000
TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=57808]
TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=57936]
TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=57508]
TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 57078
TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 2619
TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 total-gps=45844] n_max_cbs: 50000
TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0 total-gps=305456] n_max_cbs: 100000
TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=120151]
TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=365162] n_max_cbs: 1139244
TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=441393] n_max_cbs: 1341765
TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=238225] n_max_cbs: 236765
TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=308880] n_max_cbs: 82801
TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=52094]
TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=1923688] n_max_cbs: 1845334
 --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0

thanks,

 - Joel


> 
> thanks,
> 
>  - Joel
> 
> 
> 
> 
> > ---
> >  kernel/rcu/rcu.h  | 13 ++-----------
> >  kernel/rcu/tree.c |  6 +++---
> >  2 files changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index eed2951a4962..c2ca196907cb 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned long *sp, unsigned long s)
> >
> >  /*
> >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > - * full update-side operation has occurred.
> > + * full update-side operation has occurred while also handling
> > + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard-band.
> >   */
> >  static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
> > -{
> > -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
> > -}
> > -
> > -/*
> > - * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > - * full update-side operation has occurred, but do not allow the
> > - * (ULONG_MAX / 2) safety-factor/guard-band.
> > - */
> > -static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> >  {
> >         unsigned long cur_s = READ_ONCE(*sp);
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b77ccc55557b..835600cec9ba 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
> >  bool poll_state_synchronize_rcu(unsigned long oldstate)
> >  {
> >         if (oldstate == RCU_GET_STATE_COMPLETED ||
> > -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
> > +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
> >                 smp_mb(); /* Ensure GP ends before subsequent accesses. */
> >                 return true;
> >         }
> > @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
> >
> >         smp_mb(); // Order against root rcu_node structure grace-period cleanup.
> >         if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
> > -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
> > +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
> >             rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
> > -           rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
> > +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
> >                 smp_mb(); /* Ensure GP ends before subsequent accesses. */
> >                 return true;
> >         }
> > --
> > 2.34.1
> >
