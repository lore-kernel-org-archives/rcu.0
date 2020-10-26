Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C220C4363A
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A84D2222C
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq3pZ6/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783509AbgJZPPU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:15:20 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46806 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783039AbgJZPPU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 11:15:20 -0400
Received: by mail-lj1-f175.google.com with SMTP id c21so10556851ljn.13;
        Mon, 26 Oct 2020 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymFwX4dMeWO3X/lArDe4pdm35TrYA8Kz/hMAxunSNTs=;
        b=iq3pZ6/QL6OMAVcMvrFMnH1DLI4OH8H7cZIKqo1wIUCGQls8T2Ro6vl24nuNS66i39
         1n4aOeHzimhTFvpeNNyqHSXxsdHiCTV7961Vh1j0/RIdXUUh7vfPw9EgQoojJjM1GIbP
         SePccVKqHjpMn2iFa52sFKDoftFLI8Sc8B3F9xTfRQcHlK6C90dV3D6T9cOqQTOtzMB9
         VEhkuuNnDKsSFho0KBPX39zlpQpW28t0W63Y4eGIO/cg8WOanlYSqdBLxWgUhc8/50YW
         wLtSt97cenoqHIDALpfpuN6b/PhPTtuqzvaiFMfsxRYtTHrZ920TFNyq1kncFEMCgZp6
         YYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymFwX4dMeWO3X/lArDe4pdm35TrYA8Kz/hMAxunSNTs=;
        b=s8qwNRNRq3sFfsJrtmqJlwIimj8GxqHZ2Aph+iYkMF40tjs9GbO7MBw6GryJmkukmr
         UtbLDn4ZZB5Nu253C6tokV6cCEZwfoHqGQVw0BTuc72cz31olHbsMXEKs+Iwol73WuRc
         tEInaUmc8ubXyRVUg1Ne5rAkYrdYd1QAd0irQuDR6HAly0uIQBVlMD7k1QZYZrgVgZ78
         ARJj+CUqU0fRIGCYM/r4yqs773UsnSSwpJGq8nYIqCCp8wIBtIzYsoAEagKKTGSp7GBs
         k6S4+Luv5q49uV/Pz37euJg6tkdIfX8c5fqCK8CG9XIQORJKxiVRvDxh5rGzSiDKiW3w
         gVAg==
X-Gm-Message-State: AOAM533MBcsp7NV9utBLJrL4ASbUowfhonVl5EamclCuqc0sLecM+wDY
        0MPBCoDihgRkAr5HAHHv2/8=
X-Google-Smtp-Source: ABdhPJx7L2+12gO/j37FRejcJ/XkwTqNVFm3xPzzs1Xo/tzk231g6fRUxZsozHLljba2yIitR2elGA==
X-Received: by 2002:a05:651c:3d0:: with SMTP id f16mr5618129ljp.454.1603725317660;
        Mon, 26 Oct 2020 08:15:17 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x19sm1071749lff.189.2020.10.26.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:15:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 26 Oct 2020 16:15:14 +0100
To:     Richard Palethorpe <rpalethorpe@suse.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alexander Potapenko <glider@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [BUG] Lockdep splat during kvfree_call_rcu and stack_depot_save
Message-ID: <20201026151514.GA3942@pc636>
References: <87a6w9uiz3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6w9uiz3.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello.

> Hello,
> 
> The kmem memcg selftest causes the following lockdep splat on 5.9+
> 
> [   67.534319] =============================
> [   67.534410] [ BUG: Invalid wait context ]
> [   67.534522] 5.9.1-22-default #125 Not tainted
> [   67.534647] -----------------------------
>
Working on it. We are aware about it.

Thanks!

--
Vlad Rezki
