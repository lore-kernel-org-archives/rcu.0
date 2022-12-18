Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B7C4167B
	for <rcu@archiver.kernel.org>; Sun, 18 Dec 2022 23:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiLRX1c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 18:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiLRX1D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 18:27:03 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F9D13F
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 15:26:13 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j16so7092696qtv.4
        for <rcu@vger.kernel.org>; Sun, 18 Dec 2022 15:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLCRUSrqkKw7xK5nrqxqfculj6FjEoU058KsQo8kQeE=;
        b=jH1BdJusJlZrFG8z70t0PnqCbRyvjRuAnEPvm14p/rwaEvMHJDUR2ijNrQSy1WReFG
         aXiSPKMRkrG36ljTsv5M1BAnZb5CE9aHTHQfw6Kesa2iQRD6AUqzFU85lMH8kWx1FbZr
         zDhs9HQeskuvtOaQztd7oLRRabh8CoesGJWgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLCRUSrqkKw7xK5nrqxqfculj6FjEoU058KsQo8kQeE=;
        b=GFOxhwfFnvvrGXG936irbI6arPqLXBo4QMS2Akrd6Z/c5UXL/Hy8OnTCTjtTZQ6QSo
         NLpc1CMmKJ9wFz55zfcCnbKcMNI6P9/FsuQ14tPj4k5ozPULWRp6yxaIQF4fy4dd11zE
         UHoKjpUmpSkVo8UzeX08k/bvhZ1wn9atlg5KgvauTJ95z8UcQFkc0ieY8PT/3WyXlH9/
         nOnDzcP7TlXL40TZwK5jgV+MU018mngmEsh6Ax/59aanSBr0HC6TCEoo2v7SWjSEH8Gw
         O7uuc9j2075jVaDOQ/SmsrKAKaffr1fLUJBglOWnhvlAVUc8O84PeTqTDVzdL1oLcbWl
         ngKA==
X-Gm-Message-State: ANoB5plrOlxIKpCxEt537HjmoOjckhGtbGYOx5oU6h3LikVZpYLKSC8P
        SykDRFx67uGAIblRgYbgKBjvrg==
X-Google-Smtp-Source: AA0mqf5xqz1js2bhJcmoQR2xPDOHjs925B8XFXTVHbrzD2FDBXi0zxa+00LCLlwrlzJuHsPticgRAg==
X-Received: by 2002:ac8:7f0c:0:b0:39c:da20:d489 with SMTP id f12-20020ac87f0c000000b0039cda20d489mr78352989qtk.30.1671405972918;
        Sun, 18 Dec 2022 15:26:12 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a15b300b006ce9e880c6fsm5836696qkk.111.2022.12.18.15.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 15:26:12 -0800 (PST)
Date:   Sun, 18 Dec 2022 23:26:11 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 2/2] srcu: Remove memory barrier "E" as it is not required
Message-ID: <Y5+hk6+WX2LwZ7hi@google.com>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <20221218191310.130904-3-joel@joelfernandes.org>
 <20221218214243.GA1990383@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218214243.GA1990383@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 10:42:43PM +0100, Frederic Weisbecker wrote:
> On Sun, Dec 18, 2022 at 07:13:09PM +0000, Joel Fernandes (Google) wrote:
> > During a flip, we have a full memory barrier before idx is incremented.
> > 
> > The effect of this seems to be to guarantee that, if a READER sees srcu_idx
> > updates (srcu_flip), then prior scans would not see its updates to counters on
> > that index.
> > 
> > That does not matter because of the following reason: If a prior scan did see
> > counter updates on the new index, that means the prior scan would would wait
> > for the reader when it probably did not need to.
> 
> I'm confused, isn't it actually what we want to prevent from?
> The point of the barrier here is to make sure that the inactive index that
> we just scanned is guaranteed to remain seen as inactive during the whole scan
> (minus the possible twice residual increments from a given task that we debated
> on Paul's patch, but we want the guarantee that the inactive index won't be
> incremented thrice by a given task or any further while we are scanning it).

I believe you are talking about the memory barrier after the flip, that's the
one that guarantees what you are talking about it, I feel. That is, readers
see the newly inactivated index eventually, so that we are not scanning
indefinitely.

