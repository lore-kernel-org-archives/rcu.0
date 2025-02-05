Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B51925A6
	for <rcu@vger.kernel.org>; Wed,  5 Feb 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771162; cv=none; b=PmtWjE3zmqYDCi7zpZ+YsOWuv7IT6FK62dzcNx57S3wqvPx6bPmyUxCVzFfUw5qejHhUMC1UhA/gwnkNe5kodR+FpG/Zz1fjdAHp+L8kNp8JYNbwLzLODmccsNk3kaFHDFVtM0t+YVym6IyPILhWMw70KiNZILeKq50EDqAuRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771162; c=relaxed/simple;
	bh=G4+CwfqKJpQd9P9lp9Jfs6xV3LIll9TZkWAKt6yxVKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB/DW3pRTKFo/BsD59GLCKp2WE25nR1+tNUcDyK2DKoPdvKaj/axfnQeel4K9EoR/dJablt+I5h3EymYj8Lpg0WP7Jf80zITuDhtLVghoR/PL0lGzqptPCFtV9uNtvypvYEP71AB+Er7/N7KiNzMSLVPRmgPDdFDbnK9UKhtOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=jY1KZByh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jY1KZByh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dba1cc632so100657f8f.0
        for <rcu@vger.kernel.org>; Wed, 05 Feb 2025 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738771159; x=1739375959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fNpoCq/DLdbV6EIEdUlFLaBZ3ROWUT1K+DDgwVCgqU=;
        b=jY1KZByhtoXpx/X0R72lvJnXB5kSXzlv3dFOlBGNkKUQgIGrgNM6z6rTX+7w1MoWYt
         eE/1HLvzsW86qHgCqm2VmALtlQWvRg0nOk8KHW0dgYRd/QnGXIeaps4ijagBx2E957Ww
         HtlHXJ1MCd8msmzI9WCaPynd/w6FGDlsPxt2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771159; x=1739375959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fNpoCq/DLdbV6EIEdUlFLaBZ3ROWUT1K+DDgwVCgqU=;
        b=X3Jg4wILAzWFv2t6bkL9x8ftu5Rx1YJUyA7QQmbml29JVsL9GsesrLKXgwphensS4P
         W+T0Wbm944Kudc0m0xGuGVoYBUA3HENhd2vdafJy6SUKLYsbM5Piy7d+GDzt3yV8JZ5f
         fCsvXCxVwLbbuIYjyfxvSXtpfaOppyvHGY+WLJ/m31bVaQ42hg1Z9BdVLAm6xV331mvz
         COx3sKPiQ3D79zZjkpZ0GfMxYCmbGgVId5TwvHi9tuT4GOHlz+WlI2tinT+ZsV1HSAzm
         S2mORkd9hczMESCEzSu7VsXn4Ggy3dTHriAnFvP4eD0aIk1CKmu/dxG4Hr+6J1Wfm9iR
         GOXg==
X-Forwarded-Encrypted: i=1; AJvYcCV/yg9PyOG0lrMtt8UTFWqe8ojE0Ho45K0cAgXRla3AFV5+C04XlTfXIQ0fw9hddt95Q1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaea328rsR+AslKRDcELJ0PNXWPaAv6Y1/6r1oNb9obNIE3MTo
	zzUU2KMk/st/+s6fucYQIVm0AWGih9nANtFrr1cKS7gcv7MrhIRPP+ifNyvauvmkaNIC5cdq6uh
	rkDvmofYFEV6w5cF/T9l23zzs3ouknmfZ4khhEA==
X-Gm-Gg: ASbGncsSzYs1arnYXFIR0P2WDUU+sfLYCcf1YNIiCIq/NsdRrwyvf3TZx7OpAEpAFvc
	W/lD/8jyzdbHw2ir3FbtXeAzSJxj2rfUkpDLlGU2EcsiuL7bsECBnkoJoeKV//QFpzBe5BnNi0F
	w=
X-Google-Smtp-Source: AGHT+IGHwraDJHYchdoFd+ZVOv3JlE8UmT6AZ6J415QO/yALdrm6zNrvEP8t9Zmmh9sH4vbmwS3QicXyspztB4i2Ne4=
X-Received: by 2002:a05:6000:156c:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-38db4858768mr2477305f8f.7.1738771158711; Wed, 05 Feb 2025
 07:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org> <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
 <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
 <ec293223-2a33-4d2f-b3ca-c011c3d987f3@paulmck-laptop> <CAEXW_YQXgZANSjo835VfHMqY=z8gaSWQ2bgaWtVd4-3KX0hX8w@mail.gmail.com>
 <999751de-b891-424d-a7b5-80bfa98793ff@paulmck-laptop> <CAEXW_YT6bD=sAD77yg+BXC+Q0NW0RHCg6fEYZ_jsBeXkAd_1tg@mail.gmail.com>
 <e23ab8d2-1a64-458b-a83d-eabcf92a2382@paulmck-laptop> <CAEXW_YSFtF=Vx2P73m0tdfAYgSui-KSzGnyqiTY1rwOfWfFycA@mail.gmail.com>
 <87f074af-a39c-48db-972f-5f46e57aa3db@paulmck-laptop>
