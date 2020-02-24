Return-Path: <SRS0=eHFP=4M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA75C11D2F
	for <rcu@archiver.kernel.org>; Mon, 24 Feb 2020 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E38020714
	for <rcu@archiver.kernel.org>; Mon, 24 Feb 2020 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCzZu9aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgBXQLt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:11:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36388 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgBXQLt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Feb 2020 11:11:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so7205814lfh.3;
        Mon, 24 Feb 2020 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dT/SyLKmpe9sG8DmvT5flFskfE0S96hCFL6E52t9dYE=;
        b=qCzZu9aIPTC8GZ0LZ09WmqXDNYp4fklD1BL9dEquCOQWYzgB0AEGgtyDVq5STwAvTn
         FILj8Mjvif4CmdRI+1srVEWLDRpxSXSqSQcwno6EMOwgJv42dw8hDtvNU2Ah0TkpLhs2
         mitPt50zLdJUVcDIMz6aj4vhUD/5wVqfS4ktYl14E7Vz9CkkxW04pjedHr3pZDhW2xF1
         LKcdDLD9bT/3U2Se/T/0W9Hda+Cg8yCtoMLjYWORV7vvUdMLiObHzExFypRj+NAns4Dz
         AvFBcB9eNSa9xvt6+wnWQChYXjeJ+WKljMCdxUeiMf/8wILNel6XGz2PZvHMvYsfecZ0
         jzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dT/SyLKmpe9sG8DmvT5flFskfE0S96hCFL6E52t9dYE=;
        b=VpPckgixD7VAj1LAp7oEu4ozMwDiuiIV/zu/tJkBvm8qKYECgzUyccNbQF+st9AQvY
         MxQmr0nC1UyIc6QPyZGaKdMnKn9X3P5xuwVGJ8OWVDXIwwaiGEk3kjhHYKuQO4m4WHLy
         5qJDjb59dbQxrjwCheh3VWs+9lUpOzLn+JZ8X1IQdSS/8pgiUzTU2/ksQyqPh0Uf9M9Q
         fgIpWXq6DZby4iazwRy0dsQKRcLgI6YuM6MPR6z7JGjZ63Qp8Q87T5pd/NQciteZu46P
         vhkmTYEC6RuOau2RY0DxNvqNmGbhBL1nxgGWIV/8HirfM46Xjx8ll1ssczWT1tPFDSGz
         qeWQ==
X-Gm-Message-State: APjAAAXTXGt2xZUC982Pv2J3LO9jVgM29STg1AaQwAapEeY/MMwsCA/A
        mk5ByY5k1eTwJQtSqD5znsM=
X-Google-Smtp-Source: APXvYqynLmBPyJr1btY1NobYmJeSnkFcTPR33J+NHhzHumsVCNfJ9yHy5ARrE8i6qquRX9XL2hSNtg==
X-Received: by 2002:a19:7b0a:: with SMTP id w10mr27755407lfc.90.1582560706930;
        Mon, 24 Feb 2020 08:11:46 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n14sm6480728lji.37.2020.02.24.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:11:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 24 Feb 2020 17:11:36 +0100
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 1/2] rcu: Support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200224161136.GA21167@pc636>
References: <20200215000031.GA14315@paulmck-ThinkPad-P72>
 <20200215000053.14456-1-paulmck@kernel.org>
 <20200224114551.GE110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224114551.GE110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> >  
> > +/*
> > + * This macro defines how many entries the "records" array
> > + * will contain. It is based on the fact that the size of
> > + * kfree_rcu_bulk_data structure becomes exactly one page.
> > + */
> > +#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
> > +
> 
> Why use the "magic" number "3" here? Could we just define struct
> kfree_rcu_bulk_data as:
> 
> struct kfree_rcu_bulk_data {
> 	struct kfree_rcu_bulk_data *next;
> 	struct rcu_head *head_free_debug;
> 	unsigned long nr_records;
> 	void *records[];
> }
> 
> ?
> 
> And the the above macro becomes:
> 
> #define KFREE_BULK_MAX_ENTR ((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
> 
That should work. I agree that looks better :)

We can fix that by submitting a separate patch.

Thank you!

--
Vlad Rezki