For that, we need smp_mb() after the flip but before the second scan which is
a much needed memory barrier IMHO, and not what this patch is talking about.

> If some readers see the new index and increments the lock and we see that while
> we are scanning it, there is a risk that the GP is going to be delayed indefinetly.

The "new" index is the index after the flip, do you mean the "old" index?
i.e. the index before the flip? That is what barrier E is talking about, not
the index after the flip.

> 
> > @@ -982,14 +982,6 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
> >   */
> >  static void srcu_flip(struct srcu_struct *ssp)
> >  {
> > -	/*
> > -	 * Ensure that if a given reader sees the new value of ->srcu_idx, this
> > -	 * updater's earlier scans cannot have seen that reader's increments
> > -	 * (which is OK, because this grace period need not wait on that
> > -	 * reader).
> > -	 */
> > -	smp_mb(); /* E */  /* Pairs with B and C. */
> 
> That said, I've been starring at this very barrier for the whole day, and I'm
> wondering what does it match exactly on the other end?
> 
>       UPDATER                               READER
>       -------                               ------
>       idx = ssp->srcu_idx;                  idx = srcu_idx;
>       READ srcu_unlock_count[srcu_idx ^ 1]  srcu_lock_count[idx]++
>       smp_mb();                             smp_mb();
>       READ srcu_lock_count[srcu_idx ^ 1]    srcu_unlock_count[old_idx]++
>       smp_mb()
>       srcu_idx++;
> 
> For a true match, I would expect a barrier between srcu_idx read and
> srcu_lock_count write. I'm not used to ordering writes after reads.
> So what is the pattern here? I would expect something like the below
> but that doesn't match the above:

IMHO, it is matching updates to index and the lock count of a reader.

> 
> C rwrw
> 
> {}
> 
> 
> P0(int *X, int *Y)
> {
> 	int x;
> 
> 	x = READ_ONCE(*X);
> 	smp_mb();
> 	WRITE_ONCE(*Y, 1);
> }
> 
> P1(int *X, int *Y)
> {
> 
> 	int y;
> 
> 	y = READ_ONCE(*Y);
> 	smp_mb();
> 	WRITE_ONCE(*X, 1);
> }
> 
> exists (0:x=1 /\ 1:y=1)

Hmm, I guess first lets degenerate the real code to an access pattern:


    READER                            UPDATER

                		    scanner() {
				    	count_all_unlocks();
				    	smp_mb();
                                        count_all_locks(); (Y)
	            		    }

    rcu_read_lock() {
        idx = READ(idx); (X)
        lock_count[idx]++;

        smp_mb();    // mb B
    }

    rcu_read_unlock() {
        smp_mb();    // mb C
        unlock_count[idx]++;
    }
                                    srcu_flip() {
                                        smp_mb(); //E
                                        idx++; (X)
    rcu_read_lock() {
        idx = READ(idx);
        lock_count[idx]++; (Y)

        smp_mb();    // mb B
                                        smp_mb();
                                    }
    }


That becomes:

// READER
P0(int *X, int *Y)
{
	int r0;

 	r0 = READ_ONCE(*X);	// PP
 	smp_mb(); // B+C	// QQ
 	WRITE_ONCE(*Y, 1);	// RR
}

// UPDATER
P1(int *X, int *Y)
{
	int r1;

 	r1 = READ_ONCE(*Y);	// SS
 	smp_mb(); // E		// TT
 	WRITE_ONCE(*X, 1);	// UU
}

Impossible that:
exists (0:r0=1 /\ 1: r1:1)

Because if r0=1, there is PP ->rf UU relation. So because of the smp_mb(), it
is impossible that r1=1.

So "E" is saying, if a reader saw new idx, that is the "X" in the litmus
test, then previous scan where it count all the locks (SS) cannot see the
lock count updates made at the new index.

However, that does not matter IMHO because due to preemption after current
index is sampled, we have no control anyway over which lock counts are
incremented anyway, so this cannot effect correctness.

And if forward progress is a problem, we are doing a full memory barrier
after the flip anyway so I am not seeing the point of "E".

thanks,

 - Joel

