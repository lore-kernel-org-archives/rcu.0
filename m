Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6FFC433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E948B23A79
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgLHPdS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgLHPdS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 10:33:18 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B2C0613D6;
        Tue,  8 Dec 2020 07:32:32 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id n142so6085777qkn.2;
        Tue, 08 Dec 2020 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NSzebNPhajLq432NNakK3AqX4FUCpmwsnxgH+v2U6H4=;
        b=rD85Gnws16zwR8LBE4ytRyXYYmkCOueu1ojR3EYl+JabsiBCgv8ReifyyQadQFkIfM
         owwkVIfGutlr03Pvee4vMEdppIHtrtIsBDGjGUewuMacTDXZHU3heSWNuq6hSC1OE4iV
         IW1CBXkmzBGLHrVe+leYaB+YOwV/qFLoKbwNmoKu8VzD+WClbkOQpUiXPYs4Nnf/jfVS
         sF0PCvi4A741IQpuErhcugSPly8Sau50i5yWB+W2DnQtyE2BunhDI+HlObdlRoOv64Vp
         VJQE4javnkKBEUGQklf9mMxBASkTqO6o8QBJz2/FZPSyMON4Lfn2lEnkj4A/NVX7sjN9
         phqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NSzebNPhajLq432NNakK3AqX4FUCpmwsnxgH+v2U6H4=;
        b=Vr5N39vfY5L6DJR9uMr9cat2xzuANSaAr6S9OMNHb2RtUaY3ZDijFqjBahpAzTxZnh
         iGxDGBX7j6aRaEQs+3D7ShTKlmVt1JNTkR1SR1juo6VDZk442NpKlZxF8WNAgOGofM0R
         NMO4ju/KuA30AlnbaKx12RrFqWchP5nlNZAPkquH0dsMtxOrEEy5YMqGTV/RZV3v/27R
         Fb+XbSJT1MBs/vKm2s3VKl/IRewxAlTskNZsnYnQIusOAXowY2YpP32nQaP4uJGs+XYs
         kdzUWgMhZnypfZBWY7OtlI1HEowhePEdGQ+5uLPplHAB+Ei/E1hQ63019Et3gOgOmWs6
         P9QA==
X-Gm-Message-State: AOAM533Ckhn1EDiUrWS5dBKeKNBwA/YSwJQTA/IVQ6L0OWtTtL3atGpb
        o3kJx19lvvrfDJN1IZYiuhM=
X-Google-Smtp-Source: ABdhPJycDXNDYNb34PZoZAjb+h10MHtfLAjdMtdyK4fk9jbtN12d8/thyy4A6Q4Htc9tzHzBBgXeTQ==
X-Received: by 2002:a37:8485:: with SMTP id g127mr8321683qkd.233.1607441551543;
        Tue, 08 Dec 2020 07:32:31 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d2sm5993826qtp.71.2020.12.08.07.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:32:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 48A3027C0060;
        Tue,  8 Dec 2020 10:32:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 08 Dec 2020 10:32:29 -0500
X-ME-Sender: <xms:ipzPXxpm6i5Zb8EIfBNNULO7NLbkasMxVFG7uNgZB_59hoPmoEZIrQ>
    <xme:ipzPXzrxdoW-TDNlSKIhPzwUeSL4Zb5HikjQYQD0TJBZDBlrFJ1P41q6wYEX2pq_A
    u2eFaw7dXAO6OCRPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:i5zPX-MpN1WwQTdwk9sMceBSfmHam309gNBlMH9UqmhB9iKBRQcklg>
    <xmx:i5zPX84zRpSR4FvL5twIkf76WGvHGUUHCPzqHj8Jl-BgJU2TQZMd_Q>
    <xmx:i5zPXw7nmtYEjttmlPWyZ3wL59wrA3jPWMvqDWcCyNUptjComaAMXQ>
    <xmx:jZzPXwiGFk6WtUM5IDtzG0Q4SUu7TjouQ7MSfbwjVGfWYdDJi7_ENp_jWyE>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD8441080067;
        Tue,  8 Dec 2020 10:32:26 -0500 (EST)
Date:   Tue, 8 Dec 2020 23:31:11 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC lockdep 4/4] lockdep/selftest: Add wait context selftests
Message-ID: <20201208153111.GJ3025@boqun-archlinux>
References: <20201208103112.2838119-1-boqun.feng@gmail.com>
 <20201208103112.2838119-5-boqun.feng@gmail.com>
 <20201208143324.GB2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208143324.GB2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 08, 2020 at 03:33:24PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 06:31:12PM +0800, Boqun Feng wrote:
> > These tests are added for two purposes:
> > 
> > *	Test the implementation of wait context checks and related
> > 	annotations.
> > 
> > *	Semi-document the rules for wait context nesting when
> > 	PROVE_RAW_LOCK_NESTING=y.
> 
> Documentation/locking/locktypes.rst should have that.
> 

Thanks for the pointer!

I miss it before, and it's really a comprehensive document for lock
nesting rules. Still I think more rules can be (and should be) put in
that document: a broader idea is the context nesting rule (e.g. whether
a spinlock_t is allowed in a hard irq handler). And the document
reminders me that I'm missing some locks (e.g local_lock) in the test
cases. So will improve both the document and the test cases in the next
version. In the meanwhile, feel free to point out any mistake or
misunderstanding of mine in the rules or the tests, I'm really still
learning through these locks with PREEMPT_RT into consideration, thanks!

Regards,
Boqun

> > The test cases are only avaible for PROVE_RAW_LOCK_NESTING=y, as wait
> > context checking makes more sense for that configuration.
> 
> Looks about right ;-)
