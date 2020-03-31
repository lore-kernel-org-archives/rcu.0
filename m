Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB2DC2D0F1
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465F20848
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saDy0un/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgCaRCp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36143 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731353AbgCaRCn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id b1so2217714ljp.3;
        Tue, 31 Mar 2020 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HZuGdxB+x0mWlELwgsKVlrZ7g66xEPOmCIgcev6cRk=;
        b=saDy0un/8sSw+q2znKEJCS5QDo1c/iC0dk11oKl+JOJfL4CehAZVMFFlcyu621sIuI
         TpW5C06zUV0WDCr/X9/mUTfAfTpcbjqBE98ukvR//mgALXjLvwcWhUmG2yPendEbBJeV
         C2jkfOTrcwrRfyZ9iEiFsTuZ2QY96LLf+hh6QBBR9ZpFP7dmieBaOthVuOTi/2jyDm6O
         EZX8gF8J1mFOVjktbw6zMgj7Y6WLKLvliXqkQNGs41Huv7GbNswxobuCSn0G7n1CuMKw
         aYizYm0bVR0VwwbhMRNHf2+N0ignpgtMJyOrgwLV7A5lXZAaYxj+WVQfuxUMQYe9QoQt
         rpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HZuGdxB+x0mWlELwgsKVlrZ7g66xEPOmCIgcev6cRk=;
        b=PR8Si+77WR/Ub1CBVRloO1D1i44Fo6xTFkE3f2siHUJ21nKMOuqHdsABS4msq8L0ql
         VNTZQ54Gs9T6N1CenhbQjRoygssyFjybwretPhSAy8TgaTC3GlMRnIB3y+T2+X5jkGDP
         twYi3tDY1E9oUGXs0ukkEBuQhD2PBwr5XkO9ZpAo28a/o2rXaSxJX+ROiOoGX+qKUh6W
         BQOygen1ynBfTKdY0T86F5BYbTgZXtAWYybJ7CQvVR1EjZrxOLcBtm8SGtXARekXWdxW
         ikqiwyRrWDrexFxn4ZKgr5jYhF99ioxFuhtH1mGpohPLaSYxTispCvNfEaGOcg3nVu2x
         KnYg==
X-Gm-Message-State: AGi0PuYk8L3dnAR4m215rUxUnE4zKIhAwEQb3MpMbsxm95jd+hOJogxH
        lF94tf+XpHW2O7icJCCepcs=
X-Google-Smtp-Source: APiQypJAzaqWR8QOVGnwEqbA0+F/7BL3cHgAFxPFWoMIz2nlJAcp6b/ae4HVuSEo264GCzY5Cs5SmQ==
X-Received: by 2002:a2e:3a19:: with SMTP id h25mr1985208lja.133.1585674160923;
        Tue, 31 Mar 2020 10:02:40 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 195sm6845074lfi.75.2020.03.31.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:40 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 31 Mar 2020 19:02:32 +0200
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331170232.GA28413@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331160119.GA27614@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> >
> > Paul was concerned about following scenario with hitting synchronize_rcu():
> > 1. Consider a system under memory pressure.
> > 2. Consider some other subsystem X depending on another system Y which uses
> >    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
> >    more memory.
> > 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
> >    This causes X to further allocate memory, further causing a chain
> >    reaction.
> > Paul, please correct me if I'm wrong.
> > 
> I see your point and agree that in theory it can happen. So, we should
> make it more tight when it comes to rcu_head attachment logic.
> 
Just adding more thoughts about such concern. Even though in theory we
can run into something like that. But also please note, that under high
memory pressure it also does not mean that (X) will always succeed with
further infinite allocations, so memory pressure is something common.
As soon as the situation becomes slightly better we do our work much
efficient.

Practically, i was trying to simulate memory pressure to hit synchronize_rcu()
on my test system. By just simulating head-less freeing(for any object) and
by always dynamic attaching path. So i could trigger it, but that was really
hard to achieve and it happened only few times. So that was not like a constant
hit. What i got constantly were:

- System got recovered and proceed with "normal" path;
- The OOM hit as a final step, when the system is run out of memory fully.

So, practically i have not seen massive synchronize_rcu() hit.

--
Vlad Rezki
