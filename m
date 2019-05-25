Return-Path: <SRS0=KF8c=TZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA4C04AB0
	for <rcu@archiver.kernel.org>; Sat, 25 May 2019 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24502168B
	for <rcu@archiver.kernel.org>; Sat, 25 May 2019 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tVo3uBLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEYIOs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 May 2019 04:14:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37101 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfEYIOs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 May 2019 04:14:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so5087890pll.4
        for <rcu@vger.kernel.org>; Sat, 25 May 2019 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1c/wOZB7UIcO4fhNsFW8JEtKnsulp1uLNI0yUTmwDCo=;
        b=tVo3uBLcpEIXXZnhVPqSswFuc4q2UlbviAt3R2V2Thcy9J19G8Vh9t8IKakn6eWu7P
         LF+dLcUy8MISmgvZ0VGCcUrlJOi0R9kMHNLpfYwqA4+5Un+SNXosWy9sZwuR5XURngkR
         S1XgD6r2KG9fhVaAYKrKbQt6RqcK7l5hP89YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1c/wOZB7UIcO4fhNsFW8JEtKnsulp1uLNI0yUTmwDCo=;
        b=S4QZFGh6hEoK5xZXi/FKEcqysd64EulfhjokXJ0tYazABQhBELZaoFg+Kh+oSJ6xUH
         1nfd0L5RsbTcBmQyqoHDFq/s+6E69t0MiDV3mYFeq/Z+XuCF6FEZ0OAzwbNr9dSSQHUE
         AVeHdg8A5qm/UrFrh1bM/0QIdoTVXGfWSUwrJ0UdAYNsTBH5PK50un+r6dNC32wBKDSM
         c0aFS/uTCpOz1f7YeCQuqyp5tSBq3js0Rv4xJWP1lzRkx3170zngR0NFIrNKscUsY/V0
         dr/Ily2A48YLqrM4FCoZaDMFpezU8kMZOj1y9/KBE02Ow9sUTGAywyFQoVlrmJh06sPT
         O5TA==
X-Gm-Message-State: APjAAAWQ9b97/yym7wx0xymlz8e2Z7fmkNglxkOxEKqAM/84CJbTspv7
        Uy0xnhXxQSxhfZThI5CT4GPVuA==
X-Google-Smtp-Source: APXvYqy398cjiqw83nLMzWHb1uka5NbJ8a1bov+JXtig8R0soLxRu+ibdZSFPg0qivDKo96oArfXwQ==
X-Received: by 2002:a17:902:10c:: with SMTP id 12mr111734693plb.61.1558772087333;
        Sat, 25 May 2019 01:14:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 25sm4607225pfp.76.2019.05.25.01.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 01:14:46 -0700 (PDT)
Date:   Sat, 25 May 2019 04:14:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] Remove some notrace RCU APIs
Message-ID: <20190525081444.GC197789@google.com>
References: <20190524234933.5133-1-joel@joelfernandes.org>
 <20190524232458.4bcf4eb4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524232458.4bcf4eb4@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 24, 2019 at 11:24:58PM -0400, Steven Rostedt wrote:
> On Fri, 24 May 2019 19:49:28 -0400
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > The series removes users of the following APIs, and the APIs themselves, since
> > the regular non - _notrace variants don't do any tracing anyway.
> >  * hlist_for_each_entry_rcu_notrace
> >  * rcu_dereference_raw_notrace
> > 
> 
> I guess the difference between the _raw_notrace and just _raw variants
> is that _notrace ones do a rcu_check_sparse(). Don't we want to keep
> that check?

This is true.

Since the users of _raw_notrace are very few, is it worth keeping this API
just for sparse checking? The API naming is also confusing. I was expecting
_raw_notrace to do fewer checks than _raw, instead of more. Honestly, I just
want to nuke _raw_notrace as done in this series and later we can introduce a
sparse checking version of _raw if need-be. The other option could be to
always do sparse checking for _raw however that used to be the case and got
changed in http://lists.infradead.org/pipermail/linux-afs/2016-July/001016.html

thanks a lot,

 - Joel

> 
> -- Steve
