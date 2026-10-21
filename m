Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573622;
	b=qcEIRnWpUGG/9e5alDooChC35k+mcNvwyJ7IdhiUewuV+sPWzcUvq6q2Vm+plPP2cBFu
	 GNOLEz1erksW91ibzQnfmAZ2g+o1exYVDT6+zMzRzYpYc1Kq+shYNpHAyAPOUWXPDDn3j
	 DUC95jqxOqfzOr1tSxxTiq5V5U55CFSfsBP56wgk8R+QFvqEpIdE4gRYwJNAJb5uoURz1
	 fUbonaGio85UFgXtwl4k9vMWznOJcmV4oM5kYbiY5g5OIlP44w0bbRnMBF1vAPWzp7vlB
	 f2J1ExG4vwcqbC90dPEuzCS7kb8Qri/ZSEvQJpQEah2SzHf/BNrWr0xPp9oP24+5Hsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rLVfg9ErNOee48O9lnXUz0AflcGEv9NaDJ2S46e/6zg=;
	b=hoSFScrTHIU26dmMplO5SsFT3+XNVHwaE+sfzCU/6eDlqjCSKiKh0yAXxAR/qxwZe3h2
	 Lp9IJhxMryUQrdJTvsxMoYH3aC/eoHKjiJ34EKjePvyMNZ27urkah3I97q5KYcA/JFYbS
	 yH+tjgM86Zhryle5dDZ/cPfqtkBAsg4v4+1oybIfNixZOwGhdRzgTSPcSHUUx0df/LiGS
	 WQOaotxNJVxiu0POtXdaGo0gEm6ZUt/yemNXne4jA5eAIKUgeadGBiNWbvJ13DPpy9Y+m
	 i3LMw3ojd1BV7Z44yHDDyVHY8Mz7qfbspTs4U8RBYxMOxu/xJZtXjXNGwzmShYj+wIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmaluNyX;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF46606A31A
	for <rcu@vger.kernel.org>; Wed, 21 Oct 2026 09:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF46606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MmaluNyX
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso3455075e9.2
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2026 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792573620; x=1793178420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rLVfg9ErNOee48O9lnXUz0AflcGEv9NaDJ2S46e/6zg=;
        b=MmaluNyXBeOxDQPT+Syg3TI5+nimVLhp94T4I9JExxUquckJDUZoLM6XZYVouYUHs2
         Zgs2g8VE4r8ydHhEzjbvvSYkyN+z0Zedl1XuDJNU6vUxVLKLJIYMK9HG1BVmkS2YZTB9
         wXxN+iy4H5xJoHwu5CgECZCpw58GHia8IseqM5lsO8fZ0dUL2SdXSEB8meOAEkkcLRpH
         0KpDo8bcOHjAgt11aPPoLLHIp/GndtXGxUuqZUcn3hml+ZZoSqgcaMcMRXKd9okbr1Ic
         J7AYwU/AvD9v1zMt8pTErk1pcm7553ROXGF3p0v/sT4UFdYXfAyUIZ9XR/m2bpPqWr0B
         w3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573620; x=1793178420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rLVfg9ErNOee48O9lnXUz0AflcGEv9NaDJ2S46e/6zg=;
        b=cB73JHV+MHJFvYoSX2inXLzOJub3Xn5GzqMfBeZ5JQmQEfl75qEHDLk66obi7A/2HR
         zfBSHg4rXGiPGwAOM9fDEu4R1hqJ43UU21+O+nnSMhaXZTM1ihulANbiTrYTbwAlCjkf
         7uGoeXcEGZ6etgiIzCO4EcHrQgoPZeUyLeFpuFLtdbycJTEAuqo44G3KG7RBnxOMYtm9
         CsZR9n21J+YoH5n06ot5HS5muhOGPYvOW4JQeYvhZWkjHW/lMW3uMf1Ho+aW2rZQ9xiB
         AdsD92UJOvD2vIQeOgZoKF6hfXV6yk/p648YWJgE+pHSWy9yrqRIh1SLt320CWOjJ+0A
         J9nw==
X-Forwarded-Encrypted: i=1; AKwUvBy1en9e6DqPjvjd6T05egLt8iiK/jSP27q1dde06QtzQCOlU58LazrVr3CXQEQ4g5qqOhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTXw3Fdefr7qac8LxZEIWwYGTQ5ysnrPtfR6u5VTWRMvykdi4g
	keDwPQYS+ORjkatiLI2QXaRgKXNpIvAAyJm0Vem99IDYipTAvg1yfPon
