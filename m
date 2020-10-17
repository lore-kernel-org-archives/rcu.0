Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0ADC433DF
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 05:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E2E20709
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 05:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j1Ea2sde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436738AbgJQFtm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436733AbgJQFtm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 01:49:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C0EC05BD10
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 20:19:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so4877714ilt.6
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 20:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJgUMZO3YTSbeM5AMCQb0/+aRiqChbCB39IRnkW7Nro=;
        b=j1Ea2sdeMEYWzpsqOCaXEkzCUYagNXrAn/nD1xOgdnU3Nk8EaZs6HLhgKerJQCTgaH
         uMuHf9RuOIta5gWWmc87pmEC1gYS/wbOPBwY3j6WTWAT03ylXTXpi2tXGH8I5no6HmS0
         xgZ0CpL/V2W7W/R829tYaS/blSkj2QiHcywnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJgUMZO3YTSbeM5AMCQb0/+aRiqChbCB39IRnkW7Nro=;
        b=UIVNjhDHLykEjqKH3Svtlz1UmUiFOZkDhjGZNroEsz70VxFJnIC4sa9WK/GbGJ3XrV
         b/enM6Pl5X1mNjqaGN9FOqVeSp1gyowTZQH6iW1e3KRXN6rIXsyjEIE099abWhYZChrE
         RoBVzhDlxXys+xpAFgQ3YQtTyW17DrJ8tBxGHnXlAvfNUPpcSfHmb9LXtk2afnUx8dns
         cPP8SsBXSGaKk9B0qjegWH9vcYkBDGbNH7l1lUMDEbn7d2+Bp5HxD0PN2ixh7R6xCNY/
         4eb9IMUbaNZXDZeq4SVtHUc2qL/97kYeYHQSlaFDtHSdSH4wRBlETA/HIMudp8dTz+Lw
         umQQ==
X-Gm-Message-State: AOAM530DM0C9MGQzSC1vrS8gT4jqT8ZHQJmR7hF0LlB24sURctZY0AgU
        t+8HIxulefZt13MP6bu5VNoa3A==
X-Google-Smtp-Source: ABdhPJwqqZuBXrStzbcWS274m3dqBdhvLdxCjevJYH0MQwp99RRhJ/egixNKM9ynkCNsjRgxu606+A==
X-Received: by 2002:a92:85d5:: with SMTP id f204mr5216560ilh.108.1602904783370;
        Fri, 16 Oct 2020 20:19:43 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id y75sm4132922iof.36.2020.10.16.20.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 20:19:42 -0700 (PDT)
Date:   Fri, 16 Oct 2020 23:19:41 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com, stern@rowland.harvard.edu
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017031941.GD4015033@google.com>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017012753.GB4015033@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
[..]
> > > + *
> > > + * Memory barrier is needed after adding to length for the case
> > > + * where length transitions from 0 -> 1. This is because rcu_barrier()
> > > + * should never miss an update to the length. So the update to length
> > > + * has to be seen *before* any modifications to the segmented list. Otherwise a
> > > + * race can happen.
> > > + * P0 (what P1 sees)	P1
> > > + * queue to list
> > > + *                      rcu_barrier sees len as 0
> > > + * set len = 1.
> > > + *                      rcu_barrier does nothing.
> > 
> > So that would be:
> > 
> >       call_rcu()                    rcu_barrier()
> >       --                            --
> >       WRITE(len, len + 1)           l = READ(len)
> >       smp_mb()                      if (!l)
> >       queue                            check next CPU...
> > 
> > 
> > But I still don't see against what it pairs in rcu_barrier.
> 
> Actually, for the second case maybe a similar reasoning can be applied
> (control dependency) but I'm unable to come up with a litmus test.
> In fact, now I'm wondering how is it possible that call_rcu() races with
> rcu_barrier(). The module should ensure that no more call_rcu() should happen
> before rcu_barrier() is called.
> 
> confused

So I made a litmus test to show that smp_mb() is needed also after the update
to length. Basically, otherwise it is possible the callback will see garbage
that the module cleanup/unload did.

C rcubarrier+ctrldep

(*
 * Result: Never
 *
 * This litmus test shows that rcu_barrier (P1) prematurely
 * returning by reading len 0 can cause issues if P0 does
 * NOT have a smb_mb() after WRITE_ONCE(len, 1).
 * mod_data == 2 means module was unloaded (so data is garbage).
 *)

{ int len = 0; int enq = 0; }

P0(int *len, int *mod_data, int *enq)
{
	int r0;

	WRITE_ONCE(*len, 1);
	smp_mb();		/* Needed! */
	WRITE_ONCE(*enq, 1);

	r0 = READ_ONCE(*mod_data);
}

P1(int *len, int *mod_data, int *enq)
{
	int r0;
	int r1;

	r1 = READ_ONCE(*enq);

	// barrier Just for test purpose ("exists" clause) to force the..
	// ..rcu_barrier() to see enq before len
	smp_mb();		
	r0 = READ_ONCE(*len);

	// implicit memory barrier due to conditional */
	if (r0 == 0)
		WRITE_ONCE(*mod_data, 2);
}

// Did P0 read garbage?
exists (0:r0=2 /\ 1:r0=0 /\ 1:r1=1)