In-Reply-To: <87f074af-a39c-48db-972f-5f46e57aa3db@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 5 Feb 2025 10:59:07 -0500
X-Gm-Features: AWEUYZlU6SdSFTsqKWqPoMuqnVZat79mVVDbDxIvAz6VGoI4LllI0lOmkx7SFIs
Message-ID: <CAEXW_YTeDRQ=mAUKYpgxYjsHooX=C3cJwTkMi6XqcE_7Ne+zDw@mail.gmail.com>
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 10:56=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Feb 05, 2025 at 10:45:08AM -0500, Joel Fernandes wrote:
> > On Wed, Feb 5, 2025 at 5:28=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > On Tue, Feb 04, 2025 at 08:28:29PM -0500, Joel Fernandes wrote:
> > > > On Tue, Feb 4, 2025 at 3:22=E2=80=AFPM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > >
> > > > > On Tue, Feb 04, 2025 at 10:44:45AM -0500, Joel Fernandes wrote:
> > > > > > On Thu, Jan 30, 2025 at 12:56=E2=80=AFAM Paul E. McKenney <paul=
mck@kernel.org> wrote:
> > > > > > > By "where we were initially", one might reasonably guess that=
 you meant
> > > > > > > that the initial value and the target are one and the same.  =
But I suspect
> > > > > > > that you are thinking of a third value, the value of the unde=
rlying
> > > > > > > grace-period sequence number at the time of the call to rcu_s=
eq_snap().
> > > > > > > But you might be thinking of something else entirely.
> > > > > > >
> > > > > > > > Now we move rcu_seq_done_exact. It has the exact same behav=
ior except
> > > > > > > > that instead of ULONG_MAX/2, the above situations are shrun=
k to about
> > > > > > > > 10 counts from the target. So if target is 28, then the ini=
tial
> > > > > > > > sequence should have been at least 18 to avoid false-positi=
ve, but
> > > > > > > > again it is possible and I certain see in the code that it =
cannot be
> > > > > > > > used this way.. (at least so far).. So all we are left with=
 is the
> > > > > > > > false-negative band of ~2.5 GPs..
> > > > > > >
> > > > > > > Here, I have the same questions.  As you no doubt guessed.
> > > > > > >
> > > > > > > > About "what are the consequences of failing to get this rig=
ht".  I
> > > > > > > > believe false-positive is unacceptable unless it is maybe d=
ebug code -
> > > > > > > > that can break functionality in code, too short GPs and all=
 that.
> > > > > > > > However false-negative is OK as long as the usecase can ret=
ry later
> > > > > > > > and can afford to wait. Did I get that much correct?
> > > > > > >
> > > > > > > Maybe?
> > > > > > >
> > > > > > > Please look at this on a per-use-case basis.
> > > > > >
> > > > > > Sure. FWIW, I started a world-editable document here. I am plan=
ning to
> > > > > > work on this a bit more before our meeting this week. If others
> > > > > > knowledgeable like Frederic and others could make edits/comment=
s,
> > > > > > that'd be welcomed. But I basically summarized this whole threa=
d here:
> > > > > > https://docs.google.com/document/d/1sFNuGH4U6DFCE8sunbdWMjFhJhb=
1aG4goOJAnS6c6gQ/edit?usp=3Dsharing
> > > > > >
> > > > > > My thought is (AFAICS), this patch is still valid and
> > > > > > rcu_seq_done_exact is a potentially better replacement to
> > > > > > rcu_seq_done. But famous last words...
> > > > >
> > > > > Let's start with the use case where the sequence number is being =
used
> > > > > by rcu_barrier().  What happens?
> > > >
> > > > The rcu_state.barrier_sequence is used to keep track of barrier in
> > > > progress, as there can be concurrent rcu_barrier() calls happening =
so
> > > > we optimize by batching multiples of these calls.
> > > >
> > > > It also handles the case where the entrain IPI came through but no
> > > > rcu_barrier() is currently in-flight (which would be weird but mayb=
e
> > > > it happens somehow).
> > > >
> > > > It is also used to make sure we don't need to entrain on a CPU agai=
n
> > > > if we already did an entraining for a certain rcu_barrier() invocat=
ion
> > > > already. This is tracked by rdp->barrier_seq_snap which copies the
> > > > value of rcu_state.barrier_sequence after the entraining. Al though=
 I
> > > > am currently unable to envision why the IPI handler would be called
> > > > unnecessarily (hardware bug?) since we hold the rcu_barrier mutex
> > > > throughout the rcu_barrier() function, including while waiting on
> > > > CPUs.
> > > >
> > > > Going back to my first point, for the rcu_seq_done() in rcu_barrier=
(),
> > > > we are checking if someone else did our work:
> > > >     mutex_lock(&rcu_state.barrier_mutex);
> > > >     /* Did someone else do our work for us? */
> > > >     if (rcu_seq_done(&rcu_state.barrier_sequence, s))
> > > >
> > > > Here I think rcu_seq_done_exact() is better, because if too many
> > > > rcu_barrier() calls concurrently made at the same time, the mutex m=
ay
> > > > be contended. If enough time passes and we have a wrap around, we
> > > > might end up in false-negative land which is much larger with
> > > > rcu_seq_done() than ..done_exact(). However, that does seem to be a
> > > > bug to begin with if the mutex contended for that long. OTOH, doing=
 an
> > > > rcu_barrier() again when we didn't need to doesn't seem like the en=
d
> > > > of the world especially if we contended on the mutex for that long.
> > > > But at least it shows that rcu_seq_done_exact() cannot seem to hurt
> > > > here.
> > > >
> > > > Hmmm,
> > >
> > > So...  Do we really care about the difference between rcu_seq_done()
> > > and rcu_seq_done_exact() in the rcu_barrier() case?
> >
> > In so far as to get rid of rcu_seq_done() API in favor of using
> > rcu_seq_done_exact() but should not cause any functional or robustness
> > changes to rcu_barrier() at least, AFAICS.
>
> OK, *that* I might be able to get behind.  ;-)

Great! So I guess I will continue down the rabbit hole then with the
other users and cross my T's / dot my I's for this patch. Very least,
I am (re-)learning about all these use cases so thank you! ;-)

 - Joel
