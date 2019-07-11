Return-Path: <SRS0=upIL=VI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4194DC742A2
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 23:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1412820872
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CxBe3d8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfGKXwm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:52:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44474 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfGKXwm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Jul 2019 19:52:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so3659641pgl.11
        for <rcu@vger.kernel.org>; Thu, 11 Jul 2019 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vzPJBuv0k8P0t8Fk03qEA7CPumyNmMWBbrpcTz+B5LE=;
        b=CxBe3d8Zwlq5eL/iHH4cKObNrwN70wlF8xtsD1I9rfzWGpI08HFrr4wIWB2T69jow5
         b2lv6BT26WXPLNNrt1kHYxqidntzBEQOohmGQyo0s/zVMREIMGcPNNnH2ajWazjZ27tN
         P6OQ0nVIq6uS31nbqOg1g6gOYFDBjP6C+Y7qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vzPJBuv0k8P0t8Fk03qEA7CPumyNmMWBbrpcTz+B5LE=;
        b=CEIJZdXTKGU2Er9Ai0xENt9CcwWFU5u5kFpKl7I0iuie5qh84yh+3IBjG3tNWNfY2y
         u8Sfx7z35WyTlMWltckaHQgqSPp8wFPQ5Y6PtWPZmGYpLojFATWQip/p3lxQlpkSXdsp
         l0GoZOodbCfaV4SORQwUxjMj8AuzNATI7ItS3s+mn1UbRBykM+o6Fb3jmcNC3tJenjVW
         CwdRzZ0SBy9aIT5inxBO7/8gXiwweWMUu9urUIYcR/WCsP+LeXPZWCn8IExRk1UU6A3U
         +hdONkqaHF3xSI5D5EQkzE44UXfWhs7hjvwWAlzkeNnw1Ub4si9pwpUhgPmyyMZI9Agq
         qSVg==
X-Gm-Message-State: APjAAAWwghg4TsBmx5fYD1OrnEgE2V0VywXbRqXXRa+6uJ59jaHkoiH+
        s3a46ue2nGkOt8QApZYbZXU=
X-Google-Smtp-Source: APXvYqwIJ+xh/ZMSwOrZyW9D85A/Q5tV1WJbBUxRCaU5JBaWiRNgZb7BBjzCKyyOKdbk76jwZnPfNQ==
X-Received: by 2002:a63:d950:: with SMTP id e16mr7508053pgj.271.1562889161442;
        Thu, 11 Jul 2019 16:52:41 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q69sm8518053pjb.0.2019.07.11.16.52.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:52:40 -0700 (PDT)
Date:   Thu, 11 Jul 2019 19:52:39 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 0/6] Harden list_for_each_entry_rcu() and family
Message-ID: <20190711235239.GA221389@google.com>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 11, 2019 at 07:43:55PM -0400, Joel Fernandes (Google) wrote:
> Hi,
> This series aims to provide lockdep checking to RCU list macros.
> 
> RCU has a number of primitives for "consumption" of an RCU protected pointer.
> Most of the time, these consumers make sure that such accesses are under a RCU
> reader-section (such as rcu_dereference{,sched,bh} or under a lock, such as
> with rcu_dereference_protected()).
> 
> However, there are other ways to consume RCU pointers, such as by
> list_for_each_entry_rcu or hlist_for_each_enry_rcu. Unlike the rcu_dereference
> family, these consumers do no lockdep checking at all. And with the growing
> number of RCU list uses (1000+), it is possible for bugs to creep in and go
> unnoticed which lockdep checks can catch.

I forgot to add in my cover letter, I have kept this option default-disabled
under a new config: CONFIG_PROVE_RCU_LIST. This is so that until all users
are converted to pass the optional argument, we should keep the check
disabled. There are about a 1000 or so users and it is not possible to pass
in the optional lockdep expression in a single series since it is done on a
case-by-case basis. I did convert a few users in this series itself.

Also, I plans to update the RCU documentation as well which I will do, but do
review this series and thank you!