X-Gm-Gg: AYBFou32MBG+uX+52UC8FX7/6WU5SrJyDtDUwYLZNWBUadtKesYMiRd30/7J5w6Fzs+
	PrQ9szhBuCIPb3/ytW1299k4qqlAocMndr3PdEMLcegUdO03Fao/U8gMZL1kenj7a6GA9rq5PHd
	amFyCAFD6TiPnMYDTOQW1h77yJozVaPJkQAhkjafrEZkMNvDLcgvqOAl9dW9wGLZTQP4jV+wpNF
	vHNuaik7TwMkmy/3U4AG7Z6A/H7bi2wEbdrrj8C/JoV9DH0pbVMWVIO6D2PJAY0R1UaR5gVFo08
	FDqZ3eUdhVaGnFlYbrKIq77zd6K+ZhnUdpj6L0Wvl74Xy1Uxm9OnG9rA8aRlAwp63mRPE9/3pJv
	HVrD8S26JUlhp6XQXv08SfbzjUGXDEclSDJGh9Dbq69tT1OxZob8Saf50UqMDenKhXEabc4iLFv
	LNoCnw7aOv47fEqP1RB9PzyOjbOAa79GmE7z6UkgZ9wl2PC4W0aUDngTygxo1XWRrtgMo0Hfv8O
	u1aXG6k4rsblwy2WflFmN0YfpYh6R1B/oZlOvOC07TqOevRgrFnCWQAQ3UCH1Ffr5BY8Eg7p9rQ
	bpqaxBPhyFe8z+X7hac5a9dr
X-Received: by 2002:a05:600c:4743:b0:4a1:d992:9476 with SMTP id 5b1f17b1804b1-4a1fdd460e0mr25240115e9.23.1792573619791;
        Wed, 21 Oct 2026 02:06:59 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc0b42bdsm41757565e9.0.2026.10.21.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:06:59 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Wed, 21 Oct 2026 11:06:51 +0200
Message-ID: <20261021090652.20333-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop>
References: <20261019162005.12888-1-parri.andrea@gmail.com> <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 11:49:08AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 19, 2026 at 06:20:03PM +0200, Andrea Parri wrote:

[...]

> > -		if (!torture_must_stop())
> > -			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> > +		torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>
> Is the theory here that a kthread_stop() will wake up this sleep anyway?
> And if so, would that work if the kthread_stop() already happened?
>
> (I do recall adding the torture_must_stop() checks due to delays at
> kthread_stop() time, but perhaps things have changed since then.)

Yes, that is the theory.  torture_hrtimeout_ns() does
set_current_state(TASK_IDLE) and then schedule_hrtimeout(), and
kthread_stop() sets KTHREAD_SHOULD_STOP before wake_up_process(),
which wakes TASK_IDLE sleepers.  So:

  - If kthread_stop() comes while do_pending sleeps, or between its
    set_current_state() and schedule(), the sleep ends right away.

  - If kthread_stop() has already happened, i.e., it comes between
    the kthread_should_stop() check and set_current_state(), the
    wakeup is lost, but KTHREAD_SHOULD_STOP stays set: do_pending
    sleeps for one full period and the loop then exits.  That is
    kthread_do_pending_ms plus up to 1ms of fuzz, so 3-4ms by
    default.

For comparison, without this patch do_pending leaves its loop at
torture_must_stop() and waits in torture_kthread_stopping(), which
sleeps in TASK_UNINTERRUPTIBLE for HZ/20 at a time, so it has the
same lost-wakeup window with a 50ms bound instead.

The next version says this in the changelog, which in the RFC only
says "kthread_stop() wakes it".

> >  		// Omit stutter_wait() because this function needs to do cleanup.
> > -	} while (!torture_must_stop());
> > +	}
> > +	/* The readers have stopped, so nothing new can be deferred. */
> > +	for_each_possible_cpu(cpu)
> > +		hazptr_torture_do_one_pending(cpu, &rand);
>
> Very good!
>
> But given these two lines, do we need the changes to the loop?

I believe so, at least for the loop condition.  The readers are
stopped after the writer, so during the writer's kthread_stop(), the
writer can be in ->sync() on a hazard pointer that a still-running
reader deferred, possibly from the iteration it was in when
torture_must_stop() became true.  If the loop still ended at
torture_must_stop(), do_pending would make that final pass right away
and then wait in torture_kthread_stopping(), so a hazard pointer
deferred after that pass would leave the writer in ->sync(), as in the
hang above.

The other two loop changes follow from that one: the unconditional
sleep keeps do_pending from spinning while the writer and the readers
are being stopped, and the all-CPU pass once torture_must_stop() only
bounds the writer's wait to one period, instead of up to nr_cpu_ids
periods.  I'm happy to drop the latter if you prefer the simpler loop.

> > +	/*
> > +	 * Stop do_pending only after the writer and the readers: the writer
> > +	 * may be waiting on hazard pointers that readers deferred.
> > +	 */
> > +	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> > +
>
> And this change looks good.

Thanks.  In the next version, I'll keep the original (longer) comments
as you suggested in the other subthread, and post this patch in one
series with two patches that make hazptrtorture catch the slot-owner
race, as you asked in the slot-owner thread.

Thanks,
  Andrea
